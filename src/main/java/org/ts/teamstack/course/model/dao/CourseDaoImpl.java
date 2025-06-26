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

    @Override
    public int deleteBookmark(SqlSession session, int bookmarkNo) {
        return session.delete("course.deleteBookmark", bookmarkNo);
    }

    @Override
    public Course searchCourseByNo(SqlSession session, int courseNo) {
        return session.selectOne("course.searchCourseByNo", courseNo);
    }
}

