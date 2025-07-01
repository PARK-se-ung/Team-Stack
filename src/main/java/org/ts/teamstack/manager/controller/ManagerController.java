package org.ts.teamstack.manager.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.ts.teamstack.common.controller.PageBarFactory;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.common.service.FileDownloadService;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.manager.model.dto.Alarm;
import org.ts.teamstack.manager.model.dto.Inquire;
import org.ts.teamstack.manager.model.dto.Notice;
import org.ts.teamstack.manager.service.ManagerService;
import org.ts.teamstack.manager.model.dto.Approve;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/manage")
@RequiredArgsConstructor
public class ManagerController {

    private final ManagerService service;
    private final FileDownloadService fileDownloadService;
    private final PageInfo pageInfo;

    @RequestMapping("")
    public String manage(){
        return "manage/manage";
    }

    /* 승인 */
    @RequestMapping("/authorAppr")
    public String authorappr(Model model,
                             @RequestParam(defaultValue = "1") int cPage){
        pageInfo.initialize();
        pageInfo.setCurPage(cPage);

        List<Approve> approves = service.searchAppr(pageInfo);
        model.addAttribute("approves", approves);
        pageInfo.setTotalData(service.searchApprCount());
        model.addAttribute("pageBar",
                PageBarFactory.ajaxPageBuilder(pageInfo, "loadAuthorAppr"));

        return "manage/ajax/authorappr";
    }

    @RequestMapping("/courseAppr")
    public String courseappr(Model model,
                             @RequestParam(defaultValue = "1")  int cPage){
        pageInfo.initialize();
        pageInfo.setCurPage(cPage);
        pageInfo.setNumPerpage(5);
        List<Course> courses = service.searchCourseByAppr(pageInfo);
        model.addAttribute("courses", courses);
        pageInfo.setTotalData(service.searchCourseApprCount());
        model.addAttribute("pageBar",
                PageBarFactory.ajaxPageBuilder(pageInfo, "loadCourseAppr"));
        return "manage/ajax/courseappr";
    }

    @PostMapping("/updateCourse")
    @ResponseBody
    public int updateCourse(Model model,
                               @RequestParam(value = "status") String status,
                               @RequestParam(value = "courseNo") int courseNo) {
        return service.updateCourse(status, courseNo);
    }

    /* 강의 계획서 다운로드 */
    @GetMapping("/download")
    public void download(Model model,
                         @RequestParam(value = "oriname") String origin,
                         @RequestParam(value = "rename") String rename,
                         HttpServletRequest request,
                         HttpServletResponse response) throws Exception {
        String path = request.getSession().getServletContext().getRealPath("/resources/uploads");
        fileDownloadService.downloadPdfFile(origin, rename, path, request, response);
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
    @ResponseBody
    public int insertNotice(@RequestParam String title,
                               @RequestParam String content,
                               @RequestParam String alarm,
                               Model model){
        Notice notice = Notice.builder()
                            .noticeTitle(title)
                            .noticeContent(content)
                            .build();
        return service.insertNotice(notice, alarm);
    }

    @RequestMapping("/convertNotice")
    public String convertNotice(@RequestParam(value = "noticeNo") int noticeNo, Model model){
        model.addAttribute("notice", service.searchNoticeByNo(noticeNo));
        return "manage/ajax/writenotice";
    }

    @RequestMapping("/updatenotice")
    @ResponseBody
    public int updateNotice(@RequestParam int noticeNo,
                           @RequestParam String title,
                           @RequestParam String content,
                           @RequestParam String alarm,
                           Model model){
        Notice notice = Notice.builder()
                .noticeNo(noticeNo)
                .noticeTitle(title)
                .noticeContent(content)
                .build();
        return service.updateNotice(notice, alarm);
    }

    @RequestMapping("/deleteNotice")
    @ResponseBody
    public int deleteNotice(@RequestParam int noticeNo, Model model){
        return service.deleteNotice(noticeNo);
    }

    /* 알람 */
    @RequestMapping("/alarm")
    public String alarm(){
        return "manage/ajax/alarm";
    }

    @RequestMapping("/insertalarm")
    @ResponseBody
    public int insertAlarm(@RequestParam Map<String, String> params, Model model){
        String type = params.get("type"),
                time = params.get("time") ,
                content = params.get("content"),
                tabId = params.get("tabId");
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
            switch (tabId) {
                case "inquire" : result = service.updateInquire(alarm, type, Integer.parseInt(params.get("no"))); break;
                case "alarm" : result = service.insertAlarm(alarm, type); break;
            }
        } catch (RuntimeException e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/inquirepage")
    public String insertInquire(HttpSession session, Model model){
        if(session.getAttribute("loginUser") == null) {
            model.addAttribute("msg", "로그인 후에 이용가능합니다.");
            model.addAttribute("loc", "/user/login.do");
            return "common/msg";
        };
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
    public String inquire(Model model, @RequestParam(defaultValue = "1") int cPage, String status) {
        pageInfo.initialize();
        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(service.searchInquireCount(status));
        List<Inquire> inquires = service.searchInquire(pageInfo, status);
        model.addAttribute("pageBar",
                PageBarFactory.ajaxPageBuilder(pageInfo, "loadInquire"));
        model.addAttribute("inquires", inquires);
        model.addAttribute("status", status);
        return  "manage/ajax/inquire";
    }

}
