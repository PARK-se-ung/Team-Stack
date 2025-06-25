//package org.ts.teamstack.user.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.scheduling.annotation.EnableAsync;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//import org.ts.teamstack.user.service.MailService;
//
//import javax.mail.MessagingException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.PrintWriter;
//import java.util.HashMap;
//import java.util.Map;
//
//@Controller
//public class MailController {
//
//    @Autowired
//    private MailService mailService;
//
//    @PostMapping(value ="/sendEmail", produces = "application/json;charset=UTF-8" )
//    @ResponseBody
//    public Map<String, Object> sendEmail(@RequestBody Map<String, String> param, HttpSession session) {
//        String email = param.get("email");
//
//        Map<String, Object> result = new HashMap<>();
//        try {
//            String authCode = mailService.joinEmail(email);
//            // 이메일 발송 + 인증번호 생성
//            session.setAttribute("authCode", authCode);
//            // 인증 번호가 왜 안담기지..?
//            result.put("sendmailresult", true);
//        } catch (Exception e) {
//            result.put("sendmailresult", false);
//        }
//
//        return result;
//
//    }
//    @PostMapping(value ="/verifyAuthCode", produces = "application/json;charset=UTF-8" )
//    @ResponseBody
//    public Map<String, Object> verifyAuthCode(@RequestBody Map<String, String> param, HttpSession session) {
//        Map<String, Object> verifyResult = new HashMap<>();
//        String inputCode = param.get("inputCode");
//        System.out.println("inputCode: " + inputCode);
//        String authCode = (String)session.getAttribute("authCode");
//        System.out.println("authCode: " + authCode);
//
//      if(authCode!=null && authCode.equals(inputCode)) {
//           verifyResult.put("checkAuthCode", true);
//       } else {
//            verifyResult.put("checkAuthCode", false);
//        }
//        return verifyResult;
//    }
//
//}
