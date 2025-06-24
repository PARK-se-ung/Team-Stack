package org.ts.teamstack.payment.model.service;

import org.ts.teamstack.payment.model.dto.Payment;

public interface PaymentService {
    int insertPayment(Payment payment);
}
