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
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.user.model.dto.Users;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/class")
public class ClassController {

    @Autowired
    ClassPageService1 service;

    @RequestMapping("/chatting")
    public String chatting(int courseNo , HttpSession session, Model model) {
        // 쿼리스트링 방식으로 필요 값을 보내기 때문에 @RequestParam을 통해 가지고 올 수 있음
        // 위와 같이 이름이 같은 경우에는 그냥 사용이 가능하다.
        // 이렇게 쿼리스트링 방식으로 보내는 것은 Get 식으로 노출됨
        System.out.println(courseNo);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users user1 = (Users) auth.getPrincipal();
        Course course = service.getCourse(courseNo);

        // 세션에 저장된 사용자 정보 (로그인 이후 저장된 경우만 해당)
            Object loginUser = session.getAttribute("loginUser");
            System.out.println("[세션 사용자] loginUser: " + loginUser);

            // 채팅 내역 가져오기
            try {
                List<Chat> chattingHistory = service.getChattingHistory(courseNo);
                System.out.println("[채팅 내역 개수] " + chattingHistory.size());
                model.addAttribute("chattingHistory", chattingHistory);
            } catch (Exception e) {
                e.printStackTrace();
            }

        // JSP에서 사용할 courseNo 전달
        session.setAttribute("courseNo", courseNo);

        return "classes/chatting"; // → /WEB-INF/views/classes/chatting.jsp 로 포워딩됨
    }
}
