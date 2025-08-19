<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.pahanaedu.business.dao.BillDAO" %>
<%@ page import="com.pahanaedu.business.model.Bill" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.business.dao.BookDAO" %>
<%@ page import="com.pahanaedu.business.model.Book" %>
<%@ page import="com.pahanaedu.business.dao.CustomerDAO" %>
<%@ page import="com.pahanaedu.business.model.Customer" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
    BillDAO billDAO = new BillDAO();
    List<Bill> bills = billDAO.getAllBills();
    int billSize = bills != null ? bills.size() : 0;
    BookDAO bookDAO = new BookDAO();
     List<Book> books = bookDAO.selectAllBooks();
     int bookSize = books != null ? books.size() : 0;

    CustomerDAO customerDAO = new CustomerDAO();
    List<Customer> customers = customerDAO.selectAllCustomers();
    int customerSize = customers != null ? customers.size() : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            background-color: #f8fafc;
        }
        .sidebar {
            width: 280px;
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
            color: white;
            display: flex;
            flex-direction: column;
            padding-top: 0;
            box-shadow: 4px 0 15px rgba(0,0,0,0.1);
        }
        .sidebar-header {
            background: rgba(255,255,255,0.1);
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .sidebar-header h4 {
            margin: 0;
            font-weight: 700;
            font-size: 1.4rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }
        .nav-section {
            padding: 20px 0;
        }
        .nav-section-title {
            color: rgba(255,255,255,0.7);
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 0 20px 15px;
        }
        .sidebar a {
            color: rgba(255,255,255,0.9);
            text-decoration: none;
            padding: 14px 20px;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        .sidebar a i {
            width: 20px;
            margin-right: 12px;
            font-size: 1.1rem;
        }
        .sidebar a:hover {
            background: rgba(255,255,255,0.15);
            border-left-color: white;
            color: white;
            transform: translateX(5px);
        }
        .sidebar a.active {
            background: rgba(255,255,255,0.2);
            border-left-color: white;
            color: white;
        }
        .main-content {
            flex: 1;
            padding: 0;
        }
        .top-bar {
            background: white;
            padding: 20px 30px;
            border-bottom: 1px solid #e5e7eb;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .content-area {
            padding: 30px;
        }
        .welcome-card {
            background: linear-gradient(135deg, #1e40af, #3b82f6);
            color: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 25px rgba(59,130,246,0.3);
        }
        .welcome-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .welcome-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin: 0;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border-left: 4px solid #3b82f6;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .stat-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #3b82f6, #1e40af);
            color: white;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 15px;
        }
        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #1e40af;
            margin-bottom: 5px;
        }
        .stat-label {
            color: #6b7280;
            font-weight: 500;
        }
        .quick-actions {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        .section-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1e40af;
            margin-bottom: 20px;
        }
        .action-btn {
            display: inline-flex;
            align-items: center;
            padding: 12px 24px;
            background: linear-gradient(135deg, #3b82f6, #1e40af);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            margin: 5px 10px 5px 0;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59,130,246,0.4);
            color: white;
        }
        .action-btn i {
            margin-right: 8px;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-header">
        <h4>PahanaEdu</h4>
    </div>

    <div class="nav-section">
        <div class="nav-section-title">Main</div>
        <a href="dashboard.jsp" class="active">
            <i class="bi bi-speedometer2"></i>
            Dashboard
        </a>
    </div>

    <div class="nav-section">
        <div class="nav-section-title">Management</div>
        <a href="BookServlet">
            <i class="bi bi-book"></i>
            Books
        </a>
        <a href="CustomerServlet">
            <i class="bi bi-people"></i>
            Customers
        </a>
        <a href="BillServlet">
            <i class="bi bi-receipt"></i>
            Billing
        </a>
        <a href="UserServlet">
            <i class="bi bi-people-fill"></i>
            Users
        </a>

        <a href="bill-history.jsp">
            <i class="bi bi-clock-history"></i>
            Bill History
        </a>
    </div>
    <div style="margin-top: auto; padding: 20px 0;">
        <a href="logout.jsp">
            <i class="bi bi-box-arrow-right"></i>
            Logout
        </a>
    </div>
</div>

<div class="main-content">
    <div class="top-bar">
        <div class="d-flex justify-content-between align-items-center">
            <h5 class="mb-0" style="color: #1e40af; font-weight: 600;">Admin Dashboard</h5>
            <div style="color: #6b7280;">
                <i class="bi bi-person-circle me-2"></i>
                <%= username %>
            </div>
        </div>
    </div>

    <div class="content-area">
        <div class="welcome-card">
            <div class="welcome-title">Welcome back, <%= username %>! 👋</div>
            <p class="welcome-subtitle">Here's what's happening with your billing system today.</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-book"></i>
                </div>
                <div class="stat-value"><%= bookSize %></div>
                <div class="stat-label">Total Books</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-people"></i>
                </div>
                <div class="stat-value"><%= customerSize %></div>
                <div class="stat-label">Active Customers</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-receipt"></i>
                </div>
                <div class="stat-value"><%= billSize %></div>
                <div class="stat-label">Total Bills</div>
            </div>


        </div>

        <div class="quick-actions">
            <div class="section-title">Quick Actions</div>
            <a href="BillServlet?action=new" class="action-btn">
                <i class="bi bi-plus-circle"></i>
                Create New Bill
            </a>
            <a href="BookServlet?action=add" class="action-btn">
                <i class="bi bi-book-half"></i>
                Add New Book
            </a>
            <a href="CustomerServlet?action=add" class="action-btn">
                <i class="bi bi-person-plus"></i>
                Add Customer
            </a>
            <a href="BillServlet?action=reports" class="action-btn">
                <i class="bi bi-bar-chart"></i>
                View Reports
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>