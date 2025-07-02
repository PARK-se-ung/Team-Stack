package org.ts.teamstack.classpage.controller;

import lombok.RequiredArgsConstructor;
import oracle.jdbc.proxy.annotation.Post;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.ts.teamstack.classpage.model.dto.Board;
import org.ts.teamstack.classpage.model.dto.Schedule;
import org.ts.teamstack.classpage.model.dto.StudentAssign;
import org.ts.teamstack.classpage.model.service.ClassPageService1;
import org.ts.teamstack.common.controller.FileUpload;
import org.ts.teamstack.classpage.model.dto.Assign;
import org.ts.teamstack.course.model.dto.Apply;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.user.model.dto.Users;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.rmi.RemoteException;


@Controller
@RequiredArgsConstructor
@RequestMapping("/class")
public class ClassPageController1 {

    private final ClassPageService1 service;

    @RequestMapping("/dashboard")
    public String dashboard(HttpSession session, HttpServletResponse response, @SessionAttribute(name="loginUser", required=false) Users loginUser, Model model)throws IOException {
        if (loginUser == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "로그인이 필요합니다");
            return null;
        }
        String userId = loginUser.getUserId();
        model.addAttribute("ongoing", service.getOngoingCourses(userId));
        model.addAttribute("complete", service.getCompletedCourses(userId));
        model.addAttribute("allcourse", service.getAllCourses(userId));
        model.addAttribute("type", service.checkUserType(userId));
        model.addAttribute("mycourse", service.getmyCourses(userId));
        return "classes/dashboard";
    }

    @RequestMapping("/dashmain")
    public String dashmain(HttpSession session, HttpServletResponse response, @SessionAttribute(name="loginUser", required=false) Users loginUser, @RequestParam("courseNo")int courseNo, Model model)throws IOException {
        if (loginUser == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "로그인이 필요합니다");
            return null;
        }
        Course userCourse = new Course();
        userCourse.setCourseNo(courseNo);
        userCourse.setUserId(loginUser.getUserId());
        int enrolled = service.isUserEnrolled(userCourse);
        if(enrolled<1) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN,"접근권한이 없습니다.");
        }
        String userId = loginUser.getUserId();
        Course course = new Course();
        course.setUserId(userId);
        course.setCourseNo(courseNo);
        model.addAttribute("completion",service.checkCompletion(course));
        model.addAttribute("course", courseNo);
        model.addAttribute("planfile", service.getPlanFile(courseNo));
        model.addAttribute("caldate",service.getCalDate(courseNo));
        model.addAttribute("calassign", service.getCalAssign(courseNo));
        model.addAttribute("calnotice", service.getNotice(courseNo));
        model.addAttribute("courseid", service.getCourseId(courseNo));
        return "classes/dashmain";
    }

    @GetMapping("/home")
    public String home(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("homenotice", service.getHomeNotice(courseNo));
        model.addAttribute("homeassign", service.getHomeAssign(courseNo));
        return "classes/home";
    }

    @GetMapping("/notice")
    public String notice(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("notice", service.getNotice(courseNo));
        return "classes/notice";
    }

    @GetMapping("/plan")
    public String plan(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("planfile", service.getPlanFile(courseNo));
        model.addAttribute("courseid", service.getCourseId(courseNo));
        return "classes/plan";
    }

    @GetMapping("/week")
    public String week(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("week", service.getWeek(courseNo));
        return "classes/week";
    }

    @RequestMapping("/assign")
    public String assign(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("week", service.getWeek(courseNo));
        return "classes/assign";
    }

    @RequestMapping("/assign2")
    public String assign2(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("schedules", service.getStuAssigns(courseNo));
        return "classes/assign2";
    }

    @RequestMapping("/file")
    public String file(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("courseNo", courseNo);
        model.addAttribute("scheduleWeek", service.getWeekForInsert(courseNo));
        return "classes/file";
    }

