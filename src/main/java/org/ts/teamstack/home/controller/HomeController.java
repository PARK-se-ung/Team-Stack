package org.ts.teamstack.home.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.ts.teamstack.home.service.HomeService;

import javax.servlet.http.Cookie;
@RequiredArgsConstructor
public class HomeController {

    private final HomeService service;

    @RequestMapping("/")
    public String index(@CookieValue(name = "teamstackRecentView",required = false)
                            Cookie cookie,
                            Model model){

        /* 초중고 데이터 저장 */
        model.addAttribute("course" , service.homeCourses());
        return "index";
    }

    @RequestMapping("/home/searchcoursebyno")
    public String searchcoursebyno(@RequestParam int courseNo, Model model){

        return "course/course";
    }

}
