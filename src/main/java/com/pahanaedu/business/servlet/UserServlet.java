package com.pahanaedu.business.servlet;

import com.pahanaedu.business.dao.UserDAO;
import com.pahanaedu.business.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class UserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null || !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String userIdStr = request.getParameter("id");
            try {
                int userId = Integer.parseInt(userIdStr);

                if (userId == loggedInUser.getId()) {
                    request.setAttribute("error", "You cannot delete your own account!");
                } else {
                    boolean deleted = userDAO.deleteUser(userId);
                    if (deleted) {
                        request.setAttribute("success", "User deleted successfully!");
                    } else {
                        request.setAttribute("error", "Failed to delete user!");
                    }
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid user ID!");
            }
        }

        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("user-list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null || !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (userDAO.usernameExists(username)) {
            request.setAttribute("error", "Username already exists! Please choose a different username.");
            request.getRequestDispatcher("user-form.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);

        boolean saved = userDAO.saveUser(user);
        if (saved) {
            request.setAttribute("success", "User created successfully!");
        } else {
            request.setAttribute("error", "Failed to create user!");
        }

        response.sendRedirect("UserServlet?action=list");
    }

}
