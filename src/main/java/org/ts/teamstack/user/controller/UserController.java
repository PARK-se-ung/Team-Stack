package org.ts.teamstack.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {

    @RequestMapping("/login.do")
    public String login(){
        return "user/loginpage";
    }

}
