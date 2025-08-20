package com.pahanaedu.business.service;

import com.pahanaedu.business.dao.CustomerDAO;
import com.pahanaedu.business.model.Customer;

import java.sql.SQLException;
import java.util.List;


public class  CustomerService {

    private CustomerDAO customerDAO = new CustomerDAO();

    public void addCustomer(Customer customer) throws SQLException {
        customerDAO.insertCustomer(customer);
    }

    public Customer getCustomerById(int id) throws SQLException {
        return customerDAO.selectCustomer(id);
    }

    public List<Customer> getCustomers(String searchQuery, int offset, int limit) throws SQLException {
        return customerDAO.selectCustomers(searchQuery, offset, limit);
    }

    public int getCustomerCount(String searchQuery) throws SQLException {
        return customerDAO.getCustomerCount(searchQuery);
    }

    public void updateCustomer(Customer customer) throws SQLException {
        customerDAO.updateCustomer(customer);
    }

    public void deleteCustomer(int id) throws SQLException {
        customerDAO.deleteCustomer(id);
    }

    public List<Customer> getAllCustomers() throws SQLException {
        return customerDAO.selectAllCustomers();
    }
}

