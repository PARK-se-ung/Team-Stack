package org.ts.teamstack.manager.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.manager.model.dto.Notice;

import java.util.List;

@Repository
public class ManagerDaoImpl implements ManagerDao{
    @Override
    public List<Notice> searchNotice(SqlSession session, PageInfo pageInfo){
        System.out.println((pageInfo.getCurPage() - 1) * pageInfo.getNumPerpage() + 1);
        System.out.println(pageInfo.getNumPerpage());
        RowBounds rb = new RowBounds((pageInfo.getCurPage() - 1) * pageInfo.getNumPerpage() + 1,
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
}
