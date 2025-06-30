package org.ts.teamstack.home.service;


import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseAttach;
import org.ts.teamstack.home.model.dao.HomeDao;

import java.util.*;

@Service
@RequiredArgsConstructor
public class HomeServiceImpl implements HomeService {

    private final HomeDao dao;
    private final SqlSession session;

    public Map<String, List<Course>> homeCourses() {
        Map<String, List<Course>> map = new HashMap<>();
        List<Course> elem = dao.selectElementaryCourses(session);
        List<Course> midd = dao.selectMiddleCourses(session);
        List<Course> high = dao.selectHighCourses(session);
        map.put("elem", elem);
        map.put("midd", midd);
        map.put("high", high);
        return map;
    };

    @Override
    public Course searchCourseByNo(int courseNo) {
        Course course = dao.searchCourseByNo(session, courseNo);
        if(course.getFiles() != null) {
            course.getFiles().sort(Comparator.comparingInt(CourseAttach::getCourseAttachLevel));
        }
        return course;
    }

    @Override
    public List<Course> selectCoursesByCourseNos(List<Integer> courseNoList) {
        return dao.selectCoursesByCourseNos(session, courseNoList);
    }

    @Override
    public List<Course> searchCourseByRest(Map<String, Object> parsedParams, PageInfo  pageInfo) {
        return dao.searchCourseByRest(session, parsedParams, pageInfo);
    }
}
