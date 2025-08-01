<%@ page import="java.util.*, com.pahanaedu.model.Book" %>
<%
    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
    String message = (String) request.getAttribute("message");
    String messageType = (String) request.getAttribute("messageType");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book List</title>
    <style>
        .toast-popup {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            font-size: 16px;
            opacity: 0;
            transform: translateY(-20px);
            transition: opacity 0.5s ease, transform 0.5s ease;
            z-index: 9999;
        }

        .toast-popup.show {
            opacity: 1;
            transform: translateY(0);
        }

        .toast-popup.hide {
            opacity: 0;
            transform: translateY(-20px);
        }

        .toast-success {
            background-color: #28a745;
            color: white;
        }

        .toast-info {
            background-color: #007bff;
            color: white;
        }

        .toast-error {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>

<h2>All Books</h2>

<% if (message != null) { %>
<div id="toast" class="toast-popup toast-<%= messageType %>"><%= message %></div>
<% } %>

<script>
    window.onload = function () {
        const toast = document.getElementById("toast");
        if (toast) {
            toast.classList.add("show");
            setTimeout(() => toast.classList.add("hide"), 3500);
            setTimeout(() => toast.remove(), 4000);
        }
    };
</script>

<table border="1">
    <tr><th>ID</th><th>Title</th><th>Author</th><th>Price</th><th>Quantity</th><th>Edit</th><th>Delete</th></tr>
    <% for (Book book : bookList) { %>
    <tr>
        <td><%= book.getId() %></td>
        <td><%= book.getTitle() %></td>
        <td><%= book.getAuthor() %></td>
        <td><%= book.getPrice() %></td>
        <td><%= book.getQuantity() %></td>
        <td><a href="BookServlet?action=edit&id=<%= book.getId() %>">Edit</a></td>
        <td><a href="BookServlet?action=delete&id=<%= book.getId() %>" onclick="return confirm('Are you sure?')">Delete</a></td>
    </tr>
    <% } %>
</table>

<br>
<a href="book-form.jsp"><button>Back to Form</button></a>

</body>
</html>
