//package org.ts.teamstack.user.service;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.mail.javamail.JavaMailSender;
//import org.springframework.mail.javamail.JavaMailSenderImpl;
//import org.springframework.mail.javamail.MimeMessageHelper;
//import org.springframework.scheduling.annotation.Async;
//import org.springframework.stereotype.Component;
//import org.springframework.stereotype.Service;
//
//import javax.mail.MessagingException;
//import javax.mail.internet.MimeMessage;
//import java.io.UnsupportedEncodingException;
//
//@Component
//public class MailService {
//    @Autowired
//    private JavaMailSenderImpl mailSender;
//    private int authNum;
//
//   public void createRandomAuthNumber(){
//       int random = (int)(Math.random()*1000000);
//       authNum = random;
//       System.out.printf("%06d\n",authNum);
//   }
//
//   public String joinEmail(String email){
//       createRandomAuthNumber();
//       String form = "testteamstack@gmail.com";
//       String receiver = email;
//       String title ="000 사이트 이메일 인증 번호 입니다.";
//       String content =
//               "홈페이지를 방문해주셔서 감사합니다." +
//               "<br><br>" + "인증 번호는 " +String.format("%06d",authNum) + "입니다." +
//               "<br>" + "인증번호를 인증번호 확인란에 입력해주세요";
//       mailSend(form,receiver,title,content);
//       System.out.println("이거 리턴하는 거야" + String.format("%06d",authNum));
//       return String.format("%06d",authNum);
//   }
//   public void mailSend(String form,String receiver,String title,String content){
//       try {
//           MimeMessage message = mailSender.createMimeMessage();
//           MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
//           helper.setFrom(form, "오프라인강의"); // 이름 포함
//           helper.setTo(receiver);
//           helper.setSubject(title);
//           helper.setText(content, true);
//           mailSender.send(message);
//       } catch (MessagingException | UnsupportedEncodingException e) {
//           e.printStackTrace();
//       }
//   }
//
//}
//
