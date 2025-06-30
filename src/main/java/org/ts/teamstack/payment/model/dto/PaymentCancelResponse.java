package org.ts.teamstack.payment.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class PaymentCancelResponse {
    private int code;
    private String message;
    private PaymentData response;

    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class PaymentData {
        private String imp_uid;
        private String merchant_uid;
        private String pay_method;
        private String pg_provider;
        private String name;
        private int amount;
        private int cancel_amount;
        private String currency;
        private String buyer_name;
        private String buyer_email;
        private String buyer_tel;
        private String status;
        private Long paid_at;
        private Long cancelled_at;
        private String cancel_reason;
        private String receipt_url;
    }
}