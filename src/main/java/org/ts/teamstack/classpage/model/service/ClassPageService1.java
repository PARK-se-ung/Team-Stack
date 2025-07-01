package org.ts.teamstack.classpage.model.service;

import org.ts.teamstack.classpage.model.dto.Assign;
import org.ts.teamstack.classpage.model.dto.Board;
import org.ts.teamstack.classpage.model.dto.Schedule;
import org.ts.teamstack.classpage.model.dto.Chat;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;

public interface ClassPageService1 {

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
}
