package org.ts.teamstack.course.service;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseAttach;

public interface CourseService {
    int insertCourse(Course course);
    int insertAttach(CourseAttach attach);
    int deleteBookmark(int bookmarkNo);
}
