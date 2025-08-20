package com.pahanaedu.business.servlet;
import com.pahanaedu.business.model.User;
import com.pahanaedu.persistence.DBUtil;
import com.pahanaedu.util.LoggerUtil;
import jakarta.servlet.*;

import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.logging.Logger;

public class LoginServlet extends HttpServlet {
    private static final Logger logger = LoggerUtil.getLogger();

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                    "SELECT * FROM users WHERE username = ? AND password = ?");

            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                User user = new  User();
                user.setUsername(username);
                user.setPassword(password);
                user.setId(rs.getInt("id"));
                user.setRole( rs.getString("role"));
                session.setAttribute("user", user);
                session.setAttribute("role", rs.getString("role"));
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("loginError", "Invalid username or password!");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            logger.severe("Database error: " + e.getMessage());
            request.setAttribute("loginError", "Database error.");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
    }
}

