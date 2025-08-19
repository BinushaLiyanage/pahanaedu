<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.business.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }

    List<User> userList = (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #343a40;
            padding-top: 20px;
            position: fixed;
        }
        .sidebar a {
            display: block;
            padding: 12px;
            color: #fff;
            text-decoration: none;
        }
        .sidebar a:hover {
            background: #495057;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
            width: 100%;
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <h4 class="text-center text-white">PahanaEdu</h4>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="BookServlet?action=list">Books</a>
    <a href="CustomerServlet?action=list">Customers</a>
    <a href="BillServlet?action=list">Billing</a>
    <a href="UserServlet?action=list" class="bg-dark">Users</a>
    <a href="logout.jsp">Logout</a>
</div>

<!-- Content -->
<div class="content">
    <div class="container">
        <h2>User Management</h2>

        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-2"></i>
            <%= request.getAttribute("success") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% request.removeAttribute("success"); %>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>
            <%= request.getAttribute("error") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% request.removeAttribute("error"); %>
        <% } %>

        <a href="user-form.jsp" class="btn btn-primary mb-3">Add New User</a>
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (userList != null && !userList.isEmpty()) {
                    for (User u : userList) {
            %>
            <tr>
                <td><%= u.getId() %></td>
                <td><%= u.getUsername() %></td>
                <td><%= u.getRole() %></td>
                <td>
                    <a href="UserServlet?action=delete&id=<%= u.getId() %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure you want to delete this user?');">
                        Delete
                    </a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="4" class="text-center">No users found</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>