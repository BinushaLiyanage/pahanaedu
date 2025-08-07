package com.pahanaedu.business.servlet;
import jakarta.servlet.*;

import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");


            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pahanaedu", "root", "root123");


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
            e.printStackTrace();
            response.getWriter().println("Database error.");
        }
    }
}

