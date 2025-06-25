package org.ts.teamstack.course.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.service.CourseService;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/course")
public class CourseController {

    private final CourseService courseService;

    @PostMapping("/insert")
    public Map<String, Object> insertCourse(
            @ModelAttribute Course course,
            @RequestParam(required = false) MultipartFile image,
            @RequestParam(required = false) MultipartFile file
    ) {
        // 필요 시 MultipartFile 저장 로직 추가 (파일 처리 안할 경우 무시 가능)

        int result = courseService.insertCourse(course);

        Map<String, Object> res = new HashMap<>();
        res.put("success", result > 0);
        return res;
    }
}
