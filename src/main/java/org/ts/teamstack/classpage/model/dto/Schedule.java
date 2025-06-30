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
public class Schedule {
    private int scheduleNo;
    private int scheduleWeek;
    private String scheduleOriname;
    private String scheduleRename;
    private int courseNo;
    private Date scheduleDate;
    private Date scheduleEnddate;
    private String AssignOriname;
    private String AssignRename;
}
