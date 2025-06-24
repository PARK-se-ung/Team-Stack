package org.ts.teamstack.payment.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.ts.teamstack.payment.model.dto.Payment;
import org.ts.teamstack.payment.model.service.PaymentService;

@RequiredArgsConstructor
@Controller
public class PaymentController {

    private final PaymentService service;

    @RequestMapping("/payment/complete")
    public String paymentComplete() {

        return "paymentComplete";
    }
    @RequestMapping("/payment/insertPayment")
    public String paymentInsert(Payment payment) {

        int result = service.insertPayment(payment);
        if(result > 0) {
            //성공
        return "/";
        }else{

            return "/";
        }

    }


}
