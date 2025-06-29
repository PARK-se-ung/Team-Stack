package org.ts.teamstack.home.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;
import java.util.Map;

@Repository
public class HomeDaoImpl implements HomeDao {

    @Override
    public List<Course> selectElementaryCourses(SqlSession session){
        return session.selectList("course.selectElementaryCourses");
    }

    @Override
    public List<Course> selectMiddleCourses(SqlSession session) {
        return session.selectList("course.selectMiddleCourses");
    }
    @Override
    public List<Course> selectHighCourses(SqlSession session) {
        return session.selectList("course.selectHighCourses");
    }
}
