package org.ts.teamstack.payment.model.service;

import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.payment.model.dto.Payment;
import org.ts.teamstack.payment.model.dto.Refund;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.util.List;
import java.util.Map;

public interface PaymentService {
    int insertPayment(Payment payment,Map<String,Object> params);
    List<Payment> searchAllPurchase(String userId, PageInfo pageInfo);
    int searchPurchaseCount(String userId);
    boolean existsByPaymentId(String merchantUid);
    String getImpUid(Map<String,Object> map);

    String getPaymentId(String impUid);

    int searchSalesCount(String userId);

    List<Payment> searchAllSales(String userId, PageInfo pageInfo);

    int insertRefundRequest(String paymentId);

    int insertRefundRequest2(String paymentId,Map<String,Object> deleteApply);


    int searchRefundCount(String userId);

    List<Refund> searchAllRefund(String userId, PageInfo pageInfo);

    int updateRefundStatus(String paymentId, Map<String, Object> deleteApply);

    int denyRefundStatus( Map<String, Object> request);

    int insertRefundAndUpdateApply(int courseNo, String userId);
}
