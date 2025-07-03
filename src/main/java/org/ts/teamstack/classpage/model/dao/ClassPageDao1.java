package org.ts.teamstack.classpage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.classpage.model.dto.*;
import org.ts.teamstack.course.model.dto.Course;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ClassPageDao1 {

    //진행중인 강의목록
    List<Course> getOngoingCourses(SqlSession session, String userId);
    //진행완료된 강의목록
    List<Course> getCompletedCourses(SqlSession session, String userId);
    //모든 강의목록
    List<Course> getAllCourses(SqlSession session, String userId);

    String checkUserType(SqlSession session, String userId);

    List<Course> getmyCourses(SqlSession session, String userId);

    Course getPlanFile(SqlSession session, int courseNo);

    List<Schedule> getCalDate(SqlSession session, int courseNo);

    List<Schedule> getCalAssign(SqlSession session, int courseNo);

    List<Board> getHomeNotice(SqlSession session, int courseNo);

    List<Assign> getHomeAssign(SqlSession session, int courseNo);

    List<Chat>  getChattingHistory(SqlSession session, int courseNo);

    int setChattingHistory(SqlSession session, Chat chat);

    Course getCourse(SqlSession session, int courseNo);

    List<Board> getNotice(SqlSession session, int courseNo);

    List<Schedule> getWeek(SqlSession session, int courseNo);

    List<Schedule> getStuAssigns(SqlSession session, int courseNo);

    Completion checkCompletion(SqlSession session, Course course);

    String getCourseId(SqlSession session, int courseNo);

    int getWeekForInsert(SqlSession session, int courseNo);

    List<Schedule> getWeekForInsert2(SqlSession session, int courseNo);

    int insertNotice(SqlSession session, Board notice);

    int assignCheck(SqlSession session, Schedule schedule);

    int aFileUpdate(SqlSession session, Assign assign);

    int aFileInsert(SqlSession session, Assign assign);

    int scheduleUpdate(SqlSession session, Schedule schedule);

    List<String> getUsersByCourseId(SqlSession session, int courseNo);

    List<Integer> getClassCount(SqlSession session, int courseNo);

    Date getStartDate(SqlSession session, int courseNo);

    int getAssignNo(SqlSession session, Assign assign);

    int stuAssignCheck(SqlSession session, StudentAssign studentAssign);

    int stuAssignUpdate(SqlSession session, StudentAssign studentAssign);

    int stuAssignInsert(SqlSession session, StudentAssign studentAssign);

    int insertAttend(SqlSession session, Attend attend);

    List<Attend> getAttendListByCourse(SqlSession session, int courseNo);

    List<Attend> getAttend(SqlSession session, String userId, int attendNo);

    int isUserEnrolled(SqlSession session, Course course);

    // 듣는 수강생 이름 가지고 오기
    List<String> getUserNameByCourseId(SqlSession session, int courseNo);

    List<Score> getAllScores(SqlSession session, int courseNo);

    Score scoreExist(SqlSession session, Score score);

    int updateScore(SqlSession session, Score score);

    int insertScore(SqlSession session, Score score);

    List<Score> searchUserScore (SqlSession session, String userId, int courseNo);
}
