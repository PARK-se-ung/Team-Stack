package org.ts.teamstack.mypage.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.ts.teamstack.common.controller.FileUpload;
import org.ts.teamstack.common.controller.PageBarFactory;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseApplyDto;
import org.ts.teamstack.course.service.CourseService;
import org.ts.teamstack.manager.model.dto.Approve;
import org.ts.teamstack.mypage.service.MypageService;
import org.ts.teamstack.payment.model.dto.Payment;
import org.ts.teamstack.payment.model.dto.Refund;
import org.ts.teamstack.payment.model.service.PaymentService;
import org.ts.teamstack.user.model.dto.Users;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/mypage")
@Slf4j
public class MypageController {

    private final PaymentService paymentService;
    private final PageInfo pageInfo;
    private final MypageService mypageService;
    private final CourseService courseService;

    /* 마이페이지 메인화면 이동*/
    @RequestMapping("")
    public String mypage(Model model, HttpSession session){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();
        model.addAttribute("loginUser", loginUser);
        return "mypage/mypage";
    }

    /* 개인정보화면 이동 */
    @RequestMapping("/info")
    public String myinfo(HttpSession session,Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();
        model.addAttribute("loginUser", loginUser);
        return "mypage/ajax/user/info";
    }

    /* 북마크 화면 이동 */
    @RequestMapping("/bookmark")
    public String mybookmark(Model model, @RequestParam(defaultValue = "1") int cPage , HttpSession session) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();
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

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();
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

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();
        pageInfo.initialize();//set한걸 초기화

        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(mypageService.selectApplyCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "applyPaging");

        List<Course> apply = mypageService.selectApplyAll(loginUser.getUserId(),pageInfo);

