package org.ts.teamstack.classpage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.ts.teamstack.classpage.model.dto.Attend;
import org.ts.teamstack.classpage.model.dto.Chat;
import org.ts.teamstack.classpage.model.dto.Score;
import org.ts.teamstack.classpage.model.service.ClassPageService1;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.user.model.dto.Users;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/class")
public class ClassController {

    @Autowired
    ClassPageService1 service;

    @RequestMapping("/chatting")
    public String chatting(int courseNo, HttpSession session, Model model) {
        // 쿼리스트링 방식으로 필요 값을 보내기 때문에 @RequestParam을 통해 가지고 올 수 있음
        // 위와 같이 이름이 같은 경우에는 그냥 사용이 가능하다.
        // 이렇게 쿼리스트링 방식으로 보내는 것은 Get 식으로 노출됨
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users user1 = (Users) auth.getPrincipal();
        Course course = service.getCourse(courseNo);

        // 세션에 저장된 사용자 정보 (로그인 이후 저장된 경우만 해당)
        Object loginUser = session.getAttribute("loginUser");
//        System.out.println("[세션 사용자] loginUser: " + loginUser);

        // 채팅 내역 가져오기
        try {
            List<Chat> chattingHistory = service.getChattingHistory(courseNo);
//            System.out.println("[채팅 내역 개수] " + chattingHistory.size());
            model.addAttribute("chattingHistory", chattingHistory);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // JSP에서 사용할 courseNo 전달
        session.setAttribute("courseNo", courseNo);

        return "classes/chatting"; // → /WEB-INF/views/classes/chatting.jsp 로 포워딩됨
    }

    @RequestMapping("/attend")
    public String attend(int courseNo, HttpSession session, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users user1 = (Users) auth.getPrincipal();
        String userId = user1.getUserId();

        String instructorId = service.getCourseId(courseNo);

        if (instructorId.equals(userId)) {
            List<String> students = service.getUsersByCourseId(courseNo);
            model.addAttribute("students", students);
            List<Integer> classweeks = service.getClassCount(courseNo);
            model.addAttribute("classweeks", classweeks);
            Course course = service.getCourse(courseNo);
            model.addAttribute("course", course);


            Map<Integer, Integer> attendCount = service.getAttendCountByRound(courseNo);

            model.addAttribute("attendCount", attendCount);
            model.addAttribute("totalStudentCount", students.size());


            return "classes/instructorattend";
        }
        Course course = service.getCourse(courseNo);
        model.addAttribute("course", course);
        List<Attend> attends = service.getAttend(userId, courseNo);
        model.addAttribute("attends", attends);
        int attendCount = 0;
        for (Attend attend : attends) {
            if (attend.getAttendStatus().equals("ATTEND")) {
                attendCount++;
            }
        }

        model.addAttribute("attendCount", attendCount);

        return "classes/studentattend";
    }

    @RequestMapping("/insertattend.do")
    @ResponseBody
    public String insertattend(@RequestBody List<Attend> attends) {

        for (Attend attend : attends) {
            boolean exist = service.isAttendExists(attend);

            if(exist){
                int result = service.updateAttend(attend);
            } else {
                int insertResult = service.insertAttend(attend);
            }

        }
        return "success";
    }

    @RequestMapping("/score")
    public String score(int courseNo, HttpSession session, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users user1 = (Users) auth.getPrincipal();
        String userId = user1.getUserId();

        String instructorId = service.getCourseId(courseNo);
        Course course = service.getCourse(courseNo);
        model.addAttribute("course", course);

        if (instructorId.equals(userId)) {
            // 수강생 이름 가지고 오기
            List<String> students = service.getUserNameByCourseId(courseNo);
            model.addAttribute("students", students);
            // 저장된 점수 정보가지고 오기
            List<Score> scores = service.getAllScores(courseNo);
            model.addAttribute("scores", scores);

            return "classes/instructorscore";
        }
        List<Score> scores = service.searchUserScore(userId,courseNo);
        model.addAttribute("scores", scores);



        return "classes/studentscore";
    }

    @RequestMapping("/saveGrades.do")
    @ResponseBody
    public String saveGrades(@RequestBody List<Score> scoreList) {
        for (Score score : scoreList) {
            // 점수 저장 처리
            if (service.scoreExist(score)!=null){
                service.updateScore(score);
            } else {
                service.insertScore(score);
            }
        }
        return "success";
    }
}
