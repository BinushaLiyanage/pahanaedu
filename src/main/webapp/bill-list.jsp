<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.business.model.Bill" %>
<%
    List<Bill> billList = (List<Bill>) request.getAttribute("billList");
    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill List - PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Bill List</h2>
        <a href="bill-form.jsp" class="btn btn-primary">Create Bill</a>
    </div>

    <% if (message != null && !message.isEmpty()) { %>
    <div class="alert alert-success"><%= message %></div>
    <% } %>

    <div class="card shadow-sm">
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Customer Name</th>
                    <th>Units Consumed</th>
                    <th>Rate per Unit</th>
                    <th>Total Amount</th>
                    <th>Bill Date</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% if (billList != null && !billList.isEmpty()) {
                    for (Bill bill : billList) { %>
                <tr>
                    <td><%= bill.getId() %></td>
                    <td><%= bill.getCustomerName() %></td>
                    <td><%= bill.getUnitsConsumed() %></td>
                    <td><%= bill.getRatePerUnit() %></td>
                    <td><%= bill.getTotalAmount() %></td>
                    <td><%= bill.getBillDate() %></td>
                    <td>
                        <a href="BillServlet?action=edit&id=<%= bill.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="BillServlet?action=delete&id=<%= bill.getId() %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this bill?');">
                            Delete
                        </a>
                    </td>
                </tr>
                <%    }
                } else { %>
                <tr>
                    <td colspan="7" class="text-center">No bills found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
