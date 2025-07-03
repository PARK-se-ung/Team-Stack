package org.ts.teamstack.classpage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Assign {
    private int assignNo;
    private String assignOriname;
    private String assignRename;
    private int scheduleNo;
    private int scheduleWeek;
    private int courseNo;
}
