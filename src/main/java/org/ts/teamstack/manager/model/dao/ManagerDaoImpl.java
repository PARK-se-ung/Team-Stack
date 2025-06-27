package org.ts.teamstack.manager.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.manager.model.dto.Alarm;
import org.ts.teamstack.manager.model.dto.Inquire;
import org.ts.teamstack.manager.model.dto.Notice;
import org.ts.teamstack.user.model.dto.Users;

import java.util.List;
import java.util.Map;

@Repository
public class ManagerDaoImpl implements ManagerDao{
    @Override
    public List<Notice> searchNotice(SqlSession session, PageInfo pageInfo){
        return session.selectList("manager.searchNotice", null, pageInfo.getRowBounds());
    }

    @Override
    public int searchNoticeCount(SqlSession session){
        return session.selectOne("manager.searchNoticeCount");
    }

    @Override
    public int insertNotice(SqlSession session, Notice notice) {
        return session.insert("manager.insertNotice", notice);
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
