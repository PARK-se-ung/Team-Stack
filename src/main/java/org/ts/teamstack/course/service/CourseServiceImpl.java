package org.ts.teamstack.course.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ts.teamstack.course.model.dao.CourseDao;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseAttach;

@Service
@RequiredArgsConstructor
public class CourseServiceImpl implements CourseService {

    private final CourseDao courseDao;
    private final SqlSession sqlSession;

    @Override
    @Transactional
    public int insertCourse(Course course) {
        int result = courseDao.insertCourse(sqlSession, course);
        if(result > 0){
            for(CourseAttach attach : course.getFiles()){
                int flag = courseDao.insertAttach(sqlSession, attach);
                if(flag == 0) {
                    throw new RuntimeException("attach insert fail");
                }
            }
        }
        return result;
    }

    @Override
    public int deleteBookmark(int bookmarkNo) {
        return courseDao.deleteBookmark(sqlSession,bookmarkNo);
    }

    @Override
    public Course searchCourseByNo(int courseNo) {
        return courseDao.searchCourseByNo(sqlSession, courseNo);
    }

    @Override
    public int getCoursePrice(int courseNo) {
        return courseDao.getCoursePrice(sqlSession, courseNo);
    }
}
