package org.ts.teamstack.classpage.model.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.ts.teamstack.classpage.model.dao.ClassPageDao1;
import org.ts.teamstack.classpage.model.dto.Board;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ClassPageServiceImpl1 implements ClassPageService1 {

    private final SqlSession session;
    private final ClassPageDao1 classDao;

    @Override
    public List<Course> getAllCourses(String userId) {
        return classDao.getAllCourses(session, userId);
    }

    @Override
    public List<Course> getOngoingCourses(String userId) {
        return classDao.getOngoingCourses(session, userId);
    }

    @Override
    public List<Course> getCompletedCourses(String userId) {
        return classDao.getCompletedCourses(session, userId);
    }

    @Override
    public List<Board> getHomeNotice(int courseNo) {
        return classDao.getHomeNotice(session, courseNo);
    }

    @Override
    public List<Board> getHomeAssign(int courseNo) {
        return classDao.getHomeAssign(session, courseNo);
    }
}
