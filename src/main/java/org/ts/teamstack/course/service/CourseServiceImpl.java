package org.ts.teamstack.course.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ts.teamstack.course.model.dao.CourseDao;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseApplyDto;
import org.ts.teamstack.course.model.dto.CourseAttach;

import java.util.List;
import java.util.Map;

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
                attach.setCourseNo(course.getCourseNo());
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

    @Override
    public List<CourseApplyDto> searchCourseApplyStudents(String userId) {
        return courseDao.searchCourseApplyStudents(sqlSession, userId);
    }

    @Override
    public int applyCourseChange(Map<String, Object> param) {
        return courseDao.applyCourseChange(sqlSession,param);
    }

    @Override
    @Transactional
    public int deleteApply(Map<String, Object> param) {
        int result = courseDao.deleteApply(sqlSession,param);
        if(result > 0){

        }
        return result;
    }
}
