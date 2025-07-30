<%@ page import="com.pahanaedu.model.Book" %>
<%
    Book book = (Book) request.getAttribute("book");
    boolean isEdit = book != null;
%>
<html>
<head>
    <title><%= isEdit ? "Edit Book" : "Add Book" %></title>
</head>
<body>
<h2><%= isEdit ? "Edit Book" : "Add New Book" %></h2>
<form action="BookServlet" method="post">
    <% if (isEdit) { %>
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="<%= book.getId() %>">
    <% } %>

    Title: <input type="text" name="title" value="<%= isEdit ? book.getTitle() : "" %>" required><br><br>
    Author: <input type="text" name="author" value="<%= isEdit ? book.getAuthor() : "" %>" required><br><br>
    Price: <input type="number" step="0.01" name="price" value="<%= isEdit ? book.getPrice() : "" %>" required><br><br>
    Quantity: <input type="number" name="quantity" value="<%= isEdit ? book.getQuantity() : "" %>" required><br><br>

    <input type="submit" value="<%= isEdit ? "Update Book" : "Add Book" %>">
</form>

<br>
<a href="BookServlet">View All Books</a>
</body>
</html>
