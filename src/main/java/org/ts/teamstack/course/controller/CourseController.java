package org.ts.teamstack.course.controller;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.ts.teamstack.common.controller.FileUpload;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseAttach;
import org.ts.teamstack.course.service.CourseService;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
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
            @RequestParam(value = "slideImage", required = false) MultipartFile[] upfiles,
            @RequestParam(value = "thumbnail",  required = false) MultipartFile thumbnail,
            @RequestParam(value = "courseContent",  required = false) MultipartFile content,
            @RequestParam(value = "originalPlanName", required = false) MultipartFile planFile,
            HttpSession session
    ) {

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

        if (content != null && !content.isEmpty()) {
            String oriName = content.getOriginalFilename();
            String ext = oriName.substring(oriName.lastIndexOf("."));
            String rename = "content_" + System.currentTimeMillis() + ext;

            try {
                content.transferTo(new File(dir, rename));
                course.setCourseContent(rename);
            } catch (Exception e) {
                e.printStackTrace();
            }
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
        int flag = 0;
        // 슬라이드 이미지() 이미지 저장
        if(result > 0) {
            if ( upfiles!= null) {
                try{
                    List<String> renames = FileUpload.saveFiles(upfiles,path);
                    List<CourseAttach> attachs = new ArrayList<>();
                    for (int i = 0; i < renames.size(); i++) {
                        CourseAttach attach = CourseAttach.builder()
                                .courseNo(course.getCourseNo())
                                .courseAttachName(renames.get(i))
                                .courseAttachLevel(i)
                                .build();
                        attachs.add(attach);
                        flag = courseService.insertAttach(attach);
//                        if(flag == 0) {
//                            courseService.deleteCourse();
//                            break;
//                        }
                    }
                }catch (IOException e){
                    e.printStackTrace();
                }
            }
        }
        Map<String, Object> res = new HashMap<>();
        res.put("success", flag > 0);
        return res;
    }
    @DeleteMapping("/bookmark/delete")
    @ResponseBody
    public String deleteBookmark(@RequestParam int bookmarkNo) {
        int res =  courseService.deleteBookmark(bookmarkNo);
        String result = "";
        if(res>0) result="success";
        else result="fail";
        return result;
    }

}

