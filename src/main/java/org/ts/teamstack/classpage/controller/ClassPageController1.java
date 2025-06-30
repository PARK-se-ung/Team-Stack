package org.ts.teamstack.classpage.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.ts.teamstack.classpage.model.service.ClassPageService1;
import org.ts.teamstack.user.model.dto.Users;


@Controller
@RequiredArgsConstructor
@RequestMapping("/class")
public class ClassPageController1 {

    private final ClassPageService1 service;

    @RequestMapping("/dashboard")
    private String dashboard(@SessionAttribute("loginUser") Users loginUser, Model model) {
        String userId = loginUser.getUserId();
        model.addAttribute("ongoing", service.getOngoingCourses(userId));
        model.addAttribute("complete", service.getCompletedCourses(userId));
        model.addAttribute("allcourse", service.getAllCourses(userId));
        model.addAttribute("type", service.checkUserType(userId));
        model.addAttribute("mycourse", service.getmyCourses(userId));

        return "classes/dashboard";
    }

    @RequestMapping("/dashmain")
    private String dashmain(@RequestParam("courseNo")int courseNo, Model model) {
        model.addAttribute("course", courseNo);
        model.addAttribute("planfile", service.getPlanFile(courseNo));
        model.addAttribute("caldate",service.getCalDate(courseNo));
        model.addAttribute("calassign", service.getCalAssign(courseNo));
        model.addAttribute("calnotice", service.getNotice(courseNo));
        model.addAttribute("courseid", service.getCourseId(courseNo));
        return "classes/dashmain";
    }

    @GetMapping("/home")
    public String home(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("homenotice", service.getHomeNotice(courseNo));
        model.addAttribute("homeassign", service.getHomeAssign(courseNo));
        return "classes/home";
    }

    @GetMapping("/notice")
    public String notice(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("notice", service.getNotice(courseNo));
        return "classes/notice";
    }

    @GetMapping("/plan")
    public String plan(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("planfile", service.getPlanFile(courseNo));
        model.addAttribute("courseid", service.getCourseId(courseNo));
        return "classes/plan";
    }

    @GetMapping("/week")
    public String week(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("week", service.getWeek(courseNo));
        return "classes/week";
    }

    @RequestMapping("/assign")
    public String assign(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("week", service.getWeek(courseNo));
        return "classes/assign";
    }

    @RequestMapping("/file")
    public String file(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("courseNo", courseNo);
        model.addAttribute("scheduleweek", service.getWeekForInsert(courseNo));
        return "classes/file";
    }

//    @RequestMapping("/chatting")
//    public String chatting() {
//        return "classes/chatting";
//    }

    @RequestMapping("/atttend")
    public String attend() {
        return "classes/attend";
    }

    @RequestMapping("/score")
    public String score() {
        return "classes/score";
    }

    @RequestMapping("/calendar")
    public String calendar() {
        return "classes/calendar";
    }

//    @PostMapping("/noticeInsert")
//    public String noticeInsert(@RequestParam("courseNo") int courseNo, Model model) {}
}
