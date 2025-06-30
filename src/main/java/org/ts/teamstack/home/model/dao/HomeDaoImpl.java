package org.ts.teamstack.home.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;
import java.util.Map;

@Repository
public class HomeDaoImpl implements HomeDao {

    @Override
    public List<Course> selectCoursesByCourseNos(SqlSession session, List<Integer> courseNoList) {
        return session.selectList("home.selectCoursesByCourseNos", courseNoList);
    }

    @Override
    public List<Course> selectElementaryCourses(SqlSession session){
        return session.selectList("home.selectElementaryCourses", null, new RowBounds(0, 5));
    }

    @Override
    public List<Course> selectMiddleCourses(SqlSession session) {
        return session.selectList("home.selectMiddleCourses", null, new RowBounds(0, 5));
    }
    @Override
    public List<Course> selectHighCourses(SqlSession session) {
        return session.selectList("home.selectHighCourses", null, new RowBounds(0, 5));
    }

    @Override
    public Course searchCourseByNo(SqlSession session, int courseNo) {
        return session.selectOne("home.selectCourseByNo", courseNo);
    }

    @Override
    public List<Course> searchCourseByRest(SqlSession session, Map<String, Object> parsedParams, PageInfo pageInfo) {
        return session.selectList("home.searchCourseByRest", parsedParams, pageInfo.getRowBounds());
    }

    @Override
    public int searchCourseCount(SqlSession session, Map<String, Object> parsedParams) {
        return session.selectOne("home.searchCourseCount", parsedParams);
    }

}
