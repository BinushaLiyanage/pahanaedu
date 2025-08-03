<%@ page import="com.pahanaedu.model.Book" %>
<%
    Book book = (Book) request.getAttribute("book");
    boolean isEdit = book != null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= isEdit ? "Edit Book" : "Add New Book" %> - PahanaEdu</title>
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
    <div class="card p-4 shadow-sm">
        <h3 class="mb-4"><%= isEdit ? "Edit Book" : "Add New Book" %></h3>
        <form action="BookServlet" method="post">
            <% if (isEdit) { %>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= book.getId() %>">
            <% } %>

            <div class="mb-3">
                <label class="form-label">Title</label>
                <input type="text" name="title" value="<%= isEdit ? book.getTitle() : "" %>" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Author</label>
                <input type="text" name="author" value="<%= isEdit ? book.getAuthor() : "" %>" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Price</label>
                <input type="number" step="0.01" name="price" value="<%= isEdit ? book.getPrice() : "" %>" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Quantity</label>
                <input type="number" name="quantity" value="<%= isEdit ? book.getQuantity() : "" %>" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">
                <%= isEdit ? "Update Book" : "Add Book" %>
            </button>
        </form>

        <a href="BookServlet" class="btn btn-secondary w-100 mt-3">
            <i class="bi bi-arrow-left"></i> View All Books
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
