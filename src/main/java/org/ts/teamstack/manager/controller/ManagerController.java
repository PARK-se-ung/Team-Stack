package org.ts.teamstack.manager.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.ts.teamstack.common.controller.PageBarFactory;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.manager.model.dto.Alarm;
import org.ts.teamstack.manager.model.dto.Inquire;
import org.ts.teamstack.manager.model.dto.Notice;
import org.ts.teamstack.manager.service.ManagerService;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/manage")
@RequiredArgsConstructor
public class ManagerController {

    private final ManagerService service;
    private final PageInfo pageInfo;

    @RequestMapping("")
    public String manage(){
        return "manage/manage";
    }

    /* 공지 */
    @RequestMapping("/notice")
    public String searchNotice(Model model,
                               @RequestParam(defaultValue = "1") int cPage){
        pageInfo.initialize();
        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(service.searchNoticeCount());
        List<Notice> notices = service.searchNotice(pageInfo);
        System.out.println(notices);
        System.out.println(pageInfo);
        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "loadNotice");
        model.addAttribute("notices", notices);
        model.addAttribute("pageBar", pageBar);
        return "manage/ajax/notice";
    }

    @RequestMapping("/writenotice")
    public String writeNotice(){
        return "manage/ajax/writenotice";
    }

    @RequestMapping("/insertnotice")
    public String insertNotice(@RequestParam String title,
                               @RequestParam String content,
                               @RequestParam String alarm,
                               Model model){
        Notice notice = Notice.builder()
                            .noticeTitle(title)
                            .noticeContent(content)
                            .build();
        model.addAttribute("result", service.insertNotice(notice, alarm));

        return "manage/ajax/notice";
    }

    @RequestMapping("/updatenotice")
    @ResponseBody
    public int updateNotice(@RequestParam String title,
                               @RequestParam String content,
                               @RequestParam String alarm,
                               Model model){
        Notice notice = Notice.builder()
                .noticeTitle(title)
                .noticeContent(content)
                .build();
        return service.insertNotice(notice, alarm);
    }


    /* 알람 */
    @RequestMapping("/alarm")
    public String alarm(){
        return "manage/ajax/alarm";
    }

    @RequestMapping("/insertalarm")
    @ResponseBody
    public int insertAlarm(@RequestParam String type,
                              @RequestParam String time,
                              @RequestParam String content, Model model){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date parsedDate = new Date();
        try{
            parsedDate = sdf.parse(time);
        } catch(ParseException e) {
            e.printStackTrace();
        }
        Timestamp timestamp = new Timestamp(parsedDate.getTime());
        Alarm alarm = Alarm.builder()
                            .alarmDate(timestamp)
                            .alarmContent(content)
                            .build();
        int result = 0;
        try{
            result = service.insertAlarm(alarm, type);
        } catch (RuntimeException e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/inquirepage")
    public String insertInquire(){
        return "manage/insertinquire";
    }

    @RequestMapping("/insertinquire")
    @ResponseBody
    public int insertInquire(@RequestParam String userId,
                                @RequestParam String title,
                                @RequestParam String content){
        Inquire inquire = Inquire.builder()
                                .userId(userId)
                                .inquireTitle(title)
                                .inquireContent(content)
                                .build();
        return service.insertInquire(inquire);
    }

    @RequestMapping("/inquire")
    public String inquire(Model model, @RequestParam(defaultValue = "1") int cPage) {
        pageInfo.initialize();
        pageInfo.setCurPage(cPage);
        List<Inquire> inquires = service.searchInquire(pageInfo);
        model.addAttribute("pageBar",
                PageBarFactory.ajaxPageBuilder(pageInfo, "loadInquire"));
        model.addAttribute("inquires", inquires);
        return  "manage/ajax/inquire";
    }
}
