package org.ts.teamstack.mypage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.course.model.dto.Bookmark;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;

@Repository
public class MypageDaoImpl implements MypageDao {
    @Override
    public List<Course> selectBookmarkAll(SqlSession session, String userId) {
        return session.selectList("bookmark.selectBookmarkAll",userId);
    }
}
