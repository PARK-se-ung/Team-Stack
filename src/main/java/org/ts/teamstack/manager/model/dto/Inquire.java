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
public class Inquire {
    private int inquireNo;
    private String userId;
    private String inquireTitle;
    private String inquireContent;
    private Timestamp inquireDate;
    private String inquireStatus;
}
