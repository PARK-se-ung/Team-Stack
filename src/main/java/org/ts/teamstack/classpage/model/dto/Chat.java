package org.ts.teamstack.classpage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Chat {
    private int chatNo;
    private int courseNo;
    private String userId;
    private String chatMsg;
    private Timestamp chatTime =new Timestamp(System.currentTimeMillis());
}
