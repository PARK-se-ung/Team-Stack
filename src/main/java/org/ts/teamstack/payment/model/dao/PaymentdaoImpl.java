package org.ts.teamstack.payment.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.payment.model.dto.Payment;

import java.util.List;

@Repository
public class PaymentdaoImpl implements Paymentdao {
    @Override
    public int insertPayment(SqlSession session, Payment payment) {
        return session.insert("payment.insertPayment",payment);
    }

    @Override
    public List<Payment> searchAllPayment(SqlSession session,String userId) {
        return session.selectList("payment.searchAllPayment",userId);
    }
}
