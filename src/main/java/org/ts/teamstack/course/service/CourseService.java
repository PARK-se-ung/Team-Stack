package org.ts.teamstack.course.service;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.course.model.dto.Course;

public interface CourseService {
    int insertCourse(Course course);
}
