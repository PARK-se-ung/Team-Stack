package org.ts.teamstack.manager.model.dto;

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
public class Notice {
    private int noticeNo;
    private String noticeTitle;
    private String noticeContent;
    private Timestamp noticeDate;
}
