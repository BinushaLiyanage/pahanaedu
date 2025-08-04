package com.pahanaedu.servlet;

import com.pahanaedu.dao.BookDAO;
import com.pahanaedu.model.Book;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

public class BookServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();
    private final int PAGE_SIZE = 5;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            HttpSession session = request.getSession();

            if ("update".equalsIgnoreCase(action)) {

                int id = Integer.parseInt(request.getParameter("id"));
                Book book = new Book();
                book.setId(id);
                book.setTitle(request.getParameter("title"));
                book.setAuthor(request.getParameter("author"));
                book.setPrice(Double.parseDouble(request.getParameter("price")));
                book.setQuantity(Integer.parseInt(request.getParameter("quantity")));

                bookDAO.updateBook(book);

                session.setAttribute("message", "Book updated successfully!");
                session.setAttribute("messageType", "info");

            } else {
                Book book = new Book();
                book.setTitle(request.getParameter("title"));
                book.setAuthor(request.getParameter("author"));
                book.setPrice(Double.parseDouble(request.getParameter("price")));
                book.setQuantity(Integer.parseInt(request.getParameter("quantity")));

                bookDAO.insertBook(book);

                session.setAttribute("message", "Book added successfully!");
                session.setAttribute("messageType", "success");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("BookServlet");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                bookDAO.deleteBook(id);
                HttpSession session = request.getSession();
                session.setAttribute("message", "Book deleted successfully!");
                session.setAttribute("messageType", "danger");
                response.sendRedirect("BookServlet");

            } else if ("edit".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Book book = bookDAO.selectBook(id);
                request.setAttribute("book", book);
                RequestDispatcher dispatcher = request.getRequestDispatcher("book-form.jsp");
                dispatcher.forward(request, response);

            } else {
                String keyword = request.getParameter("keyword");
                if (keyword == null) keyword = "";
                String sortBy = request.getParameter("sortBy");
                if (sortBy == null || sortBy.isEmpty()) sortBy = "id";
                int page = 1;
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException ignored) {}
                int offset = (page - 1) * PAGE_SIZE;

                List<Book> books = bookDAO.selectBooks(keyword, sortBy, offset, PAGE_SIZE);
                int totalBooks = bookDAO.getBookCount(keyword);
                int totalPages = (int) Math.ceil((double) totalBooks / PAGE_SIZE);

                request.setAttribute("bookList", books);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("keyword", keyword);
                request.setAttribute("sortBy", sortBy);

                HttpSession session = request.getSession();
                String message = (String) session.getAttribute("message");
                String messageType = (String) session.getAttribute("messageType");
                if (message != null) {
                    request.setAttribute("message", message);
                    request.setAttribute("messageType", messageType);
                    session.removeAttribute("message");
                    session.removeAttribute("messageType");
                }

                RequestDispatcher dispatcher = request.getRequestDispatcher("book-list.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}