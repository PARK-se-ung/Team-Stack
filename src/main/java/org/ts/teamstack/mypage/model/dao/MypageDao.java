package org.ts.teamstack.mypage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Bookmark;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;

public interface MypageDao {
    List<Course> selectBookmarkAll(SqlSession sqlSession, String userId, PageInfo pageInfo);
    int selectBookmarkCount(SqlSession sqlSession, String userId);
}
