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
public class Alram {
    private int alramNo;
    private String userId;
    private Timestamp alramDate;
    private String alramContent;
    private String alramStatus;
}

