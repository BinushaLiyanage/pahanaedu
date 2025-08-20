package com.pahanaedu.business.service;

import com.pahanaedu.business.dao.BillDAO;
import com.pahanaedu.business.model.Bill;

public class BillService {
    private static final double RATE_PER_UNIT = 15.0;

    private BillDAO billDAO;

    public BillService() {
        this.billDAO = new BillDAO();
    }

    public void createBill(int customerId, int units) throws Exception {
        double total = units * RATE_PER_UNIT;

        Bill bill = new Bill();
        bill.setCustomerId(customerId);
        bill.setUnitsConsumed(units);
        bill.setRatePerUnit(RATE_PER_UNIT);
        bill.setTotalAmount(total);

    }
}
