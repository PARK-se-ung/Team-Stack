package org.ts.teamstack.classpage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.classpage.model.dto.Board;
import org.ts.teamstack.classpage.model.dto.Chat;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;

public interface ClassPageDao1 {

    //진행중인 강의목록
    List<Course> getOngoingCourses(SqlSession session, String userId);
    //진행완료된 강의목록
    List<Course> getCompletedCourses(SqlSession session, String userId);
    //모든 강의목록
    List<Course> getAllCourses(SqlSession session, String userId);

    List<Board> getHomeNotice(SqlSession session, int courseNo);

    List<Board> getHomeAssign(SqlSession session, int courseNo);

    List<Chat>  getChattingHistory(SqlSession session, int courseNo);

    int setChattingHistory(SqlSession session, Chat chat);
}
