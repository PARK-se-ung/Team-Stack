package org.ts.teamstack.manager.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.manager.model.dto.Notice;

import java.util.List;

public interface ManagerDao {
    List<Notice> searchNotice(SqlSession session, PageInfo pageInfo);
    int searchNoticeCount(SqlSession session);
    int insertNotice(SqlSession session, Notice notice);
}
