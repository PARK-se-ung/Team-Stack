package org.ts.teamstack.mypage.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.common.model.dto.PageInfo;
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
}
