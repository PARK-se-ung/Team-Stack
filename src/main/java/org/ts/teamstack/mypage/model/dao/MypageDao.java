package org.ts.teamstack.mypage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Apply;
import org.ts.teamstack.course.model.dto.Bookmark;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.manager.model.dto.Approve;

import java.util.List;
import java.util.Map;

public interface MypageDao {
    List<Course> selectBookmarkAll(SqlSession sqlSession, String userId, PageInfo pageInfo);
    int selectBookmarkCount(SqlSession sqlSession, String userId);
    List<Course> selectReserveAll(SqlSession session, String userId,PageInfo pageInfo);
    int selectReserveCount(SqlSession session, String userId);

    int selectApplyCount(SqlSession session, String userId);

    List<Course> selectApplyAll(SqlSession session, String userId, PageInfo pageInfo);

    int selectTakeCount(SqlSession session, String userId);

    List<Course> selectTakeAll(SqlSession session, String userId, PageInfo pageInfo);

    int selectCompleteCount(SqlSession session, String userId);

    List<Course> selectCompleteAll(SqlSession session, String userId, PageInfo pageInfo);

    int insertApprove(SqlSession session, Approve approve);

    String selectApprove(SqlSession session, String userId);
}
