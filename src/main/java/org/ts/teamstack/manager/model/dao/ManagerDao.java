package org.ts.teamstack.manager.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.manager.model.dto.Alarm;
import org.ts.teamstack.manager.model.dto.Inquire;
import org.ts.teamstack.manager.model.dto.Notice;
import org.ts.teamstack.user.model.dto.Users;

import java.util.List;

public interface ManagerDao {
    List<Notice> searchNotice(SqlSession session, PageInfo pageInfo);
    int searchNoticeCount(SqlSession session);
    int insertNotice(SqlSession session, Notice notice);
    int insertAlarm(SqlSession session, Alarm alarm);
    List<Users> searchUsersByType(SqlSession session, String type);
    int insertInquire(SqlSession session, Inquire inquire);
    List<Inquire> searchInquire(SqlSession session, PageInfo pageInfo);
}
