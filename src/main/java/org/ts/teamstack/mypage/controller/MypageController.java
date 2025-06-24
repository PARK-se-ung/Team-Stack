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
        return "mypage/ajax/user/info";
    }

    /* 북마크 화면 이동 */
    @RequestMapping("/bookmark")
    public String mybookmark(Model model) {
        return "mypage/ajax/user/bookmark";
    }

    /* 예약한 강의 화면 이동 */
    @RequestMapping("/reserve")
    public String myreserve(Model model) {
        return "mypage/ajax/user/reserve";
    }

    /* 신청한 강의 이동 */
    @RequestMapping("/apply")
    public String myapply(Model model) { return "mypage/ajax/user/apply"; }

    /* 강의 개설 자격 승인 이동 */
    @RequestMapping("/approval")
    public String myapproval(Model model) { return "mypage/ajax/user/approval"; }

    /* 수강중인 강의 */
    @RequestMapping("/take")
    public String mytake(Model model) { return "mypage/ajax/user/take"; }

    /* 수강 완료한 강의 */
    @RequestMapping("/complete")
    public String mycomplete(Model model) { return "mypage/ajax/user/complete"; }

    /* 강의 구매 내역 이동 */
    @RequestMapping("/purchase")
    public String mypurchase(Model model) { return "mypage/ajax/payment/purchase"; }

    /* 환불 신청 조회 이동 */
    @RequestMapping("/refund")
    public String myrefund(Model model) { return "mypage/ajax/payment/refund"; }

    /* 강의 판매 내역 이동 */
    @RequestMapping("/sales")
    public String mysales(Model model) { return "mypage/ajax/payment/sales"; }


    @RequestMapping("/open")
    public String myopen(Model model) {
        return "mypage/ajax/course/open";
    }

    @RequestMapping("/courseapply")
    public String mycourseapply(Model model) {
        return "mypage/ajax/course/courseapply";
    }

    @RequestMapping("/studentapply")
    public String mystudentapply(Model model) { return "mypage/ajax/course/studentapply"; }

    @RequestMapping("/coursetake")
    public String mycoursetake(Model model) { return "mypage/ajax/course/coursetake"; }

    @RequestMapping("/coursecomplete")
    public String mycoursecomplete(Model model) { return "mypage/ajax/course/coursecomplete"; }

}
