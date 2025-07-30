package com.pahanaedu.servlet;

import com.pahanaedu.dao.BookDAO;
import com.pahanaedu.model.Book;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

public class BookServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("update".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Book book = new Book();
            book.setId(id);
            book.setTitle(request.getParameter("title"));
            book.setAuthor(request.getParameter("author"));
            book.setPrice(Double.parseDouble(request.getParameter("price")));
            book.setQuantity(Integer.parseInt(request.getParameter("quantity")));

            try {
                bookDAO.updateBook(book);
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {

            Book book = new Book();
            book.setTitle(request.getParameter("title"));
            book.setAuthor(request.getParameter("author"));
            book.setPrice(Double.parseDouble(request.getParameter("price")));
            book.setQuantity(Integer.parseInt(request.getParameter("quantity")));

            try {
                bookDAO.insertBook(book);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("BookServlet");  
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                bookDAO.deleteBook(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("BookServlet");
        } else if ("edit".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                Book book = bookDAO.selectBook(id);
                request.setAttribute("book", book);
                RequestDispatcher dispatcher = request.getRequestDispatcher("book-form.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {

            try {
                List<Book> books = bookDAO.selectAllBooks();
                request.setAttribute("bookList", books);
                RequestDispatcher dispatcher = request.getRequestDispatcher("book-list.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
