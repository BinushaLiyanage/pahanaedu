<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Bill Invoice</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .invoice-box {
            max-width: 800px;
            margin: auto;
            padding: 30px;
            border: 1px solid #eee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
        }
        .invoice-header {
            margin-bottom: 30px;
        }
        .invoice-header h1 {
            font-size: 36px;
            color: #333;
        }
        .invoice-details, .invoice-table {
            width: 100%;
            margin-bottom: 20px;
        }
        .invoice-table th, .invoice-table td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        .total-row td {
            font-weight: bold;
        }
        @media print {
            .no-print {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="invoice-box">
    <div class="invoice-header text-center">
        <h1>Pahana Edu Bookstore</h1>
        <p>Bill Invoice</p>
    </div>

    <c:if test="${not empty bill}">
        <table class="invoice-details">
            <tr>
                <td><strong>Bill ID:</strong> ${bill.id}</td>
                <td><strong>Date:</strong> ${bill.billDate}</td>
            </tr>
            <tr>
                <td><strong>Customer:</strong> ${bill.customerName}</td>
                <td><strong>Customer ID:</strong> ${bill.customerAccountNumber}</td>
                <td></td>
            </tr>
        </table>

        <table class="invoice-table table table-bordered">
            <thead class="table-light">
            <tr>
                <th>Book Title</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Subtotal</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${bill.items}">
                <tr>
                    <td>${item.bookTitle}</td>
                    <td>${item.quantity}</td>
                    <td>${item.price}</td>
                    <td>${item.quantity * item.price}</td>
                </tr>
            </c:forEach>
            <tr class="total-row">
                <td colspan="3" class="text-end">Total</td>
                <td>${bill.totalAmount}</td>
            </tr>
            </tbody>
        </table>

        <div class="mt-3 no-print text-center">
            <button class="btn btn-success" onclick="window.print()">Print Bill</button>
            <a href="BillServlet" class="btn btn-primary">Create New Bill</a>
            <a href="dashboard.jsp" class="btn btn-primary">Dashboard</a>
        </div>
    </c:if>
</div>
</body>
</html>
