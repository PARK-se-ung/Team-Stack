package org.ts.teamstack.course.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.ts.teamstack.course.model.dao.CourseDao;
import org.ts.teamstack.course.model.dto.Course;

@Service
@RequiredArgsConstructor
public class CourseServiceImpl implements CourseService {

    private final CourseDao courseDao;
    private final SqlSession sqlSession;

    @Override
    public int insertCourse(Course course) {
        return courseDao.insertCourse(sqlSession, course);
    }

    @Override
    public int deleteBookmark(int bookmarkNo) {
        return courseDao.deleteBookmark(sqlSession,bookmarkNo);
    }
}
