package org.ts.teamstack.mypage.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Apply;
import org.ts.teamstack.course.model.dto.Bookmark;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;

@Repository
public class MypageDaoImpl implements MypageDao {

    @Override
    public List<Course> selectBookmarkAll(SqlSession session, String userId, PageInfo pageInfo) {
        //RowBounds rb = new RowBounds((pageInfo.getCurPage() - 1) * pageInfo.getNumPerpage(), pageInfo.getNumPerpage());
//        return session.selectList("bookmark.selectBookmarkAll",userId, rb);
        return session.selectList("bookmark.selectBookmarkAll",userId, pageInfo.getRowBounds());
    }

    @Override
    public int selectBookmarkCount(SqlSession sqlSession, String userId) {
        return sqlSession.selectOne( "bookmark.selectBookmarkCount",userId);
    }

    @Override
    public List<Course> selectReserveAll(SqlSession session, String userId,PageInfo pageInfo) {
        return session.selectList("apply.selectReserveAll",userId,pageInfo.getRowBounds());
    }

    @Override
    public int selectReserveCount(SqlSession session, String userId) {
        return session.selectOne( "apply.selectReserveCount",userId);
    }

    @Override
    public int selectApplyCount(SqlSession session, String userId) {
        return session.selectOne( "apply.selectApplyCount",userId);
    }

    @Override
    public List<Course> selectApplyAll(SqlSession session, String userId, PageInfo pageInfo) {
        return session.selectList("apply.selectApplyAll",userId,pageInfo.getRowBounds());
    }

    @Override
    public int selectTakeCount(SqlSession session, String userId) {
        return session.selectOne( "apply.selectTakeCount",userId);
    }

    @Override
    public List<Course> selectTakeAll(SqlSession session, String userId, PageInfo pageInfo) {
        return session.selectList("apply.selectTakeAll",userId,pageInfo.getRowBounds());
    }

    @Override
    public int selectCompleteCount(SqlSession session, String userId) {
        return session.selectOne( "apply.selectCompleteCount",userId);
    }

    @Override
    public List<Course> selectCompleteAll(SqlSession session, String userId, PageInfo pageInfo) {
        return session.selectList("apply.selectCompleteAll",userId,pageInfo.getRowBounds());
    }
}
