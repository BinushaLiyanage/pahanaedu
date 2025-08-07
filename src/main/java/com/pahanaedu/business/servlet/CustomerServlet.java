package com.pahanaedu.business.servlet;

import com.pahanaedu.business.dao.CustomerDAO;
import com.pahanaedu.business.model.Customer;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class CustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Customer customer = new Customer();
                customer.setId(id);
                customer.setName(request.getParameter("name"));
                customer.setEmail(request.getParameter("email"));
                customer.setPhone(request.getParameter("phone"));
                customer.setAddress(request.getParameter("address"));

                customerDAO.updateCustomer(customer);

                session.setAttribute("message", "Customer updated successfully!");
                session.setAttribute("messageType", "info");

            } else {
                Customer customer = new Customer();
                customer.setName(request.getParameter("name"));
                customer.setEmail(request.getParameter("email"));
                customer.setPhone(request.getParameter("phone"));
                customer.setAddress(request.getParameter("address"));

                customerDAO.insertCustomer(customer);

                session.setAttribute("message", "Customer added successfully!");
                session.setAttribute("messageType", "success");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Something went wrong!");
            session.setAttribute("messageType", "error");
        }

        response.sendRedirect("CustomerServlet");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                customerDAO.deleteCustomer(id);

                HttpSession session = request.getSession();
                session.setAttribute("message", "Customer deleted successfully!");
                session.setAttribute("messageType", "error");

                response.sendRedirect("CustomerServlet");

            } else if ("edit".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Customer customer = customerDAO.selectCustomer(id);

                request.setAttribute("customer", customer);
                RequestDispatcher dispatcher = request.getRequestDispatcher("customer-form.jsp");
                dispatcher.forward(request, response);

            } else {
                List<Customer> customers = customerDAO.selectAllCustomers();
                request.setAttribute("customerList", customers);

                HttpSession session = request.getSession();
                String message = (String) session.getAttribute("message");
                String messageType = (String) session.getAttribute("messageType");

                if (message != null) {
                    request.setAttribute("message", message);
                    request.setAttribute("messageType", messageType);
                    session.removeAttribute("message");
                    session.removeAttribute("messageType");
                }


                String search = request.getParameter("search");
                List<Customer> customerList;


                RequestDispatcher dispatcher = request.getRequestDispatcher("customer-list.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
