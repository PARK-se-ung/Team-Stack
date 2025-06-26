package org.ts.teamstack;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
    @RequestMapping("/")
    public String index(@CookieValue(,required = false) Model model){

        return "index";
    }

    @GetMapping("/test")
    public String test(){
        return "test";
    }
}
