package org.ts.teamstack.course.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Apply {
        private int applyNo;
        private String userId;
        private Integer courseNo;
        private ApplyType applyType;     // (RESERVE,TAKE등)
        private Timestamp applyDate;
}
