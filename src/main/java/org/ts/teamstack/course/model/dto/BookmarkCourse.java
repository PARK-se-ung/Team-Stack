package org.ts.teamstack.course.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.ts.teamstack.payment.model.dto.RefundStatus;

import java.sql.Timestamp;
import java.util.List;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @Builder
    public class BookmarkCourse {
        private int courseNo;
        private String userId;
        private String courseTitle;
        private int coursePrice;
        private String courseAddress;
        private String courseContent;
        private Timestamp courseStartDate;
        private int totalWeek;
        private Timestamp recruitDate;
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

        private String instructorName;
        private int bookmarkNo;
}
