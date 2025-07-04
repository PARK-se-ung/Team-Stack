package org.ts.teamstack.course.service;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseApplyDto;
import org.ts.teamstack.course.model.dto.CourseAttach;

import java.util.List;
import java.util.Map;

public interface CourseService {
    int insertCourse(Course course);
    int deleteBookmark(int bookmarkNo);
    Course searchCourseByNo(int courseNo);
    int getCoursePrice(int courseNo);
    List<CourseApplyDto> searchCourseApplyStudents(String userId);
    int applyCourseChange(Map<String,Object> param);
    int deleteApply(Map<String,Object> param);
}
