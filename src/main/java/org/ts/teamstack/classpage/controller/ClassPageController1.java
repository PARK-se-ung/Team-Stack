package org.ts.teamstack.classpage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
//@RequiredArgsConstructor
@RequestMapping("/class")
public class ClassPageController1 {

//    private final ClassPageService1 classService;

    @RequestMapping("/dashboard")
    private String dashboard() {
        return "classes/dashboard";
    }

}
