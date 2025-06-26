package org.ts.teamstack.classpage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Assign {
    private int assignNo;
    private String assignTitle;
    private String assignContent;
    private String assignOriname;
    private String assignRename;
    private int scheduleNo;
}
