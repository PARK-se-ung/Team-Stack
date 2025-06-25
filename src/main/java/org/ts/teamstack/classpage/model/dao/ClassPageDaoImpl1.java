package org.ts.teamstack.classpage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;
import java.util.Map;

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
}
