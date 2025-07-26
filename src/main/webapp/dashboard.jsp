<%@ page import="jakarta.servlet.http.HttpSession" %>
<%

    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head><title>Dashboard</title></head>
<body>
<h1>Welcome, <%= session.getAttribute("username") %></h1>

<!-- Logout link -->
<p><a href="logout.jsp">Logout</a></p>
</body>
</html>
