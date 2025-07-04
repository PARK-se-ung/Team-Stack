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
public class Board {
    private int boardNo;
    private String boardTitle;
    private String boardContent;
    private String boardType;
    private int courseNo;
    private String boardWriter;
    private Date boardDate;
    private String courseTitle;
}
