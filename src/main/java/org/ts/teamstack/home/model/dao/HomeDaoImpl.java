package org.ts.teamstack.home.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Apply;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.manager.model.dto.Alarm;

import java.util.List;
import java.util.Map;

@Repository
public class HomeDaoImpl implements HomeDao {

    @Override
    public List<Alarm> searchAlarm(SqlSession session, String userId) {
        return session.selectList("home.searchAlarm", userId, new RowBounds(0, 5));
    }

    @Override
    public int updateAlarm(SqlSession session, int no) {
        return session.update("home.updateAlarm", no);
    }

    @Override
    public List<Course> selectCoursesByCourseNos(SqlSession session, List<Integer> courseNoList) {
        return session.selectList("home.selectCoursesByCourseNos", courseNoList);
    }

    @Override
    public List<Course> selectElementaryCourses(SqlSession session, String keyword) {
        return session.selectList("home.selectElementaryCourses", keyword, new RowBounds(0, 5));
    }

    @Override
    public List<Course> selectMiddleCourses(SqlSession session, String keyword) {
        return session.selectList("home.selectMiddleCourses", keyword, new RowBounds(0, 5));
    }
    @Override
    public List<Course> selectHighCourses(SqlSession session, String keyword) {
        return session.selectList("home.selectHighCourses", keyword, new RowBounds(0, 5));
    }

    @Override
    public Course searchCourseByNo(SqlSession session, int courseNo) {
        return session.selectOne("home.selectCourseByNo", courseNo);
    }

    @Override
    public int searchCountBookmark(SqlSession session, String userId, int courseNo) {
        return session.selectOne("home.searchCountBookmark", Map.of("userId",  userId, "courseNo", courseNo));
    }

    @Override
    public int insertBookmark(SqlSession session, int courseNo, String userId) {
        return session.insert("home.insertBookmark", Map.of("userId",  userId, "courseNo", courseNo));
    }

    @Override
    public int deleteBookmark(SqlSession session, int courseNo, String userId) {
        return session.delete("home.deleteBookmark", Map.of("userId",  userId, "courseNo", courseNo));
    }

    @Override
    public List<Course> searchCoursesByInstructor(SqlSession session, String userId) {
        return session.selectList("home.searchCoursesByInstructor", userId, new RowBounds(0, 5));
    }

    @Override
    public List<Course> searchCourseByRest(SqlSession session, Map<String, Object> parsedParams, PageInfo pageInfo) {
        return session.selectList("home.searchCourseByRest", parsedParams, pageInfo.getRowBounds());
    }

    @Override
    public int searchCourseCount(SqlSession session, Map<String, Object> parsedParams) {
        return session.selectOne("home.searchCourseCount", parsedParams);
    }

    @Override
    public Apply searchApply(SqlSession session, String userId, int courseNo) {
        return session.selectOne("home.searchApply", Map.of("userId",  userId, "courseNo", courseNo));
    }

}