        model.addAttribute("apply" , apply);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);

        return "mypage/ajax/user/apply";
    }

    /* 강의 개설 자격 승인 이동 */
    @RequestMapping("/approval")
    public String myapproval(Model model,HttpSession session) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();
        String approveStatus = mypageService.selectApprove(loginUser.getUserId());

        model.addAttribute("approveStatus", approveStatus);

        model.addAttribute("loginUser", loginUser);

        return "mypage/ajax/user/approval"; }

    /* 강사 자격 승인 신청 */
    @RequestMapping("/requestapprove")
    @ResponseBody
    public String myrequestapprove(Model model, HttpSession session, @RequestParam("approveFile")MultipartFile multipartFile) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();

        String path = session.getServletContext().getRealPath("/resources/upload/course");

        File dir = new File(path);

        if(!dir.exists()){
            boolean flag = dir.mkdirs();
            if(!flag) log.error("create fail");
        }

        if(!multipartFile.isEmpty()){
            String fileOriName = multipartFile.getOriginalFilename();
            System.out.println(fileOriName);

            String rename = FileUpload.renameFile(multipartFile);
            System.out.println(rename);
            Approve approve = Approve.builder().userId(loginUser.getUserId()).approveOrigin(fileOriName).approveRename(rename).build();

            try {
                int result = mypageService.insertApprove(approve, multipartFile, path);
                if(result > 0){
                    return "success";
                }
            }catch (RuntimeException e){
                e.printStackTrace();
            }
            //0이면 insert실패
            //throw면 파일저장실패
            //result가 1일때 반환
            return "fail";
        }
            return "fail";
      }

    /* 수강중인 강의 */
    @RequestMapping("/take")
    public String mytake(Model model, @RequestParam(defaultValue = "1") int cPage , HttpSession session) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();
        pageInfo.initialize();//set한걸 초기화

        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(mypageService.selectTakeCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "takePaging");

        List<Course> take = mypageService.selectTakeAll(loginUser.getUserId(),pageInfo);

        model.addAttribute("take" , take);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);

        return "mypage/ajax/user/take";
    }

    /* 수강 완료한 강의 */
    @RequestMapping("/complete")
    public String mycomplete(Model model, @RequestParam(defaultValue = "1") int cPage , HttpSession session) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();
        pageInfo.initialize();//set한걸 초기화

        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(mypageService.selectCompleteCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "completePaging");

        List<Course> complete = mypageService.selectCompleteAll(loginUser.getUserId(),pageInfo);

        model.addAttribute("complete" , complete);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);
        return "mypage/ajax/user/complete";
    }

    /* 강의 구매 내역 이동 */
    @RequestMapping("/purchase")
    public String mypurchase(Model model, @RequestParam(defaultValue = "1") int cPage ,HttpSession session) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();
        pageInfo.initialize();//set한걸 초기화
        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(paymentService.searchPurchaseCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "purchasePaging");
        List<Payment> purchase = paymentService.searchAllPurchase(loginUser.getUserId(),pageInfo);

        model.addAttribute("purchase", purchase);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);

        return "mypage/ajax/payment/purchase";
    }

    /* 환불 신청 이동 */
    @RequestMapping("/requestrefund")
    public String myrequestrefund(Model model, @RequestParam(defaultValue = "1") int cPage ,HttpSession session) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();
        pageInfo.initialize();//set한걸 초기화
        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(paymentService.searchPurchaseCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "requestrefundPaging");
        List<Payment> purchase = paymentService.searchAllPurchase(loginUser.getUserId(),pageInfo);

        model.addAttribute("purchase", purchase);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);
        return "mypage/ajax/payment/requestrefund";
    }

    /* 환불 신청 조회 이동 */
    @RequestMapping("/refund")
    public String myrefund(Model model, @RequestParam(defaultValue = "1") int cPage ,HttpSession session) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();

        pageInfo.initialize();//set한걸 초기화
        pageInfo.setCurPage(cPage);
        pageInfo.setTotalData(paymentService.searchRefundCount(loginUser.getUserId()));
        pageInfo.setNumPerpage(10);

        StringBuffer pageBar = PageBarFactory.ajaxPageBuilder(pageInfo, "refundPaging");
        List<Refund> refund = paymentService.searchAllRefund(loginUser.getUserId(),pageInfo);

        model.addAttribute("refund", refund);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("pageBar", pageBar);

        return "mypage/ajax/payment/refund";
    }

    /* 강의 판매 내역 이동 */
    @RequestMapping("/sales")
    public String mysales(Model model, @RequestParam(defaultValue = "1") int cPage ,HttpSession session) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();

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
    public String mycourseapply(Model model ,HttpSession session) {
        Users loginUser = (Users) session.getAttribute("loginUser");


        List<Course> pending = mypageService.getCoursesByStatus("STAY", loginUser.getUserId());
        List<Course> approved = mypageService.getCoursesByStatus("APPROVE", loginUser.getUserId());

        model.addAttribute("pendingList", pending);
        model.addAttribute("approvedList", approved);
        return "mypage/ajax/course/courseapply";
    }

    @RequestMapping("/studentapply")
    public String applyStudents(HttpSession session, Model m){
        //userId를 기준으로 등록된 강좌에 신청한 학생들 가져오기
        Users loginUser = (Users)session.getAttribute("loginUser");

        List<CourseApplyDto> searchApply=courseService.searchCourseApplyStudents(loginUser.getUserId());
        m.addAttribute("searchApply",searchApply);

        return "mypage/ajax/course/studentapply";
    }

    @RequestMapping("/coursetake")
    public String mycoursetake(Model model,HttpSession session) {

        Users loginUser = (Users) session.getAttribute("loginUser");

        List<Course> takeCourses = mypageService.selectTakeCourses(loginUser.getUserId());
        model.addAttribute("takeCourses", takeCourses);


        return "mypage/ajax/course/coursetake";
    }

    @RequestMapping("/coursecomplete")
    public String mycoursecomplete(Model model,HttpSession session) {

        Users loginUser = (Users) session.getAttribute("loginUser");
        List<Course> completeCourse = mypageService.selectCompleteCourses(loginUser.getUserId());
        model.addAttribute("completeCourse", completeCourse);
        return "mypage/ajax/course/coursecomplete";
    }

}
