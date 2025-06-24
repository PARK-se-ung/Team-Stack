package org.ts.teamstack.classpage.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.ts.teamstack.classpage.model.service.ClassPageService1;
import org.ts.teamstack.user.model.dto.Users;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@RequestMapping("/class")
public class ClassPageController1 {

    private final ClassPageService1 service;

    @RequestMapping("/dashboard")
    private String dashboard(/*@SessionAttribute("loginUser") User loginUser,*/ Model model) {
//        String userId = loginUser.getUserId();
//        model.addAttribute("ongoing", service.getOngoingCourses(userId));
//        model.addAttribute("complete", service.getCompletedCourses(userId));
//        model.addAttribute("allcourse", service.getAllCourses(userId));
        return "classes/dashboard";
    }

    @RequestMapping("/dashmain")
    private String home(/*@SessionAttribute("loginUser") User loginUser,*/ Model model) {
//        String userId = loginUser.getUserId();
        return "classes/dashmain";
    }

    @RequestMapping("/home")
    public String home() {
        return "classes/home"; // /WEB-INF/views/classes/home.jsp
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
}
