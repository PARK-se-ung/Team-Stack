package org.ts.teamstack.course.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseAttach;

public interface CourseDao {
    int insertCourse(SqlSession session,Course course);
    int insertAttach(SqlSession session,CourseAttach attach);
    int deleteBookmark(SqlSession sqlSession,int bookmarkNo);
}
