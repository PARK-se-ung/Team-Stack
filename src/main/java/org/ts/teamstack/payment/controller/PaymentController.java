package org.ts.teamstack.payment.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.ts.teamstack.course.service.CourseService;
import org.ts.teamstack.payment.model.dto.*;
import org.ts.teamstack.payment.model.service.PaymentService;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.UUID;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/payment")
public class PaymentController {

    private final ObjectMapper objectMapper;
    private final PaymentService service;
    private final CourseService courseService;

    //response
    @RequestMapping("/insertPayment")
    @ResponseBody
    public String insertPayment(@RequestBody PaymentRequest request) throws JsonProcessingException {

        String iamportAccessToken = getIamportAccessToken();
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        headers.setBearerAuth(iamportAccessToken);

        String url = "https://api.iamport.kr/payments/prepare/"+request.getPaymentId();//결제예정금액조회

        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<PaymentVerifyResponse> response = restTemplate.exchange(url, HttpMethod.GET , entity, PaymentVerifyResponse.class);
        //getForEntity는 헤더설정이 따로 없음

        //request는 결제 요청(완료)한 가격 & response는 토큰과 PK값을 보내서 가져온 결제예정금액
        if(request.getPaymentPrice()!=response.getBody().getResponse().getAmount()){

            paymentCancel(request.getPortoneId(), iamportAccessToken,"금액이 달라요");
            log.info(request.getPaymentId()+"이게 요청하고있는 주문번호야 ");
            log.error("가격이 맞지 않아 너가 요청한 금액은 :"+ request.getPaymentPrice()+" / DB에 있는 가격 : "+ response.getBody().getResponse().getAmount());

            return "fail";
        }

        Payment payment = Payment.builder()
                .paymentId(request.getPaymentId())
                .userId(request.getUserId())
                .paymentPrice(request.getPaymentPrice())
                .portoneId(request.getPortoneId())
                .paymentDate(new Timestamp(request.getPaymentDate() * 1000))
                .courseNo(request.getCourseNo())
                .build();
        int result = service.insertPayment(payment);

        if(result > 0) {
            //성공
            return "success";
        }else{
            return "fail";
        }

    }

    private void paymentCancel(String portoneId,String token,String reason) throws JsonProcessingException {

        PaymentCancelRequest paymentCancelRequest = new PaymentCancelRequest(portoneId,reason);

        String url= "https://api.iamport.kr/payments/cancel/";
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        headers.setBearerAuth(token);

        String bodyJson = objectMapper.writeValueAsString(paymentCancelRequest);
        HttpEntity<String> entity = new HttpEntity<>(bodyJson, headers);
        ResponseEntity<PaymentCancelResponse> cancelResponse =  restTemplate.postForEntity(url, entity, PaymentCancelResponse.class);
//
//        log.info(cancelResponse.getStatusCode()+"이건 취소에 대한 결과야");
//        if(!cancelResponse.getStatusCode().is2xxSuccessful()){
//            log.error("Payment cancel failed = 401인가가 뜨면 이게 나올거야"+cancelResponse.getStatusCode().getReasonPhrase());
//        }

        PaymentCancelResponse responseBody = cancelResponse.getBody();
        if (!cancelResponse.getStatusCode().is2xxSuccessful() || responseBody == null || responseBody.getCode() != 0) {
            String errorMsg = (responseBody != null) ? responseBody.getMessage() : "응답 body 없음";
            log.error("Payment cancel failed: code=" + (responseBody != null ? responseBody.getCode() : "null") + ", message=" + errorMsg);
            throw new IllegalStateException("결제 취소 실패: " + errorMsg);
        }
    }

    @GetMapping("generatePaymentPk")
    @ResponseBody
    public String generatePaymentPk(@RequestParam int courseNo) throws JsonProcessingException {
        String merchantUid;
        int amount = courseService.getCoursePrice(courseNo); // 강의 가격 조회

        do {
            String uuid = UUID.randomUUID().toString();
            Calendar baseCalendar = Calendar.getInstance();
            baseCalendar.set(2025, Calendar.JANUARY, 1, 0, 0, 0);
            baseCalendar.set(Calendar.MILLISECOND, 0);
            long baseTime = baseCalendar.getTimeInMillis();
            long currentTime = System.currentTimeMillis();
            long ms = currentTime - baseTime;
            merchantUid = uuid + ms;

        } while (service.existsByPaymentId(merchantUid));

        log.info("방금 생성한 따끈따끈한 주문번호"+merchantUid);

        String token = getIamportAccessToken();
        //토큰 생성했고
        String url = "https://api.iamport.kr/payments/prepare";//결제사전등록 API주소

        //결제금액 검증하는 요청
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();

        headers.setContentType(MediaType.APPLICATION_JSON);

        //Authorization 헤더에 토큰에 Bearer붙여서 값 넣어줌
        headers.setBearerAuth(token);

        // Jackson ObjectMapper로 요청 바디 생성

        PaymentPrepareRequest paymentPrepareRequest = new PaymentPrepareRequest(merchantUid,amount);

        String bodyJson = objectMapper.writeValueAsString(paymentPrepareRequest);

        HttpEntity<String> entity = new HttpEntity<>(bodyJson, headers);
        ResponseEntity<PaymentPrepareResponse> response = restTemplate.postForEntity(url, entity, PaymentPrepareResponse.class);

        if(!response.getStatusCode().is2xxSuccessful()) {
            //응답이 200이 오지 않는다면
            if(response.getStatusCode()== HttpStatus.UNAUTHORIZED) {
                throw new IllegalArgumentException("Invalid token");
                //유효하지않은 토큰일 경우, 만료됐거나 그러면 차단
            }
            throw new IllegalArgumentException();
        }
        log.info("DB에 저장된 가격이야 "+response.getBody().getResponse().getAmount());
        return merchantUid;
    }


    private String getIamportAccessToken() throws JsonProcessingException {

        //토큰을 받는 요청

        String apiKey = "4642570142138528";
        String apiSecret = "S7TYhNw5W3okzZBCzgKSa28A4V29qB0TBQm5DbiqGdu8YeAkWiqy9iwSpu9cCZTWrVlyIyQ9k0R95bRc";
        String url = "https://api.iamport.kr/users/getToken";

        //RestAPI 요청을 다른 서버에 보낼때 쓰는 방법
        //동기방식으로 쓰는게 RestTemplate
        RestTemplate restTemplate = new RestTemplate();
        //요청을 보낼때 헤더에 무엇을 담을지 설정하는 객체
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        //Body를 JSON으로 보낼거다라는 정보를 헤더에 담았다

        //ObjectMapper가 객체를 JSON형식으로 바꾸기 좋아 양방향도 돼

        PortOneTokenRequest portOneTokenRequest = new PortOneTokenRequest(apiKey, apiSecret);

        String bodyJson = objectMapper.writeValueAsString(portOneTokenRequest);
        //얘는 dto객체를 JSON형태로 바꿔줌

        HttpEntity<String> entity = new HttpEntity<>(bodyJson, headers);
        //바디와 헤더를 담아서 요청정보를 생성

        ResponseEntity<PortOneTokenResponse> response = restTemplate.postForEntity(url, entity, PortOneTokenResponse.class);
        //요청에 대한 응답에 있는 엑세스 토큰을 가져와서 리턴
        PortOneTokenResponse.TokenData data = response.getBody().getResponse();
        log.info(data.getAccess_token()+"이건 토큰이야");
        return data.getAccess_token();

    }

}
