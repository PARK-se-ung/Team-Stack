package org.ts.teamstack.classpage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class StudentAssign {
    private int stuAssignNo;
    private String stuAssignOriname;
    private String stuAssignRename;
    private int AssignNo;
    private String userId;
    private String scheduleWeek;
    private String userName;
}
