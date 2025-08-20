<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.business.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (!"ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }
%>
<html>
<head>
    <title>Add User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><i class="bi bi-person-plus me-2"></i>Add New User</h4>
                </div>
                <div class="card-body">

                    <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i>
                        <%= request.getAttribute("success") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% request.removeAttribute("success"); %>
                    <% } %>

                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        <%= request.getAttribute("error") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% request.removeAttribute("error"); %>
                    <% } %>

                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        <%= request.getAttribute("error") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <form action="UserServlet" method="post">
                        <input type="hidden" name="action" value="insert"/>

                        <div class="mb-3">
                            <label class="form-label">
                                <i class="bi bi-person me-1"></i>Username
                            </label>
                            <input type="text" name="username" class="form-control"
                                   value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>"
                                   required/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">
                                <i class="bi bi-lock me-1"></i>Password
                            </label>
                            <input type="password" name="password" class="form-control" required/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">
                                <i class="bi bi-shield me-1"></i>Role
                            </label>
                            <select name="role" class="form-select" required>
                                <option value="">Select Role</option>
                                <option value="ADMIN" <%= "ADMIN".equals(request.getParameter("role")) ? "selected" : "" %>>Admin</option>
                                <option value="STAFF" <%= "STAFF".equals(request.getParameter("role")) ? "selected" : "" %>>Staff</option>
                            </select>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check-lg me-2"></i>Save User
                            </button>
                            <a href="UserServlet?action=list" class="btn btn-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Back to User List
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>