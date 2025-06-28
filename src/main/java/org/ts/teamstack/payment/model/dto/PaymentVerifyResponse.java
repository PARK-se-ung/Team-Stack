package org.ts.teamstack.payment.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class PaymentVerifyResponse {
    private  int code;
    private  String message;
    private  VerifiedPaymentData response;



    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class VerifiedPaymentData {
        private  String merchant_uid;
        private  int amount;
        private  String currency;


    }
}