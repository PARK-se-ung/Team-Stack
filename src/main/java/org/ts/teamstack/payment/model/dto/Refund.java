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
}
