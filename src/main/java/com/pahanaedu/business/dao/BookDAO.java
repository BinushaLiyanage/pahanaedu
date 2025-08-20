package com.pahanaedu.business.dao;

import com.pahanaedu.business.model.Book;
import com.pahanaedu.persistence.DBUtil;

import java.sql.*;
import java.util.*;

public class BookDAO {
        private static final String INSERT_BOOK_SQL = "INSERT INTO books (title, author, price, quantity) VALUES (?, ?, ?, ?)";
    private static final String SELECT_BOOK_BY_ID = "SELECT * FROM books WHERE id = ?";
    private static final String SELECT_ALL_BOOKS = "SELECT * FROM books";
    private static final String DELETE_BOOK_SQL = "DELETE FROM books WHERE id = ?";
    private static final String UPDATE_BOOK_SQL = "UPDATE books SET title = ?, author = ?, price = ?, quantity = ? WHERE id = ?";

    private Connection getConnection() throws SQLException {
        return DBUtil.getConnection();
    }

    public boolean insertBook(Book book) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_BOOK_SQL)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setDouble(3, book.getPrice());
            stmt.setInt(4, book.getQuantity());
            stmt.executeUpdate();
            return true;
        }
    }

    public Book selectBook(int id) throws SQLException {
        Book book = null;
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_BOOK_BY_ID)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                book = new Book();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getDouble("price"));
                book.setQuantity(rs.getInt("quantity"));
            }
        }
        return book;
    }

    public List<Book> selectAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(SELECT_ALL_BOOKS)) {

            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getDouble("price"));
                book.setQuantity(rs.getInt("quantity"));
                books.add(book);
            }
        }
        return books;
    }

    public void deleteBook(int id) throws SQLException {
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            String deleteBillItemsSQL = "DELETE FROM bill_items WHERE book_id = ?";
            try (PreparedStatement stmt1 = conn.prepareStatement(deleteBillItemsSQL)) {
                stmt1.setInt(1, id);
                int billItemsDeleted = stmt1.executeUpdate();
                System.out.println("Deleted " + billItemsDeleted + " bill items for book ID: " + id);
            }

            try (PreparedStatement stmt2 = conn.prepareStatement(DELETE_BOOK_SQL)) {
                stmt2.setInt(1, id);
                int booksDeleted = stmt2.executeUpdate();
                if (booksDeleted == 0) {
                    throw new SQLException("Book with ID " + id + " not found");
                }
                System.out.println("Deleted book with ID: " + id);
            }

            conn.commit();

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("Transaction rolled back due to error: " + e.getMessage());
                } catch (SQLException rollbackEx) {
                    System.err.println("Error during rollback: " + rollbackEx.getMessage());
                }
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException closeEx) {
                    System.err.println("Error closing connection: " + closeEx.getMessage());
                }
            }
        }
    }

    public void updateBook(Book book) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_BOOK_SQL)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setDouble(3, book.getPrice());
            stmt.setInt(4, book.getQuantity());
            stmt.setInt(5, book.getId());
            stmt.executeUpdate();
        }
    }

    public List<Book> selectBooks(String keyword, String sortBy, int start, int total) throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE title LIKE ? OR author LIKE ? ORDER BY " + sortBy + " LIMIT ?, ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setInt(3, start);
            stmt.setInt(4, total);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getDouble("price"));
                book.setQuantity(rs.getInt("quantity"));
                books.add(book);
            }
        }
        return books;
    }

    public int getBookCount(String keyword) throws SQLException {
        String sql = "SELECT COUNT(*) FROM books WHERE title LIKE ? OR author LIKE ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public void updateBookQuantity(int bookId, int newQuantity) throws SQLException {
        String sql = "UPDATE books SET quantity = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, bookId);
            stmt.executeUpdate();
        }
    }

}
