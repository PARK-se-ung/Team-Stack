package org.ts.teamstack.home.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.ts.teamstack.common.controller.PageBarFactory;
import org.ts.teamstack.common.model.dto.PageInfo;
import org.ts.teamstack.course.model.dto.Course;
import org.ts.teamstack.home.service.HomeService;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final HomeService service;
    private final PageInfo pageInfo;

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
    public String searchcourselist(@RequestParam(defaultValue = "전체") String category,
                                   Model model){
        pageInfo.initialize();
        pageInfo.setTotalData(service.searchCourseCount(Map.of("category", category)));
        pageInfo.setNumPerpage(10);
        pageInfo.setCurPage(1);
        List<Course> courses = service.searchCourseByRest(Map.of("category", category), pageInfo);
        model.addAttribute("courses", courses);
        model.addAttribute("pageBar", PageBarFactory.ajaxPageBuilder(pageInfo, "loadCourse"));
        return "course/course";
    }

    @RequestMapping("/home/searchcoursebyrest")
    public String searchcoursebyrest(@RequestParam(defaultValue = "1") int cPage,
                                    @RequestParam Map<String, String> params,
                                     Model model){
        Map<String, Object> parsedParams = new HashMap<>(params);

        if (params.containsKey("schools")) {
            parsedParams.put("schools", List.of(params.get("schools").split(",")));
        }
        if (params.containsKey("weeks")) {
            parsedParams.put("weeks", List.of(params.get("weeks").split(",")));
        }

        pageInfo.initialize();
        pageInfo.setTotalData(service.searchCourseCount(parsedParams));
        pageInfo.setNumPerpage(10);
        pageInfo.setCurPage(cPage);

        List<Course> courses = service.searchCourseByRest(parsedParams, pageInfo);
        model.addAttribute("courses", courses);
        model.addAttribute("pageBar", PageBarFactory.ajaxPageBuilder(pageInfo, "loadCourse"));
        return "course/courseinner";
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
        System.out.println(course);
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
