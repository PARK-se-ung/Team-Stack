package org.ts.teamstack.home.service;


import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.home.model.dao.HomeDao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

}
