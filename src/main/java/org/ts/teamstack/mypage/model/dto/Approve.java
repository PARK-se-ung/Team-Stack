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
public class Approve {
    private int approveNo;
    private String userId;
    private String approveOrigin;
    private String approveRename;
    private Timestamp approveDate;
}
