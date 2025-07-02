package org.ts.teamstack.classpage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class Attend {

    private int attendNo;
    private String userId;
    private String attendStatus;
    private int courseNo;
    private int attendRound;
    private int courseRound;
}
