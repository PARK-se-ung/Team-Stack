package org.ts.teamstack.payment.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Refund {
    private int refundNo;
    private String paymentId;
    private RefundStatus refundStatus;
    private Timestamp refundDate;

    private String userId;         // 구매자 ID
    private String userName;       // 구매자명
    private Timestamp paymentDate; // 결제일
    private int paymentPrice;      // 결제금액
    private String portoneId;      // imp_uid
    private int courseNo;          // 강의번호
    private String courseTitle;    // 강의명
}
