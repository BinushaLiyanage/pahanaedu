<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
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
        }
        .sidebar {
            width: 250px;
            background-color: #0d6efd;
            color: white;
            display: flex;
            flex-direction: column;
            padding-top: 20px;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            display: block;
        }
        .sidebar a:hover {
            background-color: #0b5ed7;
        }
        .main-content {
            flex: 1;
            background-color: #f8f9fa;
            padding: 20px;
        }
    </style>
</head>
<body>


<div class="sidebar">
    <h4 class="text-center">📚 PahanaEdu</h4>
    <hr class="bg-light">

    <a href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="BookServlet"><i class="bi bi-book"></i> Books</a>
    <a href="#"><i class="bi bi-people"></i> Customers</a>
    <a href="#"><i class="bi bi-receipt"></i> Billing</a>
    <hr class="bg-light">
    <a href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>


<div class="main-content">
    <h2>Welcome, <%= username %> 👋</h2>
    <p>This is your admin dashboard. Use the menu to manage books, customers, and billing.</p>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
