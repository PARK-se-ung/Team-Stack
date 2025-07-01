package org.ts.teamstack.classpage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.classpage.model.dto.Board;
import org.ts.teamstack.classpage.model.dto.Chat;
import org.ts.teamstack.classpage.model.dto.Schedule;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.classpage.model.dto.Assign;

import java.util.List;

@Repository
public class ClassPageDaoImpl1 implements ClassPageDao1{

    @Override
    public List<Course> getOngoingCourses(SqlSession session, String userId) {
        return session.selectList("getOngoingCourses", userId);
    }

    @Override
    public List<Course> getCompletedCourses(SqlSession session, String userId) {
        return session.selectList("getCompletedCourses", userId);
    }

    @Override
    public List<Course> getAllCourses(SqlSession session, String userId) {
        return session.selectList("getAllCourses", userId);
    }

    @Override
    public String checkUserType(SqlSession session, String userId) {
        return session.selectOne("checkUserType", userId);
    }

    @Override
    public List<Course> getmyCourses(SqlSession session, String userId) {
        return session.selectList("getmyCourses", userId);
    }

    @Override
    public Course getPlanFile(SqlSession session, int courseNo) {
        return session.selectOne("getPlanFile", courseNo);
    }

    @Override
    public List<Chat> getChattingHistory(SqlSession session, int courseNo) {
        return (session.selectList("classes.getChatHistory", courseNo));
    }

    @Override
    public int setChattingHistory(SqlSession session,Chat chat) {
        return (session.insert("classes.setChatHistory", chat));
    }

    @Override
    public Course getCourse(SqlSession session, int courseNo) {
        return (session.selectOne("classes.getCourse", courseNo));
    }

    @Override
    public List<Schedule> getCalDate(SqlSession session, int courseNo) {
        return session.selectList("getCalDate",courseNo);
    }

    @Override
    public List<Schedule> getCalAssign(SqlSession session, int courseNo) {
        return session.selectList("getCalAssign",courseNo);
    }

    @Override
    public List<Board> getHomeNotice(SqlSession session, int courseNo) {
        return session.selectList("getHomeNotice", courseNo);
    }

    @Override
    public List<Assign> getHomeAssign(SqlSession session, int courseNo) {
        return session.selectList("getHomeAssign", courseNo);
    }

    @Override
    public List<Board> getNotice(SqlSession session, int courseNo) {
        return session.selectList("getDashNotice", courseNo);
    }

    @Override
    public List<Schedule> getWeek(SqlSession session, int courseNo) {
        return session.selectList("getWeek", courseNo);
    }

    @Override
    public String getCourseId(SqlSession session, int courseNo) {
        return session.selectOne("getCourseId", courseNo);
    }

    @Override
    public int getWeekForInsert(SqlSession session, int courseNo) {
        return session.selectOne("getWeekForInsert", courseNo);
    }

    @Override
    public List<Schedule> getWeekForInsert2(SqlSession session, int courseNo) {
        return session.selectList("getWeekForInsert2", courseNo);
    }

    @Override
    public int insertNotice(SqlSession session, Board notice) {
        return session.insert("insertBoardNotice", notice);
    }

    @Override
    public int assignCheck(SqlSession session, Schedule schedule) {
        return session.selectOne("assignCheck", schedule);
    }

    @Override
    public int aFileUpdate(SqlSession session, Assign assign) {
        return session.update("aFileUpdate", assign);
    }

    @Override
    public int aFileInsert(SqlSession session, Assign assign) {
        return session.insert("aFileInsert", assign);
    }

    @Override
    public int scheduleUpdate(SqlSession session, Schedule schedule) {
        return session.update("scheduleUpdate", schedule);
    }

    @Override
    public List<String> getUsersByCourseId(SqlSession session, int courseNo) {
        return session.selectList("classes.getUsersByCourseId",courseNo);
    }

    @Override
    public List<Integer> getClassCount(SqlSession session, int courseNo) {
        return session.selectList("classes.getClassCount",courseNo);
    }
}
