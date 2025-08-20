<%@ page import="java.util.*, com.pahanaedu.business.model.Book, com.pahanaedu.business.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    boolean isAdmin = "ADMIN".equalsIgnoreCase(loggedInUser.getRole());

    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
    String message = (String) request.getAttribute("message");
    String messageType = (String) request.getAttribute("messageType");
    String keyword = request.getAttribute("keyword") != null ? (String) request.getAttribute("keyword") : "";
    String sortBy = request.getAttribute("sortBy") != null ? (String) request.getAttribute("sortBy") : "id";
    int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 1;
    int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book List - PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            background-color: #e3f2fd;
        }

        .sidebar {
            width: 250px;
            background-color: #1565c0;
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
            background-color: #1976d2;
            color: white;
        }

        .sidebar a.bg-primary {
            background-color: #1976d2 !important;
        }

        .main-content {
            flex: 1;
            background-color: white;
            padding: 20px;
        }

        .table thead th {
            background-color: #1565c0;
            color: white;
            border: none;
        }

        .btn-primary {
            background-color: #1565c0;
            border-color: #1565c0;
        }

        .btn-primary:hover {
            background-color: #1976d2;
            border-color: #1976d2;
        }

        .page-link {
            color: #1565c0;
        }

        .page-item.active .page-link {
            background-color: #1565c0;
            border-color: #1565c0;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h4 class="text-center">📚 PahanaEdu</h4>
    <hr class="bg-light">
    <a href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="BookServlet" class="bg-primary"><i class="bi bi-book"></i> Books</a>
    <a href="CustomerServlet"><i class="bi bi-people"></i> Customers</a>
    <a href="BillServlet"><i class="bi bi-receipt"></i> Billing</a>
    <% if (isAdmin) { %>
    <a href="UserServlet?action=list"><i class="bi bi-people-fill"></i> Users</a>
    <% } %>
    <hr class="bg-light">
    <a href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Book List</h2>
        <% if (isAdmin) { %>
        <a href="book-form.jsp" class="btn btn-success"><i class="bi bi-plus-lg"></i> Add New Book</a>
        <% } else { %>
        <div class="text-muted">
            <i class="bi bi-info-circle"></i> View Only Mode
        </div>
        <% } %>
    </div>

    <% if (message != null) { %>
    <div class="alert alert-<%= messageType != null ? messageType : "success" %> alert-dismissible fade show" role="alert">
        <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <form class="row g-2 mb-3" method="get" action="BookServlet">
        <div class="col-md-4">
            <input type="text" name="keyword" class="form-control" placeholder="Search books..." value="<%= keyword %>">
        </div>
        <div class="col-md-3">
            <select name="sortBy" class="form-select">
                <option value="id" <%= "id".equals(sortBy) ? "selected" : "" %>>Sort by ID</option>
                <option value="title" <%= "title".equals(sortBy) ? "selected" : "" %>>Sort by Title</option>
                <option value="author" <%= "author".equals(sortBy) ? "selected" : "" %>>Sort by Author</option>
                <option value="price" <%= "price".equals(sortBy) ? "selected" : "" %>>Sort by Price</option>
            </select>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100"><i class="bi bi-search"></i> Search</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Price</th>
                <th>Quantity</th>
                <% if (isAdmin) { %>
                <th>Edit</th>
                <th>Delete</th>
                <% } %>
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
                <% if (isAdmin) { %>
                <td>
                    <a href="BookServlet?action=edit&id=<%= book.getId() %>" class="btn btn-warning btn-sm">
                        <i class="bi bi-pencil"></i> Edit
                    </a>
                </td>
                <td>
                    <%
                        boolean isUsedInBills = false; // You'd get this from your DAO
                        if (isUsedInBills) { %>
                    <button class="btn btn-secondary btn-sm" disabled title="Book is used in bills">
                        <i class="bi bi-trash"></i> Cannot Delete
                    </button>
                    <% } else { %>
                    <a href="BookServlet?action=delete&id=<%= book.getId() %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure you want to delete this book?')">
                        <i class="bi bi-trash"></i> Delete
                    </a>
                    <% } %>
                </td>
                <% } %>
            </tr>
            <%   }
            } else { %>
            <tr>
                <td colspan="<%= isAdmin ? "7" : "5" %>" class="text-center">No books found.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <% if (!isAdmin) { %>
    <div class="alert alert-info mt-3" role="alert">
        <i class="bi bi-info-circle me-2"></i>
        <strong>Note:</strong> You are viewing books in read-only mode. Contact an administrator to make changes.
    </div>
    <% } %>

    <nav>
        <ul class="pagination">
            <% for (int i = 1; i <= totalPages; i++) { %>
            <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                <a class="page-link" href="BookServlet?page=<%= i %>&keyword=<%= keyword %>&sortBy=<%= sortBy %>"><%= i %></a>
            </li>
            <% } %>
        </ul>
    </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>