package org.ts.teamstack.classpage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class Score {
    private int scoreNo;
    private String userId;
    private String scoreType;
    private int score;
    private int courseNo;

}
