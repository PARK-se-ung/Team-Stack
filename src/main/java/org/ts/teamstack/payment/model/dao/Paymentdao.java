package org.ts.teamstack.payment.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.payment.model.dto.Payment;
import org.ts.teamstack.payment.model.dto.Refund;

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

    //int insertRefund(SqlSession sqlSession, String paymentId);

    int deleteApply(SqlSession sqlSession, Map<String, Object> deleteApply);

    int searchSalesCount(SqlSession sqlSession, String userId);

    List<Payment> searchAllSales(SqlSession sqlSession, String userId, PageInfo pageInfo);

    int insertRefundRequest(SqlSession sqlSession, String paymentId);

    int insertRefundRequest2(SqlSession sqlSession, String paymentId);

    List<Refund> searchAllRefund(SqlSession sqlSession, String userId, PageInfo pageInfo);

    int searchRefundCount(SqlSession sqlSession, String userId);

    int updateRefundStatus(SqlSession sqlSession, String paymentId);

    int denyRefundStatus(SqlSession sqlSession, String paymentId);

    int updateApply(SqlSession sqlSession, Map<String, Object> map);
}
