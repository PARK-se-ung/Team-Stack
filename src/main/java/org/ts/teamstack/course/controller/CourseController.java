package org.ts.teamstack.course.controller;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseAttach;
import org.ts.teamstack.course.service.CourseService;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/course")
public class CourseController {

    private final CourseService courseService;

    @PostMapping("/insert")
    public Map<String, Object> insertCourse(
            @ModelAttribute Course course,
            BindingResult br,
            @RequestParam(value = "image",      required = false) MultipartFile[] upfiles,
            @RequestParam(value = "thumbnail",  required = false) MultipartFile thumbnail,
            @RequestParam(value = "originalPlanName", required = false) MultipartFile planFile,
            HttpSession session
    ) {
        if (br.hasErrors()) {
            System.out.println("===== 바인딩 오류 목록 =====");
            br.getFieldErrors().forEach(err ->
                    System.out.printf("%s → %s (%s)%n",
                            err.getField(), err.getDefaultMessage(), err.getRejectedValue())
            );
        }

        String path = session.getServletContext().getRealPath("/resources/upload/course");
        File dir = new File(path);
        if (!dir.exists()) dir.mkdirs();

        // 썸네일 저장
        if (thumbnail != null && !thumbnail.isEmpty()) {
            String oriName = thumbnail.getOriginalFilename();
            String ext = oriName.substring(oriName.lastIndexOf("."));
            String rename = "thumb_" + System.currentTimeMillis() + ext;

            try {
                thumbnail.transferTo(new File(dir, rename));
                course.setThumbnail(rename);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 상세 이미지 저장
        if (upfiles != null) {
            List<CourseAttach> files = new ArrayList<>();

            for (MultipartFile upFile : upfiles) {
                if (upFile.isEmpty()) continue;

                String oriName = upFile.getOriginalFilename();
                String ext = oriName.substring(oriName.lastIndexOf("."));
                String rename = "detail_" + System.currentTimeMillis() + "_" + new Random().nextInt(1000) + ext;

                try {
                    upFile.transferTo(new File(dir, rename));
                    CourseAttach attach = CourseAttach.builder()
                            .CourseAttachNo(0) // 시퀀스 사용 시 DB에서 처리
                            .courseAttachName(rename)
                            .build();
                    files.add(attach);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            course.setFiles(files);
        }

        // 강의 계획서 저장
        if (planFile != null && !planFile.isEmpty()) {
            String oriName = planFile.getOriginalFilename();
            String ext = oriName.substring(oriName.lastIndexOf("."));
            String rename = "plan_" + System.currentTimeMillis() + ext;

            try {
                planFile.transferTo(new File(dir, rename));
                course.setOriginalPlanName(oriName);
                course.setRenamePlanName(rename);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        System.out.println(">> courseTitle = " + course.getCourseTitle());
        // 강의 상태를 "STAY"로 기본 설정 (승인 대기)
        course.setCourseStatus("STAY");

        // INSERT 처리

        int result = courseService.insertCourse(course);

        Map<String, Object> res = new HashMap<>();
        res.put("success", result > 0);
        return res;
    }
}
