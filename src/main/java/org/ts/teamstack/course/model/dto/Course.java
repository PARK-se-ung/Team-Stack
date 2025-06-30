package org.ts.teamstack.course.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class Course {
    private int courseNo;
    private String userId;
    private String courseTitle;
    private int coursePrice;
    private String courseAddress;
    private String courseContent;
    private String courseStartDate;
    private int totalWeek;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date recruitDate;

    private String thumbnail;
    private String gradeType;
    private String subject;
    private String region;
    private String originalPlanName;
    private String renamePlanName;
    private String courseStatus;
    private Timestamp courseDate;
    private String courseStartTime;
    private int courseTime;
    private int personnel;
    private List<CourseAttach> files;
}
