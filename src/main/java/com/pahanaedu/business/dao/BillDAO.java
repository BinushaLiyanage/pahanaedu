package com.pahanaedu.business.dao;

import com.pahanaedu.business.model.Bill;
import com.pahanaedu.business.model.BillItem;
import com.pahanaedu.persistence.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    private static final String INSERT_BILL_SQL =
            "INSERT INTO bills (customer_id, bill_date, total) VALUES (?, ?, ?)";

    private static final String INSERT_BILL_ITEM_SQL =
            "INSERT INTO bill_items (bill_id, book_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

    private static final String SELECT_BILL_BY_ID = "SELECT b.id, b.customer_id, b.total, b.bill_date, " +
            "c.name AS customer_name, c.account_number " +
            "FROM bills b JOIN customers c ON b.customer_id = c.id WHERE b.id = ?";
    private static final String SELECT_BILL_ITEMS = "SELECT bi.id, bi.book_id, bi.quantity, bi.unit_price, bk.title " +
            "FROM bill_items bi JOIN books bk ON bi.book_id = bk.id WHERE bi.bill_id = ?";

    public int insertBill(Bill bill) throws Exception {
        try (Connection connection = DBUtil.getConnection()) {
            connection.setAutoCommit(false);

            try (PreparedStatement billStmt =
                         connection.prepareStatement(INSERT_BILL_SQL, Statement.RETURN_GENERATED_KEYS)) {

                billStmt.setInt(1, bill.getCustomerId());
                billStmt.setTimestamp(2, java.sql.Timestamp.valueOf(bill.getBillDate()));
                billStmt.setDouble(3, bill.getTotalAmount());
                billStmt.executeUpdate();

                ResultSet rs = billStmt.getGeneratedKeys();
                int billId = 0;
                if (rs.next()) {
                    billId = rs.getInt(1);
                }

                try (PreparedStatement itemStmt = connection.prepareStatement(INSERT_BILL_ITEM_SQL)) {
                    for (BillItem item : bill.getItems()) {
                        itemStmt.setInt(1, billId);
                        itemStmt.setInt(2, item.getBookId());
                        itemStmt.setInt(3, item.getQuantity());
                        itemStmt.setDouble(4, item.getPrice());
                        itemStmt.addBatch();
                    }
                    itemStmt.executeBatch();
                }

                connection.commit();
                return billId;
            } catch (Exception ex) {
                connection.rollback();
                throw ex;
            }
        }
    }

    public List<Bill> getAllBills() throws Exception {
        List<Bill> bills = new ArrayList<>();

        String sql = "SELECT b.id, b.customer_id, b.total, b.bill_date, c.name AS customer_name " +
                "FROM bills b JOIN customers c ON b.customer_id = c.id ORDER BY b.bill_date DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Bill bill = new Bill();
                bill.setId(rs.getInt("id"));
                bill.setCustomerId(rs.getInt("customer_id"));
                bill.setCustomerName(rs.getString("customer_name"));
                bill.setTotalAmount(rs.getDouble("total"));
                bill.setBillDate(String.valueOf(rs.getTimestamp("bill_date").toLocalDateTime()));
                bills.add(bill);
            }
        }

        return bills;
    }

    public Bill getBillById(int billId) {
        Bill bill = null;

        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BILL_BY_ID)) {

            preparedStatement.setInt(1, billId);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                bill = new Bill();
                bill.setId(rs.getInt("id"));
                bill.setCustomerId(rs.getInt("customer_id"));
                bill.setTotalAmount(rs.getDouble("total"));
                bill.setBillDate(rs.getString("bill_date"));
                bill.setCustomerName(rs.getString("customer_name"));
                bill.setCustomerAccountNumber(rs.getString("account_number"));


                List<BillItem> items = new ArrayList<>();
                try (PreparedStatement psItems = connection.prepareStatement(SELECT_BILL_ITEMS)) {
                    psItems.setInt(1, billId);
                    ResultSet rsItems = psItems.executeQuery();

                    while (rsItems.next()) {
                        BillItem item = new BillItem();
                        item.setBookId(rsItems.getInt("book_id"));
                        item.setQuantity(rsItems.getInt("quantity"));
                        item.setPrice(rsItems.getDouble("unit_price"));
                        item.setBookTitle(rsItems.getString("title"));
                        items.add(item);
                    }
                }
                bill.setItems(items);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bill;
    }


}
