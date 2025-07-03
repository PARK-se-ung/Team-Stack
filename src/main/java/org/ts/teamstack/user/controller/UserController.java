package org.ts.teamstack.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.ts.teamstack.user.model.dto.Users;
import org.ts.teamstack.user.service.UserServiceImpl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserServiceImpl service;

    @RequestMapping("/login.do")
    public String login(@ModelAttribute("user") Users user) {
        return "user/loginpage";
    }
    @RequestMapping("/searchIdByEmail.do")
    public String searchIdByEmail() {
        return "user/searchIdByEmail";
    }
    @RequestMapping("/searchPwdByEmail.do")
    public String searchPwdByEmail() {
        return "user/searchPwdByEmail";
    }
    // 만들면
//    @PostMapping(value = "/loginend.do")
//    public String loginend(){
//
//    }
   /* @RequestMapping("/loginend.do")
    public String loginEnd(String userId,String password, Model model) {
        Users u= service.searchById(userId,password);
        if(u!=null){
            model.addAttribute("loginMember",u);
            System.out.println("ㅎㅎㅎㅎㅎ");
            return "redirect:/";
        } else {
            return "user/loginpage";
        }
    }*/
    @PostMapping("/loginsuccess")
    public String loginSuccess(HttpServletRequest request) {
        //model.addAttribute("loginUser", request.getSession().getAttribute("loginUser"));
        // model의 경우 redirect를 하면 없어짐
        // 이 시점에 request.getSession().getAttribute("loginUser")는 ❌ null일 가능성 큼
        // Spring Security는 로그인 성공 시 Authentication 객체를 SecurityContext에 저장
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof Users) {
            Users user = (Users) auth.getPrincipal();
            request.getSession().setAttribute("loginUser", user);
        }
        return "redirect:/";
    }


    @PostMapping("/loginfailure")
    public String loginFail(HttpServletRequest request, Model model) {
        model.addAttribute("msg","아이디 또는 비밀번호가 올바르게 입력되지 않았습니다.");
        return "user/loginpage"; // 로그인 화면으로 다시 보냄
    }

    @RequestMapping("/enrolluser.do")
    public String enrolluser(@ModelAttribute("users") Users user){
        return "user/enrolluserpage";
    }
    @PostMapping("/enrolluserend.do")
    public String enrollUserEnd(@Validated Users users, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/enrolluserpage";
        }
        int insertResult = service.insertUser(users);
        if (insertResult > 0) {

        }

        return "redirect:/";

    }

    /*@RequestMapping("/enrolluserend.do")
    public String enrolluserend(String userId, String userPwd, String userName, String userEmail
                                ,String userAddress, String userPhone){

        Users user = Users.builder().userId(userId)
                .userPwd(userPwd).userName(userName)
                .userEmail(userEmail).userAddress(userAddress)
                .userPhone(userPhone).build();

        int insertResult = service.insertUser(user);
        return "redirect:/";
    }*/

    /* 개인 정보 수정 */
    @PostMapping("/userUpdate")
    public ModelAndView updateUsers(ModelAndView mv, HttpServletRequest request) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Users loginUser = (Users) auth.getPrincipal();

        int result = service.updateUsers(loginUser);
        if (result > 0) {
            request.getSession().setAttribute("loginUser", loginUser);
            mv.addObject("msg","수정완료");
            mv.addObject("loc","/mypage");
        } else {
            mv.addObject("msg","수정실패");
            mv.addObject("loc","/mypage");
        }
        mv.setViewName("common/msg");
        return mv;

    }
    @PostMapping("/updatePassword")
    @ResponseBody
    public Map<String, Object> updatePassword(@RequestBody Map<String, String> request,
                                              HttpServletRequest httpRequest) {
        Map<String, Object> response = new HashMap<>();


        try {
            String newPassword = request.get("newPassword");

            // 현재 로그인한 사용자 정보 가져오기
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            Users loginUser = (Users) auth.getPrincipal();
            Map<String, Object> user = new HashMap<>();
            user.put("userId",loginUser.getUserId());
            user.put("password",newPassword);

            // Service에서 비밀번호 변경 처리 (암호화 포함)
            int result = service.updatePassword(user);

            if (result>0) {
                // 비밀번호 변경 성공 시 세션 무효화 (로그아웃)
                httpRequest.getSession().invalidate();

                response.put("success", true);
                response.put("logout", true);
            } else {
                response.put("success", false);
            }

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }


}
