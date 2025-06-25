package org.ts.teamstack.manager.service;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.manager.model.dao.ManagerDao;
import org.ts.teamstack.manager.model.dto.Alarm;
import org.ts.teamstack.manager.model.dto.Notice;
import org.ts.teamstack.user.model.dto.Users;

import java.sql.Timestamp;
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
    public int  insertNotice(Notice notice, String type) {
        int result = dao.insertNotice(session, notice);
        if(type.equals("none")){
            return result;
        } else {
            Alarm noticeAlarm = Alarm.builder()
                    .alarmDate(new Timestamp(System.currentTimeMillis()))
                    .alarmContent("새로운 공지 사항이 등록 되었습니다!\n" + notice.getNoticeTitle()).build();
            List<Users> users = dao.searchUsersByType(session, type);
            for(Users user : users){
                noticeAlarm.setUserId(user.getUserId());
                result = dao.insertAlarm(session, noticeAlarm);
                if(result == 0){
                    throw new RuntimeException("");
                }
            }
        }

        return result;
    }

    @Override
    @Transactional
    public int insertAlarm(Alarm alarm, String type) {
        List<Users> users = dao.searchUsersByType(session, type);
        if(users.isEmpty()){
            return -1;
        }
        int result = 0;
        for(Users user: users){
            alarm.setUserId(user.getUserId());
            result = dao.insertAlarm(session, alarm);
            if(result == 0){
                throw new RuntimeException("");
            }
        }
        return result;
    }
}
