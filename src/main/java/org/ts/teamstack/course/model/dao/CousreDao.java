package org.ts.teamstack.course.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.course.model.dto.Course;

public interface CousreDao {
    int insertCourse(SqlSession session,Course course);
}
