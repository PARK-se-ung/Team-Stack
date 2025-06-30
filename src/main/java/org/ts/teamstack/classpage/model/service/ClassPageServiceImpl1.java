package org.ts.teamstack.classpage.model.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.ts.teamstack.classpage.model.dao.ClassPageDao1;
import org.ts.teamstack.classpage.model.dto.Board;
import org.ts.teamstack.classpage.model.dto.Schedule;
import org.ts.teamstack.classpage.model.dto.Assign;
import org.ts.teamstack.classpage.model.dto.Chat;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ClassPageServiceImpl1 implements ClassPageService1 {

    private final SqlSession session;
    private final ClassPageDao1 classDao;

    @Override
    public List<Course> getAllCourses(String userId) {
        return classDao.getAllCourses(session, userId);
    }

    @Override
    public List<Course> getOngoingCourses(String userId) {
        return classDao.getOngoingCourses(session, userId);
    }

    @Override
    public List<Course> getCompletedCourses(String userId) {
        return classDao.getCompletedCourses(session, userId);
    }

    @Override
    public String checkUserType(String userId) {
        return classDao.checkUserType(session,userId);
    }

    @Override
    public List<Course> getmyCourses(String userId) {
        return classDao.getmyCourses(session,userId);
    }

    @Override
    public Course getPlanFile(int courseNo) { return classDao.getPlanFile(session, courseNo);}

    @Override
    public List<Schedule> getCalDate(int courseNo){return classDao.getCalDate(session,courseNo);}

    @Override
    public List<Schedule> getCalAssign(int courseNo) {return classDao.getCalAssign(session,courseNo);}

    @Override
    public List<Board> getHomeNotice(int courseNo) {
        return classDao.getHomeNotice(session, courseNo);
    }

    @Override
    public List<Assign> getHomeAssign(int courseNo) {
        return classDao.getHomeAssign(session, courseNo);
    }

    @Override
    public List<Board> getNotice(int courseNo) {
        return classDao.getNotice(session, courseNo);
    }

    @Override
    public List<Schedule> getWeek(int courseNo) {return classDao.getWeek(session, courseNo);}

    @Override
    public String getCourseId(int courseNo) {return classDao.getCourseId(session,courseNo);}

    @Override
    public int getWeekForInsert(int courseNo) {return classDao.getWeekForInsert(session,courseNo);}

    @Override
    public List<Chat> getChattingHistory(int courseNo) { return classDao.getChattingHistory(session,courseNo);}

    @Override
    public int setChattingHistory(Chat chat) { return classDao.setChattingHistory(session,chat);}

    @Override
    public Course getCourse(int courseNo) {
        return classDao.getCourse(session, courseNo);
    }
}
