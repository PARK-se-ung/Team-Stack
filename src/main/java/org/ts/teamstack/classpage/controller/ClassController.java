package org.ts.teamstack.classpage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.ts.teamstack.classpage.model.service.ClassPageService1;

@Controller
@RequestMapping("/class")
public class ClassController {

    ClassPageService1 service;


    @RequestMapping("/chatting")
    public String chatting(int courseNo) {
        service.getChattingHistory(courseNo);
            return "chatting";
    }
}
