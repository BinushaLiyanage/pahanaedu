package com.pahanaedu.business.servlet;

import com.pahanaedu.business.model.Customer;
import com.pahanaedu.business.service.CustomerService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class CustomerServlet extends HttpServlet {
    private CustomerService customerService = new CustomerService();

    public void doPost(HttpServletRequest request, HttpServletResponse response)
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

                customerService.updateCustomer(customer);

                session.setAttribute("message", "Customer updated successfully!");
                session.setAttribute("messageType", "info");

            } else {
                Customer customer = new Customer();
                customer.setName(request.getParameter("name"));
                customer.setEmail(request.getParameter("email"));
                customer.setPhone(request.getParameter("phone"));
                customer.setAddress(request.getParameter("address"));

                customerService.addCustomer(customer);

                session.setAttribute("message", "Customer added successfully!");
                session.setAttribute("messageType", "success");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Customer Already exists!");
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
                customerService.deleteCustomer(id);

                HttpSession session = request.getSession();
                session.setAttribute("message", "Customer deleted successfully!");
                session.setAttribute("messageType", "error");

                response.sendRedirect("CustomerServlet");

            } else if ("edit".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Customer customer = customerService.getCustomerById(id);

                String search = request.getParameter("search");
                request.setAttribute("customer", customer);
                request.setAttribute("search", search);

                RequestDispatcher dispatcher = request.getRequestDispatcher("customer-form.jsp");
                dispatcher.forward(request, response);

            } else {

                String search = request.getParameter("search");
                String pageParam = request.getParameter("page");
                int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
                int recordsPerPage = 10;
                int start = (page - 1) * recordsPerPage;
                List<Customer> customerList = null;
                if(search != null) {
                    customerList = customerService.getCustomers(search, start, recordsPerPage);

                }else{
                 customerList = customerService.getAllCustomers();
                }
                int totalRecords = customerList != null ? customerList.size() : 0;
                int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

                request.setAttribute("customerList", customerList);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("search", search);

                HttpSession session = request.getSession();
                String message = (String) session.getAttribute("message");
                String messageType = (String) session.getAttribute("messageType");

                if (message != null) {
                    request.setAttribute("message", message);
                    request.setAttribute("messageType", messageType);
                    session.removeAttribute("message");
                    session.removeAttribute("messageType");
                }

                RequestDispatcher dispatcher = request.getRequestDispatcher("customer-list.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
