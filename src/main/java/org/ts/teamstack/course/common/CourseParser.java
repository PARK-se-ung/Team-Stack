package org.ts.teamstack.course.common;

import java.sql.Date;
import java.time.LocalDate;

public class CourseParser {
    public static Date getEndDate(Date startDate, int weeks){
        LocalDate localStartDate = startDate.toLocalDate();
        LocalDate localEndDate = localStartDate.plusWeeks(weeks);
        return Date.valueOf(localEndDate);
    }

}
