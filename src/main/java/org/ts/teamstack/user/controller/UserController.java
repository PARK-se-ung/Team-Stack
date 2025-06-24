package org.ts.teamstack.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;

@Controller
@RequestMapping("/user")
public class UserController {

    @RequestMapping("/login.do")
    public String login(){
        return "user/loginpage";
    }

    // 만들면
//    @PostMapping(value = "/loginend.do")
//    public String loginend(){
//
//    }
    @PostMapping("/loginsuccess")
    public String loginSuccess(HttpServletRequest request, Principal principal) {
        System.out.println("로그인 성공: " + principal.getName());
        return "redirect:/"; //
    }
    @PostMapping("/loginfailure")
    public String loginFail(HttpServletRequest request, Model model) {
        Exception ex = (Exception) request.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
        model.addAttribute("error", ex != null ? ex.getMessage() : "알 수 없는 오류");
        return "user/loginpage"; // 로그인 화면으로 다시 보냄
    }

    @RequestMapping("/enrolluser.do")
    public String enrolluser(){
        return "user/enrolluserpage";
    }

    @RequestMapping("/enrolluserend.do")
    public String enrolluserend(){
        return "redirect:/";
    }

}
