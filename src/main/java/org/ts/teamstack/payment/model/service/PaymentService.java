package org.ts.teamstack.payment.model.service;

import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.payment.model.dto.Payment;

import java.util.List;
import java.util.Map;

public interface PaymentService {
    int insertPayment(Payment payment,Map<String,Object> params);
    List<Payment> searchAllPayment(String userId, PageInfo pageInfo);
    int searchPaymentCount(String userId);
    boolean existsByPaymentId(String merchantUid);
    String getImpUid(Map<String,Object> map);

    String getPaymentId(String impUid);

    int insertRefund(String paymentId,Map<String,Object> deleteApply);
}
