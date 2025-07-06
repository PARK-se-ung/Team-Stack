package org.ts.teamstack.classpage.model.service;

import org.ts.teamstack.classpage.model.dto.*;
import org.ts.teamstack.course.model.dto.Course;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ClassPageService1 {

    List<Board> getClassesNotice(String userId);

    List<Course> getAllCourses(String userId);

    List<Course> getOngoingCourses(String userId);

    List<Course> getCompletedCourses(String userId);

    String checkUserType(String userId);

    List<Course> getmyCourses(String userId);

    Course getPlanFile(int courseNo);

    List<Schedule> getCalDate(int courseNo);

    List<Schedule> getCalAssign(int courseNo);

    List<Board> getHomeNotice(int courseNo);

    List<Assign> getHomeAssign(int courseNo);

    List<Board> getNotice(int courseNo);

    List<Schedule> getWeek(int courseNo);

    List<Schedule> getStuAssigns(int courseNo);

    Completion checkCompletion(Course course);

    String getCourseId(int courseNo);

    int getWeekForInsert(int courseNo);

    List<Schedule> getWeekForInsert2(int courseNo);

    List<Chat> getChattingHistory (int courseNo);

    int setChattingHistory (Chat chat);

    Course getCourse(int courseNo);

    int insertNotice(Board notice);

    int assignCheck(Schedule schedule);

    int aFileUpdate(Assign assign);

    int aFileInsert(Assign assign);

    int scheduleUpdate(Schedule schedule);

    List<String> getUsersByCourseId(int courseNo);

    List<Integer> getClassCount(int courseNo);

    Date getStartDate(int courseNo);

    int getAssignNo(Assign assign);

    int stuAssignCheck(StudentAssign studentAssign);

    int stuFileUpdate(StudentAssign studentAssign);

    int stuFileInsert(StudentAssign studentAssign);

    int insertAttend(Attend attend);

    Map<Integer, Integer> getAttendCountByRound(int courseNo);

    List<Attend> getAttend(String userId, int attendNo);

    List<String> getUserNameByCourseId(int courseNo);

    int isUserEnrolled(Course course);
    List<Score> getAllScores(int courseNo);

    Score scoreExist(Score score);

    int updateScore(Score score);

    int insertScore(Score score);

    List<Score> searchUserScore(String userId, int courseNo);

    boolean isAttendExists(Attend attend);

    int updateAttend (Attend attend);
}
