package org.ts.teamstack.payment.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.payment.model.dto.Payment;

import java.util.List;

@Repository
public class PaymentdaoImpl implements Paymentdao {
    @Override
    public int insertPayment(SqlSession session, Payment payment) {
        return session.insert("payment.insertPayment",payment);
    }

    @Override
    public List<Payment> searchAllPayment(SqlSession session,String userId, PageInfo pageInfo) {
        RowBounds rb = new RowBounds((pageInfo.getCurPage() - 1) * pageInfo.getNumPerpage(), pageInfo.getNumPerpage());
        return session.selectList("payment.searchAllPayment",userId,rb);
    }

    @Override
    public int searchPaymentCount(SqlSession session, String userId) {
        return session.selectOne("payment.searchPaymentCount",userId);
    }

    @Override
    public boolean existsByPaymentId(SqlSession session, String merchantUid) {
            int result = session.selectOne("payment.existsByPaymentNo",merchantUid);

        return result > 0;
        //카운트가 0보다 크면 중복값이 있다는 것
        //중복값이 없으면 false가 나오지
    }

}
