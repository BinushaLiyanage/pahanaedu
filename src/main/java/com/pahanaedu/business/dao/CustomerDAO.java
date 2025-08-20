package com.pahanaedu.business.dao;

import com.pahanaedu.business.model.Customer;
import com.pahanaedu.persistence.DBUtil;

import java.sql.*;
import java.util.*;

public class CustomerDAO {

    private static final String INSERT_CUSTOMER_SQL =
            "INSERT INTO customers (name, email, phone, address,account_number) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_CUSTOMER_BY_ID =
            "SELECT * FROM customers WHERE id = ?";
    private static final String UPDATE_CUSTOMER_SQL =
            "UPDATE customers SET name = ?, email = ?, phone = ?, address = ?,account_number = ? WHERE id = ?";
    private static final String DELETE_CUSTOMER_SQL =
            "DELETE FROM customers WHERE id = ?";

    private Connection getConnection() throws SQLException {
        return DBUtil.getConnection();
    }

    public boolean insertCustomer(Customer customer) throws SQLException {

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
            return true;
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
            stmt.setInt(6, customer.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteCustomer(int id) throws SQLException {
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);


            List<Integer> billIds = new ArrayList<>();
            String getBillIdsSQL = "SELECT id FROM bills WHERE customer_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(getBillIdsSQL)) {
                stmt.setInt(1, id);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    billIds.add(rs.getInt("id"));
                }
            }


            if (!billIds.isEmpty()) {
                String deleteBillItemsSQL = "DELETE FROM bill_items WHERE bill_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(deleteBillItemsSQL)) {
                    int totalBillItemsDeleted = 0;
                    for (Integer billId : billIds) {
                        stmt.setInt(1, billId);
                        totalBillItemsDeleted += stmt.executeUpdate();
                    }
                    System.out.println("Deleted " + totalBillItemsDeleted + " bill items for customer ID: " + id);
                }
            }


            String deleteBillsSQL = "DELETE FROM bills WHERE customer_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteBillsSQL)) {
                stmt.setInt(1, id);
                int billsDeleted = stmt.executeUpdate();
                System.out.println("Deleted " + billsDeleted + " bills for customer ID: " + id);
            }


            try (PreparedStatement stmt = conn.prepareStatement(DELETE_CUSTOMER_SQL)) {
                stmt.setInt(1, id);
                int customersDeleted = stmt.executeUpdate();
                if (customersDeleted == 0) {
                    throw new SQLException("Customer with ID " + id + " not found");
                }
                System.out.println("Deleted customer with ID: " + id);
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
