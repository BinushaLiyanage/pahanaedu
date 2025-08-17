<%@ page import="java.util.*, com.pahanaedu.business.model.Customer" %>
<%
    List<Customer> customerList = (List<Customer>) request.getAttribute("customerList");
    String message = (String) request.getAttribute("message");
    String messageType = (String) request.getAttribute("messageType");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer List - PahanaEdu</title>
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
    <a href="BookServlet"><i class="bi bi-book"></i> Books</a>
    <a href="CustomerServlet" class="bg-primary"><i class="bi bi-people"></i> Customers</a>
    <a href="BillServlet"><i class="bi bi-receipt"></i> Billing</a>
    <hr class="bg-light">
    <a href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Customer List</h2>
        <a href="customer-form.jsp" class="btn btn-success"><i class="bi bi-plus-lg"></i> Add New Customer</a>
    </div>

    <% if (message != null) { %>
    <div class="alert alert-<%= messageType != null ? messageType : "success" %> alert-dismissible fade show" role="alert">
        <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <div class="table-responsive">

        <form class="d-flex mb-3" method="get" action="CustomerServlet">
            <%
                String search = (String) request.getAttribute("search");
            %>
            <input type="text" name="search" class="form-control me-2" placeholder="Search..." value="<%= (search != null) ? search : "" %>">


            <button type="submit" class="btn btn-primary">Search</button>
        </form>


        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Account Number</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
            </thead>
            <tbody>
            <% if (customerList != null && !customerList.isEmpty()) {
                for (Customer customer : customerList) { %>
            <tr>
                <td><%= customer.getId() %></td>
                <td><%= customer.getAccountNumber() %></td>
                <td><%= customer.getName() %></td>
                <td><%= customer.getEmail() %></td>
                <td><%= customer.getPhone() %></td>
                <td><%= customer.getAddress() %></td>
                <td><a href="CustomerServlet?action=edit&id=<%= customer.getId() %>" class="btn btn-warning btn-sm">Edit</a></td>
                <td><a href="CustomerServlet?action=delete&id=<%= customer.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a></td>
            </tr>
            <%   }
            } else { %>
            <tr><td colspan="8" class="text-center">No customers found.</td></tr>
            <% } %>
            </tbody>

        </table>

        <%
            Integer currentPage = (Integer) request.getAttribute("currentPage");
            Integer totalPages = (Integer) request.getAttribute("totalPages");
            String searchTerm = (String) request.getAttribute("search");
            String searchQuery = (searchTerm != null && !searchTerm.isEmpty()) ? "&search=" + searchTerm : "";
        %>

        <nav>
            <ul class="pagination justify-content-center">
                <% for (int i = 1; i <= totalPages; i++) { %>
                <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                    <a class="page-link" href="CustomerServlet?page=<%= i %><%= searchQuery %>"><%= i %></a>
                </li>
                <% } %>
            </ul>
        </nav>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
