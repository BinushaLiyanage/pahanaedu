package com.pahanaedu.business.dao;

import com.pahanaedu.business.model.Customer;
import java.sql.*;
import java.util.*;

public class CustomerDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/pahanaedu";
    private String jdbcUsername = "root";
    private String jdbcPassword = "root123";

    private static final String INSERT_CUSTOMER_SQL =
            "INSERT INTO customers (name, email, phone, address,account_number) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_CUSTOMER_BY_ID =
            "SELECT * FROM customers WHERE id = ?";
    private static final String UPDATE_CUSTOMER_SQL =
            "UPDATE customers SET name = ?, email = ?, phone = ?, address = ?,account_number = ? WHERE id = ?";
    private static final String DELETE_CUSTOMER_SQL =
            "DELETE FROM customers WHERE id = ?";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public void insertCustomer(Customer customer) throws SQLException {

        String accountNumber = "CUST-" + System.currentTimeMillis();
        customer.setAccountNumber(accountNumber);

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_CUSTOMER_SQL)) {
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getAddress());
            stmt.setString(5, customer.getAccountNumber());
            stmt.executeUpdate();
        }
    }

    public Customer selectCustomer(int id) throws SQLException {
        Customer customer = null;
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_CUSTOMER_BY_ID)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setAccountNumber(rs.getString("account_number"));

            }
        }
        return customer;
    }

    public List<Customer> selectCustomers(String searchQuery, int offset, int limit) throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE name LIKE ? OR email LIKE ? ORDER BY id DESC LIMIT ?, ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + searchQuery + "%");
            stmt.setString(2, "%" + searchQuery + "%");
            stmt.setInt(3, offset);
            stmt.setInt(4, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setAccountNumber(rs.getString("account_number"));
                customers.add(customer);
            }
        }
        return customers;
    }
    public List<Customer> selectCustomers(String searchQuery, int offset, int limit, String sortBy, String sortOrder) throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String baseSQL = "SELECT * FROM customers WHERE name LIKE ? OR email LIKE ?";
        String orderSQL = " ORDER BY " + sortBy + " " + sortOrder + " LIMIT ?, ?";
        String fullSQL = baseSQL + orderSQL;
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(fullSQL)) {
            stmt.setString(1, "%" + searchQuery + "%");
            stmt.setString(2, "%" + searchQuery + "%");
            stmt.setInt(3, offset);
            stmt.setInt(4, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setAccountNumber(rs.getString("account_number"));
                customers.add(customer);
            }
        }
        return customers;
    }


    public int getCustomerCount(String searchQuery) throws SQLException {
        String sql = "SELECT COUNT(*) FROM customers WHERE name LIKE ? OR email LIKE ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + searchQuery + "%");
            stmt.setString(2, "%" + searchQuery + "%");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public void updateCustomer(Customer customer) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_CUSTOMER_SQL)) {
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getAddress());
            stmt.setString(5, customer.getAccountNumber());
            stmt.executeUpdate();
        }
    }

    public void deleteCustomer(int id) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_CUSTOMER_SQL)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public List<Customer> selectAllCustomers() throws SQLException {
        {
            List<Customer> customers = new ArrayList<>();
            String sql = "SELECT * FROM customers";
            try (Connection conn = getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Customer customer = new Customer();
                    customer.setId(rs.getInt("id"));
                    customer.setName(rs.getString("name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setAddress(rs.getString("address"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customers.add(customer);
                }
            }
            return customers;
        }
    }
}
