package org.ts.teamstack.course.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.course.model.dto.Course;

@Repository
public class CourseDaoImpl implements CourseDao {
    @Override
    public int insertCourse(SqlSession session, Course course) {
        return session.insert("course.insertCourse", course);
    }
}

