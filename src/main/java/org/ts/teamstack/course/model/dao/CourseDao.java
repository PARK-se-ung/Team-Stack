package org.ts.teamstack.course.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseApplyDto;
import org.ts.teamstack.course.model.dto.CourseAttach;

import java.util.List;
import java.util.Map;

public interface CourseDao {
    int insertCourse(SqlSession session,Course course);
    int insertAttach(SqlSession session,CourseAttach attach);
    int deleteBookmark(SqlSession sqlSession,int bookmarkNo);
    Course searchCourseByNo(SqlSession session, int courseNo);
    int getCoursePrice(SqlSession session,int courseNo);
    List<CourseApplyDto> searchCourseApplyStudents(SqlSession sesison, String userId);
    int applyCourseChange(SqlSession session, Map<String,Object> param);
    int deleteApply(SqlSession session, Map<String,Object> param);
}
