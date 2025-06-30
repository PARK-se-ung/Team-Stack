package org.ts.teamstack.payment.model.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.payment.model.dao.Paymentdao;
import org.ts.teamstack.payment.model.dto.Payment;

import java.util.List;

@RequiredArgsConstructor
@Service
public class PaymentServiceImpl implements PaymentService {


    private final Paymentdao dao;
    private final SqlSession sqlSession;

    @Override
    public int insertPayment(Payment payment) {

        return dao.insertPayment(sqlSession, payment);
    }

    @Override
    public List<Payment> searchAllPayment(String userId, PageInfo pageInfo) {
        return dao.searchAllPayment(sqlSession,userId,pageInfo);
    }

    @Override
    public int searchPaymentCount(String userId) {
        return dao.searchPaymentCount(sqlSession,userId);
    }
    @Override
    public boolean existsByPaymentId(String merchantUid) {
        return dao.existsByPaymentId(sqlSession,merchantUid);
    }

}
