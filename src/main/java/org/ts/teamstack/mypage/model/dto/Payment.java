package org.ts.teamstack.mypage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Component
public class Payment {
    private int paymentNo;
    private String userId;
    private Timestamp paymentDate;
    private int courseNo;
    private int paymentPrice;
    private String portonId;
}
