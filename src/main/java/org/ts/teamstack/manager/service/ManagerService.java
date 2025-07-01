package org.ts.teamstack.manager.service;

import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.manager.model.dto.Alarm;
import org.ts.teamstack.manager.model.dto.Inquire;
import org.ts.teamstack.manager.model.dto.Notice;
import org.ts.teamstack.manager.model.dto.Approve;

import java.util.List;

public interface ManagerService {
    List<Notice> searchNotice(PageInfo pageInfo);
    int searchNoticeCount();
    int insertNotice(Notice notice, String alarm);
    int updateNotice(Notice notice, String alarm);
    int deleteNotice(int noticeNo);
    Notice searchNoticeByNo(int no);
    int insertAlarm(Alarm alarm, String type);
    int insertInquire(Inquire inquire);
    List<Inquire> searchInquire(PageInfo pageInfo, String status);
    int searchInquireCount(String status);
    int updateInquire(Alarm alarm, String type, int no);
    List<Approve> searchAppr(PageInfo pageInfo);
    int searchApprCount();
    List<Course> searchCourseByAppr(PageInfo pageInfo);
    int searchCourseApprCount();
    int updateCourse(String status, int courseNo);


}
