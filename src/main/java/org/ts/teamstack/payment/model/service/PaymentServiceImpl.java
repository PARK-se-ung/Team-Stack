package org.ts.teamstack.payment.model.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.ts.teamstack.payment.model.dto.Payment;

@RequiredArgsConstructor
@Service
public class PaymentServiceImpl implements PaymentService {

    private final SqlSession sqlSession;

    @Override
    public int insertPayment(Payment payment) {

        return 0;
    }
}
