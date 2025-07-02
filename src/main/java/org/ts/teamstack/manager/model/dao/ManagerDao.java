package org.ts.teamstack.manager.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.classpage.model.dto.Schedule;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.manager.model.dto.Alarm;
import org.ts.teamstack.manager.model.dto.Inquire;
import org.ts.teamstack.manager.model.dto.Notice;
import org.ts.teamstack.manager.model.dto.Approve;
import org.ts.teamstack.user.model.dto.Users;

import java.util.List;
import java.util.Map;

public interface ManagerDao {
    List<Notice> searchNotice(SqlSession session, PageInfo pageInfo);
    int searchNoticeCount(SqlSession session);
    int insertNotice(SqlSession session, Notice notice);
    int updateNotice(SqlSession session, Notice notice);
    int deleteNotice(SqlSession session, int noticeNo);
    Notice searchNoticeByNo(SqlSession session, int no);
    int insertAlarm(SqlSession session, Alarm alarm);
    List<Users> searchUsersByType(SqlSession session, String type);
    int insertInquire(SqlSession session, Inquire inquire);
    List<Inquire> searchInquire(SqlSession session, PageInfo pageInfo, String status);
    int searchInquireCount(SqlSession session, String status);
    int updateInquire(SqlSession session, int no);
    Inquire searchInquireByNo(SqlSession session, int no);
    List<Approve> searchAppr(SqlSession session, PageInfo pageInfo);
    int searchApprCount(SqlSession session);
    int updateApprove(SqlSession session, Map<String, Object> map);
    int updateUser(SqlSession session, String userId);
    List<Course> searchCourseByAppr(SqlSession session, PageInfo pageInfo);
    int searchCourseApprCount(SqlSession session);
    int updateCourse(SqlSession session, String status, int courseNo);
    int insertSchedule(SqlSession session, Schedule schedule);
}
