package org.ts.teamstack.payment.model.service;

import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.payment.model.dto.Payment;

import java.util.List;

public interface PaymentService {
    int insertPayment(Payment payment);
    List<Payment> searchAllPayment(String userId, PageInfo pageInfo);
    int searchPaymentCount(String userId);
    boolean existsByPaymentId(String merchantUid);
}
