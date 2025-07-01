package org.ts.teamstack.manager.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.aspectj.weaver.ast.Not;
import org.springframework.stereotype.Repository;
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

@Repository
public class ManagerDaoImpl implements ManagerDao{

    @Override
    public List<Approve> searchAppr(SqlSession session, PageInfo pageInfo){
        return session.selectList("manager.searchAppr", null, pageInfo.getRowBounds());
    }

    @Override
    public int searchApprCount(SqlSession session){
        return session.selectOne("manager.searchApprCount");
    }

    @Override
    public List<Course>  searchCourseByAppr(SqlSession session, PageInfo pageInfo){
        return session.selectList("manager.searchCourseByAppr", null, pageInfo.getRowBounds());
    }

    @Override
    public int searchCourseApprCount(SqlSession session){
        return session.selectOne("manager.searchCourseApprCount");
    }

    @Override
    public int insertSchedule(SqlSession session, Schedule  schedule){
        return session.insert("insertSchedule", schedule);
    }

    @Override
    public int updateCourse(SqlSession session, String status, int courseNo) {
        return session.update("manager.updateCourse", Map.of("status", status, "courseNo", courseNo));
    }

    @Override
    public List<Notice> searchNotice(SqlSession session, PageInfo pageInfo){
        return session.selectList("manager.searchNotice", null, pageInfo.getRowBounds());
    }

    @Override
    public int searchNoticeCount(SqlSession session){
        return session.selectOne("manager.searchNoticeCount");
    }

    @Override
    public Notice searchNoticeByNo(SqlSession session, int no) {
        return session.selectOne("manager.searchNoticeByNo", no);
    }

    @Override
    public int insertNotice(SqlSession session, Notice notice) {
        return session.insert("manager.insertNotice", notice);
    }

    @Override
    public int updateNotice(SqlSession session, Notice notice) {
        return session.update("manager.updateNotice", notice);
    }

    @Override
    public int deleteNotice(SqlSession session, int no) {
        return session.delete("manager.deleteNotice", no);
    }

    @Override
    public int insertAlarm(SqlSession session, Alarm alarm) {
        return session.insert("manager.insertAlarm", alarm);
    }

    @Override
    public List<Users> searchUsersByType(SqlSession session, String type) {
        return session.selectList("users.searchUsersByType", type);
    }

    @Override
    public int insertInquire(SqlSession session, Inquire inquire) {
        return session.insert("manager.insertInquire", inquire);
    }

    @Override
    public List<Inquire>  searchInquire(SqlSession session, PageInfo pageInfo, String status) {
        return session.selectList("manager.searchInquire", status, pageInfo.getRowBounds());
    }

    @Override
    public int searchInquireCount(SqlSession session, String status) {
        return session.selectOne("manager.searchInquireCount", status);
    }

    @Override
    public int updateInquire(SqlSession session, int no){
        return session.update("manager.updateInquire", no);
    }

}
