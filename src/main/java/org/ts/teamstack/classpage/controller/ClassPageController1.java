package org.ts.teamstack.classpage.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.ts.teamstack.classpage.model.service.ClassPageService1;


@Controller
@RequiredArgsConstructor
@RequestMapping("/class")
public class ClassPageController1 {

    private final ClassPageService1 service;

    @RequestMapping("/dashboard")
    private String dashboard(/*@SessionAttribute("loginUser") User loginUser,*/ Model model) {
        String userId = "user_0005";
        model.addAttribute("ongoing", service.getOngoingCourses(userId));
        model.addAttribute("complete", service.getCompletedCourses(userId));
        model.addAttribute("allcourse", service.getAllCourses(userId));
        return "classes/dashboard";
    }

    @RequestMapping("/dashmain")
    private String dashmain(@RequestParam("courseNo")int courseNo, Model model) {
        model.addAttribute("course", courseNo);
        return "classes/dashmain";
    }

    @GetMapping("/home")
    public String home(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("homenotice", service.getHomeNotice(courseNo));
        model.addAttribute("homeassign", service.getHomeAssign(courseNo));
        return "classes/home";
    }


    @RequestMapping("/notice")
    public String notice() {
        return "classes/notice";
    }

    @RequestMapping("/plan")
    public String plan() {
        return "classes/plan";
    }

    @RequestMapping("/week")
    public String week() {
        return "classes/week";
    }

    @RequestMapping("/assign")
    public String assign() {
        return "classes/assign";
    }

    @RequestMapping("/file")
    public String file() {
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
}
