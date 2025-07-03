package org.ts.teamstack.payment.model.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dao.CourseDao;
import org.ts.teamstack.course.service.CourseService;
import org.ts.teamstack.payment.model.dao.Paymentdao;
import org.ts.teamstack.payment.model.dto.Payment;
import org.ts.teamstack.payment.model.dto.Refund;

import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
@Slf4j
public class PaymentServiceImpl implements PaymentService {

    private final Paymentdao dao;
    private final SqlSession sqlSession;

    @Override
    @Transactional
    public int insertPayment(Payment payment,Map<String,Object> param) {

        int result = dao.insertPayment(sqlSession, payment);
        if(result > 0){
            result = dao.insertApply(sqlSession,param);
        }
        return result;
    }
    @Override
    @Transactional
    public int updateRefundStatus(String paymentId,Map<String,Object> deleteApply) {
        int result = dao.updateRefundStatus(sqlSession,paymentId);
        if(result > 0){
            log.info("deleteApply result: {}", result);
            result = dao.deleteApply(sqlSession,deleteApply);
        }
        return result;
    }
    @Override
    public List<Payment> searchAllPurchase(String userId, PageInfo pageInfo) {
        return dao.searchAllPurchase(sqlSession,userId,pageInfo);
    }

    @Override
    public int searchPurchaseCount(String userId) {
        return dao.searchPurchaseCount(sqlSession,userId);
    }
    @Override
    public boolean existsByPaymentId(String merchantUid) {
        return dao.existsByPaymentId(sqlSession,merchantUid);
    }

    @Override
    public String getImpUid(Map<String,Object> map) {
        return dao.getImpUid(sqlSession,map);
    }

    @Override
    public String getPaymentId(String impUid) {
        return dao.getPaymentId(sqlSession,impUid);
    }

    @Override
    public int searchSalesCount(String userId) {
        return dao.searchSalesCount(sqlSession,userId);
    }

    @Override
    public List<Payment> searchAllSales(String userId, PageInfo pageInfo) {
        return dao.searchAllSales(sqlSession,userId,pageInfo);
    }

    @Override
    public int insertRefundRequest(String paymentId) {
        return dao.insertRefundRequest(sqlSession,paymentId);
    }

    @Override
    @Transactional
    public int insertRefundRequest2(String paymentId,Map<String,Object> deleteApply) {

        int result = dao.insertRefundRequest2(sqlSession,paymentId);
        if(result > 0){
            log.info("deleteApply result: {}", result);
            result = dao.deleteApply(sqlSession,deleteApply);
        }

        return result;
    }

    @Override
    public int searchRefundCount(String userId) {
        return dao.searchRefundCount(sqlSession,userId);
    }

    @Override
    public List<Refund> searchAllRefund(String userId, PageInfo pageInfo) {
        return dao.searchAllRefund(sqlSession,userId,pageInfo);
    }

    @Override
    public int denyRefundStatus(String paymentId) {
        return dao.denyRefundStatus(sqlSession,paymentId);
    }
}
