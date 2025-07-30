<html>
<head>
    <title>Add Book</title>
</head>
<body>
<h2>Add New Book</h2>
<form action="BookServlet" method="post">
    Title: <input type="text" name="title" required><br><br>
    Author: <input type="text" name="author" required><br><br>
    Price: <input type="number" step="0.01" name="price" required><br><br>
    Quantity: <input type="number" name="quantity" required><br><br>
    <input type="submit" value="Add Book">


</form>



<br>
<a href="BookServlet">View All Books</a>
</body>
</html>
