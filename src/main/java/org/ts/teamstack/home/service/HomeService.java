package org.ts.teamstack.home.service;

import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.manager.model.dto.Alarm;

import java.util.List;
import java.util.Map;

public interface HomeService {
    Map<String, List<Course>> homeCourses();
    List<Course> selectCoursesByCourseNos(List<Integer> courseNoList);
    Course searchCourseByNo(int courseNo);
    List<Course> searchCourseByRest(Map<String, Object> parsedParams, PageInfo pageInfo);
    int searchCourseCount(Map<String, Object> parsedParams);
    List<Alarm> searchAlarm(String userId);
    int updateAlarm(int no);
}
