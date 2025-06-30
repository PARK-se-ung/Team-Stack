package org.ts.teamstack.home.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.home.service.HomeService;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final HomeService service;

    @RequestMapping("/")
    public String index(@CookieValue(name = "teamstackRecentView",required = false)
                            Cookie cookie,
                            Model model){

        /* cookie 세팅 */
        List<Integer> courseNoList = new ArrayList<>();
        if (cookie != null && !cookie.getValue().isEmpty()) {
            for (String no : cookie.getValue().split("\\|")) {
                try {
                    courseNoList.add(Integer.parseInt(no));
                } catch (NumberFormatException ignore) {}
            }
        }
        if (!courseNoList.isEmpty()) {
            List<Course> recentCourses = service.selectCoursesByCourseNos(courseNoList);
            model.addAttribute("recentCourses", recentCourses);
        }

        /* 초중고 데이터 저장 */
        model.addAttribute("course" , service.homeCourses());
        return "index";
    }

    @RequestMapping("/home/searchcourselist")
    public String searchcourselist(@RequestParam String category,
                                   @RequestParam(defaultValue = "total") String subject,
                                   @RequestParam(defaultValue = "total") String region,
                                   @RequestParam(defaultValue = "total") List<String> week,
                                   @RequestParam(defaultValue = "") String searchData,
                                   Model model){


        return "course/course";
    }

    @RequestMapping("/home/searchcoursebyno")
    public String searchcoursebyno(@RequestParam int courseNo,
                                   @CookieValue(name="teamstackRecentView", required = false) Cookie recentView,
                                   HttpServletResponse response,
                                   Model model){

        /* cookie 저장 */
        Set<Integer> courseNos = getIntegers(courseNo, recentView);
        String cookieValue = courseNos.stream()
                .map(String::valueOf)
                .collect(Collectors.joining("|"));

        Cookie newCookie = new Cookie("teamstackRecentView", cookieValue);
        newCookie.setPath("/");
        newCookie.setMaxAge(60 * 60 * 24 * 7);
        response.addCookie(newCookie);

        /* course search */
        Course course = service.searchCourseByNo(courseNo);
        model.addAttribute("course", course);

        return "course/coursedetail";
    }

    private static Set<Integer> getIntegers(int courseNo, Cookie recentView) {
        Set<Integer> courseNos = new LinkedHashSet<>();
        courseNos.add(courseNo);

        if (recentView != null && !recentView.getValue().isEmpty()) {
            for (String no : recentView.getValue().split("\\|")) {
                try {
                    int parsed = Integer.parseInt(no);
                    if (parsed != courseNo && courseNos.size() < 5) {
                        courseNos.add(parsed);
                    }
                } catch (NumberFormatException ignore) {}
            }
        }
        return courseNos;
    }

}
