package org.ts.teamstack.course.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.ts.teamstack.common.controller.FileUpload;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseAttach;
import org.ts.teamstack.course.service.CourseService;
import org.ts.teamstack.user.model.dto.Users;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/course")
@Slf4j
public class CourseController {

    private final CourseService courseService;

    @PostMapping("/insert")
    public Map<String, Object> insertCourse(
            @ModelAttribute Course course,
            @RequestParam(value = "slideImage", required = false) MultipartFile[] upfiles,
            @RequestParam(value = "thumbnailFile",  required = false) MultipartFile thumbnail,
            @RequestParam(value = "contentFile",  required = false) MultipartFile content,
            @RequestParam(value = "planFile", required = false) MultipartFile planFile,
            HttpSession session
    ) {
        Users loginUser = (Users)session.getAttribute("loginUser");
        if (loginUser == null) {

        }
        course.setUserId(loginUser.getUserId());


        // path 생성
        String path = session.getServletContext().getRealPath("/resources/upload/course");
        File dir = new File(path);
        if (!dir.exists()) {
            boolean flag = dir.mkdirs();
            if (!flag) log.error("create fail");
        }

        // 강의 상태를 "STAY"로 기본 설정 (승인 대기)
        course.setCourseStatus("STAY");

        // 썸네일 rename
        if (thumbnail != null && !thumbnail.isEmpty()) {
            course.setThumbnail(FileUpload.renameFile(thumbnail));
        }

        // content rename
        if (content != null && !content.isEmpty()) {
            course.setCourseContent(FileUpload.renameFile(content));
        }

        // attach rename
        List<CourseAttach> attachList = new ArrayList<>();
        if (upfiles != null && upfiles.length > 0) {
            int level = 1;
            for (MultipartFile file : upfiles) {
                if (file != null && !file.isEmpty()) {
                    CourseAttach attach = CourseAttach.builder()
                            .courseAttachLevel(level++)
                            .courseAttachName(FileUpload.renameFile(file))
                            .build();
                    attachList.add(attach);
                }
            }
        }
        course.setFiles(attachList);

        // 강의 계획서 rename
        if (planFile != null && !planFile.isEmpty()) {
            course.setOriginalPlanName(planFile.getOriginalFilename());
            course.setRenamePlanName(FileUpload.renameFile(planFile));
        }

        // insert 처리
        int result = 0;
        try {
            result = courseService.insertCourse(course);
        } catch (Exception e) {
            log.error("insertCourse error", e);
        }

        // 파일 저장
        if (result > 0) {
            try {
                FileUpload.saveFile(thumbnail, path, course.getThumbnail());
                FileUpload.saveFile(content, path, course.getCourseContent());
                int order = 0;
                for (MultipartFile file : upfiles) {
                    if (file != null && !file.isEmpty()) {
                        FileUpload.saveFile(file, path, attachList.get(order++).getCourseAttachName());
                    }
                }
                // planFile 저장
                FileUpload.saveFile(planFile, path, course.getRenamePlanName());
            } catch (IOException e) {
                log.error("file save error", e);
            }
        }

        Map<String, Object> res = new HashMap<>();
        res.put("success", result > 0);
        return res;
    }

    @DeleteMapping("/bookmark/delete")
    public String deleteBookmark(@RequestParam int bookmarkNo) {
        int res = courseService.deleteBookmark(bookmarkNo);
        return res > 0 ? "success" : "fail";
    }
}
