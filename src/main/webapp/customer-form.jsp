<%@ page import="com.pahanaedu.business.model.Customer" %>
<%
    Customer customer = (Customer) request.getAttribute("customer");
    boolean isEdit = customer != null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= isEdit ? "Edit Customer" : "Add New Customer" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #e0ecff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-card {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 500px;
        }
    </style>
</head>
<body>

<div class="form-card">
    <h3 class="text-center mb-4"><%= isEdit ? "Edit Customer" : "Add New Customer" %></h3>
    <form action="CustomerServlet" method="post">
        <% if (isEdit) { %>
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= customer.getId() %>">
        <% } %>

        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" name="name" class="form-control" value="<%= isEdit ? customer.getName() : "" %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" value="<%= isEdit ? customer.getEmail() : "" %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="text" name="phone" class="form-control" value="<%= isEdit ? customer.getPhone() : "" %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Address</label>
            <input type="text" name="address" class="form-control" value="<%= isEdit ? customer.getPhone() : "" %>" required>
        </div>



        <button type="submit" class="btn btn-primary w-100"><%= isEdit ? "Update" : "Add" %> Customer</button>
    </form>

    <a href="CustomerServlet" class="btn btn-secondary w-100 mt-3">Back to Customer List</a>
</div>

</body>
</html>
