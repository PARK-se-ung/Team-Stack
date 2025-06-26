package org.ts.teamstack.payment.controller;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.ts.teamstack.payment.model.dto.Payment;
import org.ts.teamstack.payment.model.service.PaymentService;
import org.ts.teamstack.user.model.dto.Users;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor
@Controller
@RequestMapping("/payment")
public class PaymentController {

    private final PaymentService service;

    @Data
    public class PaymentRequest {
        private String paymentId;
        private String userId;
        private int paymentPrice;
        private String portoneId;
        private Long paymentDate;
        private int courseNo;
    }

    @RequestMapping("/insertPayment")
    @ResponseBody
    public String insertPayment(@RequestBody PaymentRequest request) {

        Payment payment = Payment.builder()
                            .paymentId(request.getPaymentId())
                        .userId(request.getUserId())
                        .paymentPrice(request.getPaymentPrice())
                        .portoneId(request.getPortoneId())
                        .paymentDate(new Timestamp(request.getPaymentDate() * 1000))
                        .courseNo(request.getCourseNo())
                        .build();
        int result = service.insertPayment(payment);
        if(result > 0) {
            //성공
        return "success";
        }else{
            return "fail";
        }

    }

    @GetMapping("generatePaymentPk")
    @ResponseBody
    String generatePaymentPk() {

        String merchantUid;

        do {
        String uuid = UUID.randomUUID().toString();

        Calendar baseCalendar = Calendar.getInstance();
        baseCalendar.set(2025, Calendar.JANUARY, 1, 0, 0, 0);
        baseCalendar.set(Calendar.MILLISECOND, 0);
        long baseTime = baseCalendar.getTimeInMillis();

        long currentTime = System.currentTimeMillis();
        long ms = currentTime - baseTime;

        merchantUid = uuid + ms;

    } while (service.existsByPaymentId(merchantUid)); // 중복 체크
        System.out.println(merchantUid);
        return merchantUid;
    }

}
