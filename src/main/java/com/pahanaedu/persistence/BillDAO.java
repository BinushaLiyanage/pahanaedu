/*
package com.pahanaedu.persistence;

import com.pahanaedu.business.model.Bill;
import java.sql.*;
import java.util.*;

public class BillDAO {
    private Connection conn;

    public BillDAO() {
        try {
            this.conn = DBUtil.getConnection();
        }catch(Exception e) {
            System.err.println("Error connecting to database. "+e);
        }
//    }
//
//    public void addBill(Bill bill) throws SQLException {
//        String sql = "INSERT INTO bills (customer_id, units_consumed, rate_per_unit, total_amount) VALUES (?, ?, ?, ?)";
//        PreparedStatement stmt = conn.prepareStatement(sql);
//        stmt.setInt(1, bill.getCustomerId());
//        stmt.setInt(2, bill.getUnitsConsumed());
//        stmt.setDouble(3, bill.getRatePerUnit());
//        stmt.setDouble(4, bill.getTotalAmount());
//        stmt.executeUpdate();
//    }



}*/
