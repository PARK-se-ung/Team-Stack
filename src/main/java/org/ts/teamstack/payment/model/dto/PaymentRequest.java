package org.ts.teamstack.payment.model.dto;

import lombok.*;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class PaymentRequest {
    private  String paymentId;
    private  String userId;
    private  int paymentPrice;
    private  String portoneId;
    private  Long paymentDate;
    private  int courseNo;
    private String applyType;
}

