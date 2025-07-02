package org.ts.teamstack.classpage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class Attendence {

    private int attendNo;
    private Date attendDate;
    private String userId;
    private AttendStatus attendStatus;
    private int courseNo;
    private int attendRound;
}
