<%@ page import="java.util.*, com.pahanaedu.model.Book" %>
<%
    List<Book> bookList = (List<Book>) request.getAttribute("bookList");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book List</title>
</head>
<body>
<h2>All Books</h2>
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
<a href="book-form.jsp">
    <button>Back to Form</button>
</a>

</body>
</html>
