package org.ts.teamstack.classpage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.classpage.model.dto.Board;
import org.ts.teamstack.classpage.model.dto.Chat;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;

@Repository
public class ClassPageDaoImpl1 implements ClassPageDao1{

    @Override
    public List<Course> getOngoingCourses(SqlSession session, String userId) {
        return session.selectList("getOngoingCourses", userId);
    }

    @Override
    public List<Course> getCompletedCourses(SqlSession session, String userId) {
        return session.selectList("getCompletedCourses", userId);
    }

    @Override
    public List<Course> getAllCourses(SqlSession session, String userId) {
        return session.selectList("getAllCourses", userId);
    }

    @Override
    public List<Board> getHomeNotice(SqlSession session, int courseNo) {
        return session.selectList("getHomeNotice", courseNo);
    }

    @Override
    public List<Board> getHomeAssign(SqlSession session, int courseNo) {
        return session.selectList("getHomeAssign", courseNo);
    }

    @Override
    public List<Chat> getChattingHistory(SqlSession session, int courseNo) {
        return (session.selectList("getChattingHistory", courseNo));
    }

    @Override
    public int setChattingHistory(SqlSession session,Chat chat) {
        return (session.insert("setChattingHistory", chat));
    }
}
