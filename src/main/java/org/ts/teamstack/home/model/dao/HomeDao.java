package org.ts.teamstack.home.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.manager.model.dto.Alarm;

import java.util.List;
import java.util.Map;

public interface HomeDao {
    List<Course>  selectCoursesByCourseNos(SqlSession session, List<Integer> courseNoList);
    List<Course> selectElementaryCourses(SqlSession session, String keyword);
    List<Course> selectMiddleCourses(SqlSession session, String keyword);
    List<Course> selectHighCourses(SqlSession session, String keyword);
    Course searchCourseByNo(SqlSession session, int courseNo);
    int searchCountBookmark(SqlSession session, String userId, int  courseNo);
    int insertBookmark(SqlSession session, int courseNo, String userId);
    int deleteBookmark(SqlSession session, int courseNo, String userId);
    List<Course> searchCoursesByInstructor(SqlSession session, String userId);
    List<Course> searchCourseByRest(SqlSession session, Map<String, Object> parsedParams, PageInfo pageInfo);
    int searchCourseCount(SqlSession session,  Map<String, Object> parsedParams);
    List<Alarm> searchAlarm(SqlSession session, String userId);
    int updateAlarm(SqlSession session, int no);
    int searchApply(SqlSession session, String userId, int courseNo);
}
