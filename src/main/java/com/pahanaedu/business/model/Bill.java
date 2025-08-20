package com.pahanaedu.business.model;

import java.sql.Date;
import java.util.List;

public class Bill {
        private int id;
        private int customerId;
        private String customerAccountNumber;
        private String customerName;
        private int unitsConsumed;
        private double ratePerUnit;
        private double totalAmount;
        private String billDate;
        private List<BillItem> items;

        public int getId() {
                return id;
        }

        public void setId(int id) {
                this.id = id;
        }

        public int getCustomerId() {
                return customerId;
        }

        public void setCustomerId(int customerId) {
                this.customerId = customerId;
        }

        public String getCustomerName() {
                return customerName;
        }
        public void setCustomerName(String customerName) {
                this.customerName = customerName;
        }

        public int getUnitsConsumed() {
                return unitsConsumed;
        }

        public void setUnitsConsumed(int unitsConsumed) {
                this.unitsConsumed = unitsConsumed;
        }

        public double getRatePerUnit() {
                return ratePerUnit;
        }

        public void setRatePerUnit(double ratePerUnit) {
                this.ratePerUnit = ratePerUnit;
        }

        public double getTotalAmount() {
                return totalAmount;
        }

        public void setTotalAmount(double totalAmount) {
                this.totalAmount = totalAmount;
        }

        public String getBillDate() {
                return billDate;
        }

        public void setBillDate(String billDate) {
                this.billDate = billDate;
        }

        public List<BillItem> getItems() {
                return items;
        }

        public void setItems(List<BillItem> items) {
                this.items = items;
        }

        public String getCustomerAccountNumber() {
                return customerAccountNumber;
        }

        public void setCustomerAccountNumber(String customerAccountNumber) {
                this.customerAccountNumber = customerAccountNumber;
        }
}




