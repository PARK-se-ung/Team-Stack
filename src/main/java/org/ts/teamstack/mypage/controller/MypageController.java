package org.ts.teamstack.mypage.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.ts.teamstack.common.controller.PageBarFactory;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.mypage.service.MypageService;
import org.ts.teamstack.payment.model.dto.Payment;
import org.ts.teamstack.payment.model.dto.Refund;
import org.ts.teamstack.payment.model.service.PaymentService;
import org.ts.teamstack.user.model.dto.Users;

import javax.servlet.http.HttpSession;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/mypage")
public class MypageController {

    private final PaymentService paymentService;
    private final PageInfo pageInfo;
    private final MypageService mypageService;

    /* 마이페이지 메인화면 이동*/
    @RequestMapping("")
    public String mypage(Model model, HttpSession session){
        Users loginUser = (Users) session.getAttribute("loginUser");
        model.addAttribute("loginUser", loginUser);
        return "mypage/mypage";
    }

    /* 개인정보화면 이동 */
    @RequestMapping("/info")
    public String myinfo() {
        return "mypage/ajax/user/info";
    }

    /* 북마크 화면 이동 */
    @PostMapping("/bookmark")
    public String mybookmark(Model model, @RequestParam(defaultValue = "1") int cPage , HttpSession session) {

        Users loginUser = (Users) session.getAttribute("loginUser");
        pageInfo.initialize();//set한걸 초기화

        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(mypageService.searchBookmarkCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "bookmarkPaging");
        List<Course> bookmarks = mypageService.selectBookmarkAll(loginUser.getUserId(), pageInfo);

        model.addAttribute("bookmarks", bookmarks);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);
        return "mypage/ajax/user/bookmark";
    }

    /* 예약한 강의 화면 이동 */
    @RequestMapping("/reserve")
    public String myreserve(Model model, @RequestParam(defaultValue = "1") int cPage , HttpSession session) {

        Users loginUser = (Users) session.getAttribute("loginUser");
        pageInfo.initialize();//set한걸 초기화

        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(mypageService.selectReserveCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "reservePaging");

        List<Course> reserve = mypageService.selectReserveAll(loginUser.getUserId(),pageInfo);

        model.addAttribute("reserve" , reserve);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);

        return "mypage/ajax/user/reserve";

    }

    /* 신청한 강의 이동 */
    @RequestMapping("/apply")
    public String myapply(Model model, @RequestParam(defaultValue = "1") int cPage , HttpSession session) {


        Users loginUser = (Users) session.getAttribute("loginUser");
        pageInfo.initialize();//set한걸 초기화

        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(mypageService.selectApplyCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "applyPaging");

        List<Course> apply = mypageService.selectApplyAll(loginUser.getUserId(),pageInfo);

        model.addAttribute("apply" , apply);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);

        return "mypage/ajax/user/apply"; }

    /* 강의 개설 자격 승인 이동 */
    @RequestMapping("/approval")
    public String myapproval(Model model) { return "mypage/ajax/user/approval"; }

    /* 수강중인 강의 */
    @RequestMapping("/take")
    public String mytake(Model model, @RequestParam(defaultValue = "1") int cPage , HttpSession session) {

        Users loginUser = (Users) session.getAttribute("loginUser");
        pageInfo.initialize();//set한걸 초기화

        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(mypageService.selectTakeCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "takePaging");

        List<Course> take = mypageService.selectTakeAll(loginUser.getUserId(),pageInfo);

        model.addAttribute("take" , take);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);


        return "mypage/ajax/user/take"; }

    /* 수강 완료한 강의 */
    @RequestMapping("/complete")
    public String mycomplete(Model model, @RequestParam(defaultValue = "1") int cPage , HttpSession session) {
        Users loginUser = (Users) session.getAttribute("loginUser");
        pageInfo.initialize();//set한걸 초기화

        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(mypageService.selectCompleteCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "completePaging");

        List<Course> complete = mypageService.selectCompleteAll(loginUser.getUserId(),pageInfo);

        model.addAttribute("complete" , complete);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);
        return "mypage/ajax/user/complete"; }

    /* 강의 구매 내역 이동 */
    @PostMapping("/purchase")
    public String mypurchase(Model model, @RequestParam(defaultValue = "1") int cPage ,HttpSession session) {

        Users loginUser = (Users) session.getAttribute("loginUser");
        pageInfo.initialize();//set한걸 초기화
        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(paymentService.searchPurchaseCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "purchasePaging");
        List<Payment> purchase = paymentService.searchAllPurchase(loginUser.getUserId(),pageInfo);

        model.addAttribute("purchase", purchase);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);

        return "mypage/ajax/payment/purchase"; }

    /* 환불 신청 이동 */
    @RequestMapping("/requestRefund")
    public String myrequestrefund(Model model, @RequestParam(defaultValue = "1") int cPage ,HttpSession session) {

//        Users loginUser = (Users) session.getAttribute("loginUser");
//        pageInfo.initialize();//set한걸 초기화
//        pageInfo.setCurPage(cPage);
//        pageInfo.setTotalData(paymentService.searchRequestRefundCount(loginUser.getUserId()));
//        pageInfo.setNumPerpage(10);
//
//        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "requestRefundPaging");
//        List<Refund> requestRefund = paymentService.searchAllrequestRefund(loginUser.getUserId(),pageInfo);
//
//
//        model.addAttribute("requestRefund", requestRefund);
//        model.addAttribute("loginUser", loginUser);
//        model.addAttribute("pageBar", pageBar);
        return "mypage/ajax/payment/requestrefund"; }

    /* 환불 신청 조회 이동 */
    @RequestMapping("/refund")
    public String myrefund(Model model, @RequestParam(defaultValue = "1") int cPage ,HttpSession session) {
        Users loginUser = (Users) session.getAttribute("loginUser");

//        pageInfo.initialize();//set한걸 초기화
//        pageInfo.setCurPage(cPage);
//        pageInfo.setTotalData(paymentService.searchRefundCount(loginUser.getUserId()));
//        pageInfo.setNumPerpage(10);
//
//        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "refundPaging");
//        List<Refund> refunds = paymentService.searchAllRefund(loginUser.getUserId(),pageInfo);
//
//
//        model.addAttribute("refunds", refunds);
//        model.addAttribute("loginUser", loginUser);
//        model.addAttribute("pageBar", pageBar);

        return "mypage/ajax/payment/refund"; }

    /* 강의 판매 내역 이동 */
    @RequestMapping("/sales")
    public String mysales(Model model, @RequestParam(defaultValue = "1") int cPage ,HttpSession session) {

        Users loginUser = (Users) session.getAttribute("loginUser");

        pageInfo.initialize();//set한걸 초기화
        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(paymentService.searchSalesCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "salesPaging");
        List<Payment> sales = paymentService.searchAllSales(loginUser.getUserId(),pageInfo);


        model.addAttribute("sales", sales);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);

        return "mypage/ajax/payment/sales"; }


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
