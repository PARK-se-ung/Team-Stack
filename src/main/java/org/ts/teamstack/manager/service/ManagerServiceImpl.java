package org.ts.teamstack.manager.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.manager.model.dao.ManagerDao;
import org.ts.teamstack.manager.model.dto.Notice;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ManagerServiceImpl implements ManagerService{

    private final ManagerDao dao;
    private final SqlSession session;

    @Override
    public List<Notice> searchNotice(PageInfo pageInfo){
        return dao.searchNotice(session, pageInfo);
    }

    @Override
    public int searchNoticeCount(){
        return dao.searchNoticeCount(session);
    }

    @Override
    @Transactional
    public int  insertNotice(Notice notice, String alarm) {
        int result = dao.insertNotice(session, notice);
        if(alarm.equals("none")){
            return result;
        }

        return result;
    }

}
