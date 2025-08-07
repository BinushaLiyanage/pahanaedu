package com.pahanaedu.business.dao;

import com.pahanaedu.business.model.Book;
import java.sql.*;
import java.util.*;

public class BookDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/pahanaedu";
    private String jdbcUsername = "root";
    private String jdbcPassword = "root123";

    private static final String INSERT_BOOK_SQL = "INSERT INTO books (title, author, price, quantity) VALUES (?, ?, ?, ?)";
    private static final String SELECT_BOOK_BY_ID = "SELECT * FROM books WHERE id = ?";
    private static final String SELECT_ALL_BOOKS = "SELECT * FROM books";
    private static final String DELETE_BOOK_SQL = "DELETE FROM books WHERE id = ?";
    private static final String UPDATE_BOOK_SQL = "UPDATE books SET title = ?, author = ?, price = ?, quantity = ? WHERE id = ?";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public void insertBook(Book book) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_BOOK_SQL)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setDouble(3, book.getPrice());
            stmt.setInt(4, book.getQuantity());
            stmt.executeUpdate();
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
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_BOOK_SQL)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
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
}
