package org.ts.teamstack.classpage.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.ts.teamstack.classpage.model.dto.Board;
import org.ts.teamstack.classpage.model.dto.Schedule;
import org.ts.teamstack.classpage.model.service.ClassPageService1;
import org.ts.teamstack.common.controller.FileUpload;
import org.ts.teamstack.classpage.model.dto.Assign;
import org.ts.teamstack.user.model.dto.Users;

import javax.servlet.http.HttpSession;
import java.io.IOException;


@Controller
@RequiredArgsConstructor
@RequestMapping("/class")
public class ClassPageController1 {

    private final ClassPageService1 service;

    @RequestMapping("/dashboard")
    private String dashboard(@SessionAttribute("loginUser") Users loginUser, Model model) {
        String userId = loginUser.getUserId();
        model.addAttribute("ongoing", service.getOngoingCourses(userId));
        model.addAttribute("complete", service.getCompletedCourses(userId));
        model.addAttribute("allcourse", service.getAllCourses(userId));
        model.addAttribute("type", service.checkUserType(userId));
        model.addAttribute("mycourse", service.getmyCourses(userId));
        return "classes/dashboard";
    }

    @RequestMapping("/dashmain")
    private String dashmain(@RequestParam("courseNo")int courseNo, Model model) {
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
}
