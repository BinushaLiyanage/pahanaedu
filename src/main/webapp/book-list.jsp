<%@ page import="java.util.*, com.pahanaedu.model.Book" %>
<%
    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
    String message = (String) request.getAttribute("message");
    String messageType = (String) request.getAttribute("messageType");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book List - PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { min-height: 100vh; display: flex; }
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
        .sidebar a:hover { background-color: #0b5ed7; }
        .main-content { flex: 1; background-color: #f8f9fa; padding: 20px; }
    </style>
</head>
<body>

<div class="sidebar">
    <h4 class="text-center">📚 PahanaEdu</h4>
    <hr class="bg-light">
    <a href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="BookServlet" class="bg-primary"><i class="bi bi-book"></i> Books</a>
    <a href="#"><i class="bi bi-people"></i> Customers</a>
    <a href="#"><i class="bi bi-receipt"></i> Billing</a>
    <hr class="bg-light">
    <a href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Book List</h2>
        <a href="book-form.jsp" class="btn btn-success"><i class="bi bi-plus-lg"></i> Add New Book</a>
    </div>

    <% if (message != null) { %>
    <div class="alert alert-<%= messageType != null ? messageType : "success" %> alert-dismissible fade show" role="alert">
        <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>ID</th><th>Title</th><th>Author</th><th>Price</th><th>Quantity</th><th>Edit</th><th>Delete</th>
            </tr>
            </thead>
            <tbody>
            <% if (bookList != null && !bookList.isEmpty()) {
                for (Book book : bookList) { %>
            <tr>
                <td><%= book.getId() %></td>
                <td><%= book.getTitle() %></td>
                <td><%= book.getAuthor() %></td>
                <td><%= book.getPrice() %></td>
                <td><%= book.getQuantity() %></td>
                <td><a href="BookServlet?action=edit&id=<%= book.getId() %>" class="btn btn-warning btn-sm">Edit</a></td>
                <td><a href="BookServlet?action=delete&id=<%= book.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a></td>
            </tr>
            <%   }
            } else { %>
            <tr><td colspan="7" class="text-center">No books found.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
