package org.ts.teamstack.home.service;

import org.ts.teamstack.course.model.dto.Course;

import java.util.List;
import java.util.Map;

public interface HomeService {
    Map<String, List<Course>> homeCourses();
    List<Course> selectCoursesByCourseNos(List<Integer> courseNoList);
    Course searchCourseByNo(int courseNo);
}
