package org.ts.teamstack.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class MypageController {
    /* 마이페이지 메인화면 이동*/
    @RequestMapping("")
    public String mypage(){
        return "mypage/mypage";
    }

    /* 개인정보화면 이동 */
    @RequestMapping("/info")
    public String myinfo() {
        return "mypage/ajax/info";
    }

    /* 북마크 화면 이동 */
    @RequestMapping("/bookmark")
    public String mybookmark(Model model) {
        return "mypage/ajax/bookmark";
    }

    /* 예약한 강의 화면 이동 */
    @RequestMapping("/reserve")
    public String myreserve(Model model) {
        return "mypage/ajax/reserve";
    }

    @RequestMapping("/manage")
    public String myopen(Model model) {
        return "mypage/ajax/open";
    }

    @RequestMapping("/courseapply")
    public String myapply(Model model) {
        return "mypage/ajax/courseapply";
    }

    @RequestMapping("/studentapply")
    public String mystudent(Model model) { return "mypage/ajax/studentapply"; }

    @RequestMapping("/coursetake")
    public String mycoursetake(Model model) { return "mypage/ajax/coursetake"; }

    @RequestMapping("/coursecomplete")
    public String mycoursecomplete(Model model) { return "mypage/ajax/coursecomplete"; }
}
