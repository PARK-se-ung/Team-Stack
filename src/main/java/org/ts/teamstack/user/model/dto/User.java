package org.ts.teamstack.user.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class User {
    private String userId;
    private String userPwd;
    private String userName;
    private String userEmail;
    private Date userCreateTime;
    private String userType;
    private String userPhone;
}