//    @RequestMapping("/chatting")
//    public String chatting() {
//        return "classes/chatting";
//    }

    @RequestMapping("/calendar")
    public String calendar() {
        return "classes/calendar";
    }

    @RequestMapping("/assignfile")
    public String assignfile(@RequestParam("courseNo") int courseNo, Model model) {
        model.addAttribute("courseNo", courseNo);
        model.addAttribute("assignWeek", service.getWeekForInsert2(courseNo));
        return "classes/assignfile";
    }

    @PostMapping("/noticeInsert")
    public String noticeInsert(@RequestParam("courseNo") int courseNo,
                               @RequestParam("boardTitle") String boardTitle,
                               @RequestParam("boardContent") String boardContent,
                               RedirectAttributes rttr
    ) {
        Board notice = new Board();
        notice.setCourseNo(courseNo);
        notice.setBoardTitle(boardTitle);
        notice.setBoardContent(boardContent);

        int result = service.insertNotice(notice);
        if(result > 0 ){
            rttr.addFlashAttribute("msg","공지 등록이 완료되었습니다.");
        } else {
            rttr.addFlashAttribute("error","공지 등록에 실패했습니다.");
        }

        rttr.addAttribute("courseNo", courseNo);

        return "redirect:/class/dashmain";
    }

    @PostMapping("/assignInsert")
    public String assignInsert(@ModelAttribute Assign assign,
                               @RequestParam("courseNo")int courseNo,
                               @RequestParam("scheduleWeek")int scheduleWeek,
                               @RequestParam("file") MultipartFile file,
                               HttpSession session,
                               RedirectAttributes rttr
                               ){
        String path = session.getServletContext().getRealPath("/resources/upload/classes/assigns");
        if (file != null && !file.isEmpty()) {
            assign.setAssignRename(FileUpload.renameFile(file));
        }
        assign.setAssignOriname(file.getOriginalFilename());
        assign.setScheduleWeek(scheduleWeek);
        assign.setCourseNo(courseNo);
        Schedule schedule = new Schedule();
        schedule.setCourseNo(courseNo);
        schedule.setScheduleWeek(scheduleWeek);
        int result = service.assignCheck(schedule);
        int result2 = 0;
        if(result > 0){
            result2 = service.aFileUpdate(assign);
        }else{
            result2 = service.aFileInsert(assign);
        }
        if(result2>0){
            try{
                FileUpload.saveFile(file,path,assign.getAssignRename());
                rttr.addFlashAttribute("msg","과제 등록이 완료되었습니다.");
            }catch(IOException e){
                e.printStackTrace();
                rttr.addFlashAttribute("error","과제 등록에 실패했습니다.");
            }
        }
        rttr.addAttribute("courseNo", courseNo);
        return "redirect:/class/dashmain";
    }

    @PostMapping("/materialInsert")
    public String materialInsert(@ModelAttribute Schedule schedule,
                               @RequestParam("courseNo")int courseNo,
                               @RequestParam("scheduleWeek")int scheduleWeek,
                               @RequestParam("file") MultipartFile file,
                               HttpSession session,
                               RedirectAttributes rttr
                                ){
        String path = session.getServletContext().getRealPath("/resources/upload/classes/files");
        if (file != null && !file.isEmpty()) {
            schedule.setScheduleRename(FileUpload.renameFile(file));
        }
        schedule.setScheduleOriname(file.getOriginalFilename());
        schedule.setScheduleWeek(scheduleWeek);
        schedule.setCourseNo(courseNo);
        int result = service.scheduleUpdate(schedule);
        if(result>0){
            try{
                FileUpload.saveFile(file,path,schedule.getScheduleRename());
                rttr.addFlashAttribute("msg","강의파일 등록이 완료되었습니다.");
            }catch (IOException e){
                e.printStackTrace();
                rttr.addFlashAttribute("error","강의파일 등록을 실패했습니다.");
            }
        }

        rttr.addAttribute("courseNo", courseNo);
        return "redirect:/class/dashmain";
    }

    @PostMapping("/assignsubmit")
    public String assignSubmit(@ModelAttribute StudentAssign studentAssign,
                               @RequestParam("courseNo")int courseNo,
                               @RequestParam("scheduleNo")int ScheduleNo,
                               @RequestParam("file") MultipartFile file,
                               @SessionAttribute("loginUser") Users loginUser,
                               HttpSession session,
                               RedirectAttributes rttr
                                ) {
        String path = session.getServletContext().getRealPath("/resources/upload/classes/student");

        if (file != null && !file.isEmpty()) {
            studentAssign.setStuAssignRename(FileUpload.renameFile(file));
        }
        studentAssign.setStuAssignOriname(file.getOriginalFilename());
        studentAssign.setUserId(loginUser.getUserId());
        Assign assign = new Assign();
        assign.setScheduleNo(ScheduleNo);
        int assignNo = service.getAssignNo(assign);
        studentAssign.setAssignNo(assignNo);
        int result1 = service.stuAssignCheck(studentAssign);
        int result2 = 0;
        if (result1>0){
            result2 = service.stuFileUpdate(studentAssign);
        }else{
            result2 = service.stuFileInsert(studentAssign);
        }
        if(result2>0){
            try{
                FileUpload.saveFile(file,path,studentAssign.getStuAssignRename());
                rttr.addFlashAttribute("msg","과제 등록이 완료되었습니다.");
            }catch (IOException e){
                e.printStackTrace();
                rttr.addFlashAttribute("error","과제 등록을 실패했습니다.");
            }
        }
        rttr.addAttribute("courseNo", courseNo);
        return  "redirect:/class/dashmain";
    }

}
