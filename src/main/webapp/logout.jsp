<%
    session.invalidate(); // End the session
    response.sendRedirect("login.jsp"); // Redirect to login page
%>
