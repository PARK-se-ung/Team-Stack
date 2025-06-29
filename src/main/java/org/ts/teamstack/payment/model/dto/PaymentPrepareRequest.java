package org.ts.teamstack.payment.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class PaymentPrepareRequest {
    private  String merchant_uid;
    private  int amount;
}