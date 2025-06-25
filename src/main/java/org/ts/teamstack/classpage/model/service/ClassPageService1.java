package org.ts.teamstack.classpage.model.service;

import org.ts.teamstack.classpage.model.dto.Board;
import org.ts.teamstack.course.model.dto.Course;

import java.util.List;

public interface ClassPageService1 {

    List<Course> getAllCourses(String userId);

    List<Course> getOngoingCourses(String userId);

    List<Course> getCompletedCourses(String userId);

    List<Board> getHomeNotice(int courseNo);

    List<Board> getHomeAssign(int courseNo);
}
