package org.ts.teamstack.payment.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.payment.model.dto.Payment;

import java.util.List;
import java.util.Map;

@Repository
public class PaymentdaoImpl implements Paymentdao {
    @Override
    public int insertPayment(SqlSession session, Payment payment) {
        return session.insert("payment.insertPayment",payment);
    }

    @Override
    public List<Payment> searchAllPurchase(SqlSession session,String userId, PageInfo pageInfo) {
        RowBounds rb = new RowBounds((pageInfo.getCurPage() - 1) * pageInfo.getNumPerpage(), pageInfo.getNumPerpage());
        return session.selectList("payment.searchAllPurchase",userId,rb);
    }

    @Override
    public int searchPurchaseCount(SqlSession session, String userId) {
        return session.selectOne("payment.searchPurchaseCount",userId);
    }

    @Override
    public boolean existsByPaymentId(SqlSession session, String merchantUid) {
            int result = session.selectOne("payment.existsByPaymentNo",merchantUid);

        return result > 0;
        //카운트가 0보다 크면 중복값이 있다는 것
        //중복값이 없으면 false가 나오지
    }

    @Override
    public String getImpUid(SqlSession sqlSession, Map<String,Object> map) {
        return sqlSession.selectOne("payment.getImpUid",map);
    }

    @Override
    public int insertApply(SqlSession sqlSession, Map<String, Object> param) {
        return sqlSession.insert("payment.insertApply",param);
    }

    @Override
    public String getPaymentId(SqlSession sqlSession, String impUid) {
        return sqlSession.selectOne("payment.getPaymentId",impUid);
    }

    @Override
    public int insertRefund(SqlSession sqlSession, String paymentId) {
        return sqlSession.insert("payment.insertRefund",paymentId);
    }

    @Override
    public int deleteApply(SqlSession sqlSession, Map<String, Object> deleteApply) {
        return sqlSession.delete("payment.deleteApply",deleteApply);
    }

    @Override
    public int searchSalesCount(SqlSession sqlSession, String userId) {
        return sqlSession.selectOne("payment.searchSalesCount",userId);
    }

    @Override
    public List<Payment> searchAllSales(SqlSession sqlSession, String userId, PageInfo pageInfo) {
        return sqlSession.selectList("payment.searchAllSales",userId,pageInfo.getRowBounds());
    }
}
