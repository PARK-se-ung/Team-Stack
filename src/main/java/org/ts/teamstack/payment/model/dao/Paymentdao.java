package org.ts.teamstack.payment.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.payment.model.dto.Payment;

import java.util.List;
import java.util.Map;

public interface Paymentdao {
    int insertPayment(SqlSession session,Payment payment);
    List<Payment> searchAllPurchase(SqlSession session, String userId, PageInfo pageInfo);
    int searchPurchaseCount(SqlSession session, String userId);

    boolean existsByPaymentId(SqlSession sqlSession, String merchantUid);

    String getImpUid(SqlSession sqlSession, Map<String,Object> map);

    int insertApply(SqlSession sqlSession, Map<String, Object> param);

    String getPaymentId(SqlSession sqlSession, String impUid);

    int insertRefund(SqlSession sqlSession, String paymentId);

    int deleteApply(SqlSession sqlSession, Map<String, Object> deleteApply);

    int searchSalesCount(SqlSession sqlSession, String userId);

    List<Payment> searchAllSales(SqlSession sqlSession, String userId, PageInfo pageInfo);
}
