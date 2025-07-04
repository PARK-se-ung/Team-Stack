package org.ts.teamstack.course.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.ts.teamstack.user.model.dto.Users;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CourseApplyDto {
    private int courseNo;
    private String userId;
    private String courseTitle;
    private List<Users> applyUsers;
}
