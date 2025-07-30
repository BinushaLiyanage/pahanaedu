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
    <title>Dashboard - PahanaEdu</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f3f4f6;
        }

        .header {
            background: #2563eb;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 22px;
            font-weight: bold;
        }

        .container {
            padding: 40px;
            text-align: center;
        }

        .card {
            background: white;
            display: inline-block;
            padding: 25px 35px;
            margin: 20px;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
            width: 220px;
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-title {
            font-size: 18px;
            margin-bottom: 15px;
            color: #1f2937;
        }

        .card a {
            text-decoration: none;
            color: #2563eb;
            font-weight: 500;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            color: #6b7280;
        }

        .logout-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #ef4444;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
        }

        .logout-button:hover {
            background: #dc2626;
        }
    </style>
</head>
<body>

<div class="header">
    Welcome, <%= username %>
</div>

<div class="container">

    <div class="card">
        <div class="card-title">Manage Books</div>
        <a href="book-form.jsp">Go to Book Section</a>
    </div>

    <div class="card">
        <div class="card-title">View Customers</div>
        <a href="#">Go to Customers</a>
    </div>

    <div class="card">
        <div class="card-title">Billing System</div>
        <a href="#">Go to Billing</a>
    </div>

    <br>
    <a href="logout.jsp" class="logout-button">Logout</a>
</div>

<div class="footer">
    © 2025 PahanaEdu Bookshop System
</div>

</body>
</html>
