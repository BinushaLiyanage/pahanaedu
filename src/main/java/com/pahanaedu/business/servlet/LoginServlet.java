package com.pahanaedu.business.servlet;
import com.pahanaedu.persistence.DBUtil;
import com.pahanaedu.util.LoggerUtil;
import jakarta.servlet.*;

import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.logging.Logger;

public class LoginServlet extends HttpServlet {
    private static final Logger logger = LoggerUtil.getLogger();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Connection conn = DBUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(
                    "SELECT * FROM users WHERE username = ? AND password = ?");

            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                response.sendRedirect("dashboard.jsp");
            } else {

                response.getWriter().println("Invalid login. <a href='login.jsp'>Try again</a>");
            }

            conn.close();

        } catch (Exception e) {
            logger.severe("Database error: " + e.getMessage());
            response.getWriter().println("Database error.");
        }
    }
}

