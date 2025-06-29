package org.ts.teamstack.payment.model.dto;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class PaymentPrepareResponse {
    private  int code;
    private  String message;
    private  PaymentData response;



    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class PaymentData {
        private  String merchant_uid;
        private  int amount;
        private  String currency;


    }
}