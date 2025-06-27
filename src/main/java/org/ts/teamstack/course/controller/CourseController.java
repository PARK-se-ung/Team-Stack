package org.ts.teamstack.course.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.ts.teamstack.common.controller.FileUpload;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.course.model.dto.CourseAttach;
import org.ts.teamstack.course.service.CourseService;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.http.HttpResponse;
import java.text.SimpleDateFormat;
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
            BindingResult br,
            @RequestParam(value = "slideImage", required = false) MultipartFile[] upfiles,
            @RequestParam(value = "thumbnail",  required = false) MultipartFile thumbnail,
            @RequestParam(value = "courseContent",  required = false) MultipartFile content,
            @RequestParam(value = "originalPlanName", required = false) MultipartFile planFile,
            HttpSession session
    ) {

        // path 생성
        String path = session.getServletContext().getRealPath("/resources/upload/course");
        File dir = new File(path);
        if(!dir.exists()){
            boolean flag = dir.mkdirs();
            if(!flag) log.error("create fail");
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
        if(upfiles != null && upfiles.length > 0){
            int level = 1;
            for(MultipartFile file : upfiles){
                if(file != null & !file.isEmpty()){
                    CourseAttach courseAttach = CourseAttach.builder()
                            .courseAttachLevel(level++)
                            .courseAttachName(FileUpload.renameFile(file))
                            .build();
                    attachList.add(courseAttach);
                }
            }
        }
        course.setFiles(attachList);

        // 강의 계획서 rename
        if (planFile != null && !planFile.isEmpty()) {
            course.setOriginalPlanName(planFile.getOriginalFilename());
            course.setRenamePlanName(FileUpload.renameFile(planFile));
        }

        // 강의 & files INSERT 처리

        int result = 0;
        try{
            result = courseService.insertCourse(course);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // DB 저장결과 기반 파일들 upload 폴더에 저장
        if(result > 0){
            try{
                // 썸네일 저장
                FileUpload.saveFile(thumbnail, path, course.getThumbnail());
                // content 저장
                FileUpload.saveFile(content, path, course.getCourseContent());
                // files 저장
                int order = 0;
                for(MultipartFile file : upfiles){
                    if(file != null && !file.isEmpty()){
                        FileUpload.saveFile(file, path, attachList.get(order++).getCourseAttachName());
                    }
                }
                // plan 저장

            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        Map<String, Object> res = new HashMap<>();
        res.put("success", result > 0);
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


    @RequestMapping("searchcoursebyno")
    public String searchCourseByNo(@RequestParam int courseNo, @CookieValue(name="teamstackRecentView", required = false) Cookie recentView,
                                   Model model, HttpServletResponse response){
        Set<Integer> courseNos = new LinkedHashSet<>();
        courseNos.add(courseNo);
        if(recentView != null && !recentView.getValue().isEmpty()){
            for(String no : recentView.getValue().split(",")){
                if(courseNos.size() < 8) courseNos.add(Integer.parseInt(no));
            }
        }


        Course course = courseService.searchCourseByNo(courseNo);
        model.addAttribute("course", course);



        return "course/course";
    }
}

