package org.ts.teamstack.payment.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class PaymentCancelRequest {
    private String imp_uid;  // 포트원 고유 결제 ID
    private String reason;  // 취소 사유
}
