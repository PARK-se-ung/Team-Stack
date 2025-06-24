package org.ts.teamstack.payment.model.service;

import org.ts.teamstack.payment.model.dto.Payment;

import java.util.List;

public interface PaymentService {
    int insertPayment(Payment payment);
    List<Payment> searchAllPayment(String userId);
}
