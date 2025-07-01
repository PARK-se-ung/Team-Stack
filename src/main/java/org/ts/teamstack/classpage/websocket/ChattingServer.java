package org.ts.teamstack.classpage.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.ts.teamstack.classpage.model.dto.Chat;
import org.ts.teamstack.classpage.model.service.ClassPageService1;
import org.ts.teamstack.classpage.model.service.ClassPageServiceImpl1;
import org.ts.teamstack.course.model.dto.Course;

import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

@Slf4j
@Component
public class ChattingServer extends TextWebSocketHandler {
    @Autowired
    private ClassPageServiceImpl1 service;
    // 현재 접속한 사용자들을 저장할 곳
    // 강의 번호마다 접속한 사람들을 담아야 하기 때문에 강의 번호(int),   접속한 사람(WebSocketSession) -> 사람들(List)
    private final Map<Integer, List<WebSocketSession>> chatRoomSessions = new ConcurrentHashMap<>();
    private final ObjectMapper objectMapper = new ObjectMapper();  // JSON 처리용

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {


        Integer courseNo = (Integer)session.getAttributes().get("courseNo");
        // WebSocket의 경우에는 request. 으로 가져올 수 없기 때문에 beforeHandShake 단계에서 courseNo를 저장 시켜서 넘겨주어야함

        if (courseNo != null) {
            chatRoomSessions.putIfAbsent(courseNo, new ArrayList<>());
            // courseNo가 없으면 새로운 방을 만든다.
            chatRoomSessions.get(courseNo).add(session);
            log.info("[접속] 강의 {} - 세션 ID: {}", courseNo, session.getId());
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 매개변수에 있는 session 메시지를 입력한 나의 Session
        Map<String, Object> sendUserMsg = objectMapper.readValue(message.getPayload(), Map.class);
        // JSON 형태로 넘겨주기 때문에 이것을 Parsing 해준다.
        System.out.println(sendUserMsg);
        String userId = (String) sendUserMsg.get("userId");
        System.out.println(userId);
        String chatMsg = (String) sendUserMsg.get("chatMsg");
        System.out.println(chatMsg);
        int courseNo = (Integer) sendUserMsg.get("courseNo");
        System.out.println(courseNo);
        Timestamp chatTime = new Timestamp(System.currentTimeMillis());

        // 파싱한 값 들을 가지고와서 저장
        Chat chat = new Chat().builder()
                .userId(userId)
                .chatMsg(chatMsg)
                .courseNo(courseNo)
                .chatTime(chatTime)
                .build();

        int saveResult = service.setChattingHistory(chat);

        List<WebSocketSession> sessions = chatRoomSessions.get(courseNo);
        if(sessions != null){
            for (WebSocketSession msg : sessions) {
                if(msg.isOpen()){
                    // 이걸 해주지 않으면 exception 발생
                    String jsonMsg = objectMapper.writeValueAsString(chat);
                    msg.sendMessage(new TextMessage(jsonMsg));
                }
            }
        }

    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        Integer courseNo = (Integer) session.getAttributes().get("courseNo");
        if(courseNo != null){
            List<WebSocketSession> sessions = chatRoomSessions.get(courseNo);
            if(sessions != null){
                sessions.remove(session);
                // 이건 나의 세션을 없애는 로직
                log.info("[연결 종료] 강의 {} - 세션 ID: {}", courseNo, session.getId());

            }
            if(sessions.isEmpty()){
                chatRoomSessions.remove(courseNo);
                // 이건 방 전체의 세션을 없애는 것
                log.info("[강의방 삭제] 강의 {}: 남은 인원 없음 → 방 삭제", courseNo);

            }
        }
    }
}