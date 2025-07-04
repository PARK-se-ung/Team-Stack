package org.ts.teamstack.mypage.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Apply;
import org.ts.teamstack.course.model.dto.Bookmark;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.manager.model.dto.Approve;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Override
    public int insertApprove(SqlSession session, Approve approve) {
        return session.insert("manager.insertApprove",approve);
    }

    @Override
    public String selectApprove(SqlSession session, String userId) {
        return session.selectOne("manager.selectApprove",userId);
    }

    @Override
    public List<Course> getCoursesByStatus(SqlSession session, String courseStatus, String userId ) {
        Map<String,Object> param = new HashMap<>();
        param.put("courseStatus", courseStatus);
        param.put("userId",       userId);

        return session.selectList("course.getCoursesByStatus", param);
    }

    @Override
    public List<Course> selectTakeCourses(SqlSession session, String userId) {
        Map<String, Object> param = new HashMap<>();
        param.put("userId", userId);

        return session.selectList("course.selectTakeCourses", param);
    }

    @Override
    public List<Course> selectCompleteCourses(SqlSession session, String userId) {
        Map<String,Object> param = new HashMap<>();
        param.put("userId", userId);
        return session.selectList(
                "course.selectCompleteCourses",param);
    }
}
