package org.ts.teamstack.classpage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.ts.teamstack.classpage.model.dto.Chat;
import org.ts.teamstack.classpage.model.service.ClassPageService1;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/class")
public class ClassController {

    @Autowired
    ClassPageService1 service;

    @RequestMapping("/chatting")
    public String chatting(int courseNo , HttpSession session, Model model) {
//        // 쿼리스트링 방식으로 필요 값을 보내기 때문에 @RequestParam을 통해 가지고 올 수 있음
//        // 위와 같이 이름이 같은 경우에는 그냥 사용이 가능하다.
//        // 이렇게 쿼리스트링 방식으로 보내는 것은 Get 식으로 노출됨
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user1 = (User) auth.getPrincipal();
        System.out.println("user1: " + user1.getUsername());
        User user = (User)session.getAttribute("loginUser");
        System.out.println(user + "이거 값이 존재하나?");
        List<Chat> chattingHistory = service.getChattingHistory(courseNo);
        model.addAttribute("chattingHistory", chattingHistory);
        return "classes/chatting";
    }
}
