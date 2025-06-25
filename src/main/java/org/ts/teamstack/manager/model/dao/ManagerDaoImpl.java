package org.ts.teamstack.manager.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.manager.model.dto.Alarm;
import org.ts.teamstack.manager.model.dto.Notice;
import org.ts.teamstack.user.model.dto.Users;

import java.util.List;
import java.util.Map;

@Repository
public class ManagerDaoImpl implements ManagerDao{
    @Override
    public List<Notice> searchNotice(SqlSession session, PageInfo pageInfo){
        RowBounds rb = new RowBounds((pageInfo.getCurPage() - 1) * pageInfo.getNumPerpage(),
                                    pageInfo.getNumPerpage());
        return session.selectList("manager.searchNotice", null, rb);
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
}
