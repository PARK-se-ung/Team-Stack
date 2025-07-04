package org.ts.teamstack.home.service;

import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Apply;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.manager.model.dto.Alarm;

import java.util.List;
import java.util.Map;

public interface HomeService {
    Map<String, List<Course>> homeCourses(String keyword);
    List<Course> selectCoursesByCourseNos(List<Integer> courseNoList);
    Course searchCourseByNo(int courseNo);
    int searchCountBookmark(String userId, int courseNo);
    int convertBookmark(String status, int courseNo, String userId);
    List<Course> searchCoursesByInstructor(String userId);
    List<Course> searchCourseByRest(Map<String, Object> parsedParams, PageInfo pageInfo);
    int searchCourseCount(Map<String, Object> parsedParams);
    List<Alarm> searchAlarm(String userId);
    int updateAlarm(int no);
    Apply searchApply(String userId, int courseNo);
}
