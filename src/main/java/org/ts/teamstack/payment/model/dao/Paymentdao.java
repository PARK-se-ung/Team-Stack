package org.ts.teamstack.payment.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.payment.model.dto.Payment;

public interface Paymentdao {
    int insertPayment(SqlSession session,Payment payment);
}
