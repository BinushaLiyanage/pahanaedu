package com.pahanaedu.business.model;

public class BillItem {
    private int id;
    private int billId;
    private int bookId;
    private int quantity;
    private double price;
    private String bookTitle;


    public BillItem() {}

    public BillItem(int id, int billId, int bookId, int quantity, double price) {
        this.id = id;
        this.billId = billId;
        this.bookId = bookId;
        this.quantity = quantity;
        this.price = price;
    }


    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getBillId() {
        return billId;
    }
    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getBookId() {
        return bookId;
    }
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }

    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }
}
