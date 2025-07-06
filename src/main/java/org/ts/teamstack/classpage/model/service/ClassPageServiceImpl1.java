package org.ts.teamstack.classpage.model.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.ts.teamstack.classpage.model.dao.ClassPageDao1;
import org.ts.teamstack.classpage.model.dto.*;
import org.ts.teamstack.course.model.dto.Course;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ClassPageServiceImpl1 implements ClassPageService1 {

    private final SqlSession session;
    private final ClassPageDao1 classDao;

    @Override
    public List<Board> getClassesNotice(String userId) { return  classDao.getClassesNotice(session, userId);}

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
    public List<Schedule> getStuAssigns(int courseNo) {return classDao.getStuAssigns(session, courseNo);}

    @Override
    public Completion checkCompletion(Course course) {return classDao.checkCompletion(session, course);}

    @Override
    public String getCourseId(int courseNo) {return classDao.getCourseId(session,courseNo);}

    @Override
    public int getWeekForInsert(int courseNo) {return classDao.getWeekForInsert(session,courseNo);}

    @Override
    public List<Schedule> getWeekForInsert2(int courseNo) {return classDao.getWeekForInsert2(session,courseNo);}

    @Override
    public List<Chat> getChattingHistory(int courseNo) { return classDao.getChattingHistory(session,courseNo);}

    @Override
    public int setChattingHistory(Chat chat) { return classDao.setChattingHistory(session,chat);}

    @Override
    public Course getCourse(int courseNo) {
        return classDao.getCourse(session, courseNo);
    }

    @Override
    public int insertNotice(Board notice) {
        return classDao.insertNotice(session, notice);
    }

    @Override
    public int assignCheck(Schedule schedule) {
        return classDao.assignCheck(session, schedule);
    }

    @Override
    public int aFileUpdate(Assign assign) {
        return classDao.aFileUpdate(session, assign);
    }

    @Override
    public int aFileInsert(Assign assign) {
        return classDao.aFileInsert(session, assign);
    }

    @Override
    public int scheduleUpdate(Schedule schedule) {
        return classDao.scheduleUpdate(session, schedule);
    }

    @Override
    public List<String> getUsersByCourseId(int courseNo) { return classDao.getUsersByCourseId(session,courseNo);
    }

    @Override
    public List<Integer> getClassCount(int courseNo) {
        return classDao.getClassCount(session,courseNo);
    }

    @Override
    public Date getStartDate(int courseNo) { return classDao.getStartDate(session,courseNo); }

    @Override
    public int getAssignNo(Assign assign) { return classDao.getAssignNo(session,assign); }

    @Override
    public int stuAssignCheck(StudentAssign studentAssign) { return  classDao.stuAssignCheck(session,studentAssign);}

    @Override
    public int stuFileUpdate(StudentAssign studentAssign) { return classDao.stuAssignUpdate(session,studentAssign); }

    @Override
    public int stuFileInsert(StudentAssign studentAssign) { return classDao.stuAssignInsert(session, studentAssign);}

    @Override
    public int insertAttend(Attend attend) {
        return classDao.insertAttend(session,attend);
    }


    @Override
    public List<Attend> getAttend(String userId, int attendNo) {
        return classDao.getAttend(session,userId,attendNo);
    }

    @Override
    public int isUserEnrolled(Course course) {
        return classDao.isUserEnrolled(session,course);
    }



    @Override
    public Map<Integer, Integer> getAttendCountByRound(int courseNo) {
        List<Attend> attendList = classDao.getAttendListByCourse(session, courseNo);
        Map<Integer, Integer> attendCount = new HashMap<>();

        for (Attend a : attendList) {
            int round = a.getCourseRound();
            attendCount.put(round, attendCount.getOrDefault(round, 0) + 1);
        }
        return attendCount;
    }


    @Override
    public List<String> getUserNameByCourseId(int courseNo) {
        return classDao.getUserNameByCourseId(session,courseNo);
    }

    @Override
    public List<Score> getAllScores(int courseNo) {
        return classDao.getAllScores(session,courseNo);
    }

    @Override
    public Score scoreExist(Score score) {
        return classDao.scoreExist(session, score);
    }

    @Override
    public int updateScore(Score score) {
        return classDao.updateScore(session,score);
    }

    @Override
    public int insertScore(Score score) {
        return classDao.insertScore(session,score);
    }

    @Override
    public List<Score> searchUserScore(String userId, int courseNo) {
        return classDao.searchUserScore(session, userId, courseNo);
    }

    @Override
    public boolean isAttendExists(Attend attend) {
        return classDao.isAttendExist(session,attend) > 0;
    }

    @Override
    public int updateAttend(Attend attend) {
        return classDao.updateAttend(session, attend);
    }
}

