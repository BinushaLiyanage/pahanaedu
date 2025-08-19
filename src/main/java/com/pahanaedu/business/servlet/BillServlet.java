package com.pahanaedu.business.servlet;

import com.pahanaedu.business.dao.BillDAO;
import com.pahanaedu.business.dao.BookDAO;
import com.pahanaedu.business.dao.CustomerDAO;
import com.pahanaedu.business.model.Bill;
import com.pahanaedu.business.model.BillItem;

import com.pahanaedu.business.model.Book;
import com.pahanaedu.business.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BillServlet extends HttpServlet {

    private BillDAO billDAO;

    @Override
    public void init() {
        billDAO = new BillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");

            if (action == null) {
                CustomerDAO customerDAO = new CustomerDAO();
                BookDAO bookDAO = new BookDAO();

                List<Customer> customerList = customerDAO.selectAllCustomers();
                List<Book> bookList = bookDAO.selectAllBooks();

                request.setAttribute("customers", customerList);
                request.setAttribute("books", bookList);
                request.getRequestDispatcher("bill-form.jsp").forward(request, response);
            } else if (action.equals("history")) {
                List<Bill> bills = billDAO.getAllBills();
                request.setAttribute("bills", bills);
                request.getRequestDispatcher("bill-history.jsp").forward(request, response);

            } else if (action.equals("view")) {

                int billId = Integer.parseInt(request.getParameter("id"));
                Bill bill = billDAO.getBillById(billId);

                if (bill != null) {
                    CustomerDAO customerDAO = new CustomerDAO();
                    bill.setCustomerName(customerDAO.selectCustomer(bill.getCustomerId()).getName());
                    bill.setCustomerAccountNumber(customerDAO.selectCustomer(bill.getCustomerId()).getAccountNumber());

                    BookDAO bookDAO = new BookDAO();
                    for (BillItem item : bill.getItems()) {
                        item.setBookTitle(bookDAO.selectBook(item.getBookId()).getTitle());
                    }
                }

                request.setAttribute("bill", bill);
                request.getRequestDispatcher("bill-view.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            double total = Double.parseDouble(request.getParameter("total"));

            String[] bookIds = request.getParameterValues("bookId");
            String[] quantities = request.getParameterValues("quantity");
            String[] prices = request.getParameterValues("price");

            BookDAO bookDAO = new BookDAO();
            List<BillItem> items = new ArrayList<>();

            boolean stockError = false;
            String errorMessage = "";

            if (bookIds != null) {
                for (int i = 0; i < bookIds.length; i++) {
                    int bookId = Integer.parseInt(bookIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);

                    // Fetch book from DB
                    Book book = bookDAO.selectBook(bookId);

                    // Check stock
                    if (book.getQuantity() < quantity) {
                        stockError = true;
                        errorMessage += "Not enough stock for " + book.getTitle() + ". Available: " + book.getQuantity() + "<br/>";
                    } else {
                        BillItem item = new BillItem();
                        item.setBookId(bookId);
                        item.setQuantity(quantity);
                        item.setPrice(Double.parseDouble(prices[i]));
                        item.setBookTitle(book.getTitle());
                        items.add(item);
                    }
                }
            }

            if (stockError) {
                // Show error message and prevent saving
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("bill-form.jsp").forward(request, response);
                return;
            }

            // Reduce stock
            for (BillItem item : items) {
                Book book = bookDAO.selectBook(item.getBookId());
                book.setQuantity(book.getQuantity() - item.getQuantity());
                bookDAO.updateBookQuantity(book.getId(), book.getQuantity());
            }

            // Save bill
            Bill bill = new Bill();
            bill.setCustomerId(customerId);
            bill.setTotalAmount(total);
            bill.setItems(items);
            bill.setBillDate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

            int billId = billDAO.insertBill(bill);
            bill.setId(billId);

            // Set customer info
            CustomerDAO customerDAO = new CustomerDAO();
            bill.setCustomerName(customerDAO.selectCustomer(customerId).getName());
            bill.setCustomerAccountNumber(customerDAO.selectCustomer(customerId).getAccountNumber());

            request.setAttribute("bill", bill);
            request.getRequestDispatcher("bill-view.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("BillServlet?error=true");
        }
    }

}
