package org.ts.teamstack.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manage")
public class ManagerController {

    @RequestMapping("")
    public String manage(){
        return "manage/manage";
    }
}
