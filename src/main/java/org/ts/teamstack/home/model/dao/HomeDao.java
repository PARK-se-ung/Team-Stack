package org.ts.teamstack.home.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;
import java.util.Map;

public interface HomeDao {
    List<Course>  selectCoursesByCourseNos(SqlSession session, List<Integer> courseNoList);
    List<Course> selectElementaryCourses(SqlSession session);
    List<Course> selectMiddleCourses(SqlSession session);
    List<Course> selectHighCourses(SqlSession session);
    Course searchCourseByNo(SqlSession session, int courseNo);
}
