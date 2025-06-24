package org.ts.teamstack.payment.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.ts.teamstack.payment.model.dto.Payment;
import org.ts.teamstack.payment.model.service.PaymentService;
import org.ts.teamstack.user.model.dto.Users;

import java.sql.Timestamp;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/payment")
public class PaymentController {

    private final PaymentService service;

//    @RequestMapping("/paymentComplete")
//    public void paymentComplete(String imp_uid, String merchant_uid) {
//        System.out.println("결제 성공");
//        System.out.println("imp_uid : " + imp_uid);
//        System.out.println("merchant_uid : " + merchant_uid);
//    }
    @RequestMapping("/insertPayment")
    @ResponseBody
    public String paymentInsert(String userId,int paymentPrice,String portonId,Long paymentDate, int courseNo) {

        Payment payment = Payment.builder().userId(userId).paymentPrice(paymentPrice).portoneId(portonId).paymentDate(new Timestamp(paymentDate*1000)).courseNo(courseNo).build();
        int result = service.insertPayment(payment);
        if(result > 0) {
            //성공
        return "success";
        }else{
            return "fail";
        }

    }
//    @RequestMapping("/searchAllPayment")
//    public String searchAllPayment(Model model
//
//    ) {
//        /*임시 로그인 멤버생성*/
//        Users tempUser = Users.builder()
//                .userId("user_0005")
//                .userName("유저0005")
//                .userType("G")
//                .userEmail("user0005@user0005.com")
//                .userPhone("010-1111-0003")
//                .build();
//
//        List<Payment> payments = service.searchAllPayment(tempUser.getUserId());
//        model.addAttribute("paymentList", payments);
//        return "/mypage/ajax/payment/purchase";
//
//
//    }

}
