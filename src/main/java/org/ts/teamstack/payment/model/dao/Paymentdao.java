package org.ts.teamstack.payment.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.payment.model.dto.Payment;

import java.util.List;

public interface Paymentdao {
    int insertPayment(SqlSession session,Payment payment);
    List<Payment> searchAllPayment(SqlSession session, String userId, PageInfo pageInfo);
    int searchPaymentCount(SqlSession session, String userId);
}
