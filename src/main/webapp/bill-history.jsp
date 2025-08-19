<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.pahanaedu.business.dao.BillDAO, com.pahanaedu.business.model.Bill" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
  BillDAO billDAO = new BillDAO();
  List<Bill> bills = billDAO.getAllBills();
  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Bill History</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body {
      min-height: 100vh;
      display: flex;
      background-color: #f8f9fa;
    }
    .sidebar {
      width: 250px;
      background: #0d6efd;
      color: #fff;
      flex-shrink: 0;
    }
    .sidebar .nav-link {
      color: #fff;
      padding: 12px 20px;
      font-size: 15px;
    }
    .sidebar .nav-link:hover,
    .sidebar .nav-link.active {
      background: #0b5ed7;
      border-radius: 4px;
    }
    .sidebar h4 {
      padding: 20px;
      margin: 0;
      text-align: center;
      font-weight: bold;
    }
    .main-content {
      flex-grow: 1;
      padding: 20px;
    }
  </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar d-flex flex-column p-3">
  <h4>PahanaEdu</h4>
  <hr class="bg-light">
  <ul class="nav nav-pills flex-column mb-auto">
    <li><a href="dashboard.jsp" class="nav-link"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
    <li><a href="BookServlet" class="nav-link"><i class="bi bi-book"></i> Books</a></li>
    <li><a href="CustomerServlet" class="nav-link"><i class="bi bi-people"></i> Customers</a></li>
    <li><a href="BillServlet" class="nav-link"><i class="bi bi-receipt"></i> Billing</a></li>
    <li><a href="bill-history.jsp" class="nav-link active"><i class="bi bi-clock-history"></i> Billing History</a></li>
  </ul>
  <hr class="bg-light">
  <a href="logout.jsp" class="nav-link"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
  <h2>Bill History</h2>
  <table class="table table-striped table-hover mt-3">
    <thead class="table-dark">
    <tr>
      <th>Bill ID</th>
      <th>Customer</th>
      <th>Total (LKR)</th>
      <th>Date & Time</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
      if (bills != null) {
        for (Bill bill : bills) {
    %>
    <tr>
      <td><%= bill.getId() %></td>
      <td><%= bill.getCustomerName() %></td>
      <td><%= bill.getTotalAmount() %></td>
      <td><%= bill.getBillDate() %></td>
      <td>
        <a href="BillServlet?action=view&id=<%= bill.getId() %>" class="btn btn-sm btn-primary">View</a>
      </td>
    </tr>
    <%
        }
      }
    %>
    </tbody>
  </table>
</div>

</body>
</html>
