package org.ts.teamstack.payment.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;
import org.ts.teamstack.course.model.dto.ApplyType;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Component
public class Payment {
    private String paymentId;
    private String userId;
    private Timestamp paymentDate;
    private int courseNo;
    private int paymentPrice;
    private String portoneId;

    private String courseTitle;      // 강의명
    private String instructorName;   // 강사명
    private String userName; //유저명
    private RefundStatus refundStatus; //환불 상태
    private ApplyType applyType;
}
