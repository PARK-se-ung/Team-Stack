package org.ts.teamstack.course.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Component
public class CourseAttach {
    private int CourseAttachNo;
    private int courseNo;
    private int courseAttachLevel;
    private String courseAttachName;
}
