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
            // 해당하는 번호의 채팅방이 없으면 만들기
            chatRoomSessions.get(courseNo).add(session);
            // 해당하는 번호채팅방에 사용자가 집어넣기
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 매개변수에 있는 session 메시지를 입력한 나의 Session
        Map<String, Object> sendUserMsg = objectMapper.readValue(message.getPayload(), Map.class);
        // JSON 형태로 넘겨주기 때문에 이것을 Parsing 해준다.
        String userId = (String) sendUserMsg.get("userId");
        String chatMsg = (String) sendUserMsg.get("chatMsg");
        int courseNo = (Integer) sendUserMsg.get("courseNo");
        Timestamp chatTime = new Timestamp(System.currentTimeMillis());
        Chat chat = new Chat().builder()
                .userId(userId)
                .chatMsg(chatMsg)
                .courseNo(courseNo)
                .chatTime(chatTime)
                .build();

        int saveResult = service.setChattingHistory(chat);

        List<WebSocketSession> sessions = chatRoomSessions.get(courseNo);
        // 강의 번호에 해당하는 모든 세션(참여자 리스트) 가져옴
        if(sessions != null){
            for (WebSocketSession msg : sessions) {
                if(msg.isOpen()){
                    // TCP 소켓을 통해 전달 닫혀있다면 IllegalStateException 발생
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
                // 이건 나의 세션을 없애는 로직 -
            }
            if(sessions.isEmpty()){
                chatRoomSessions.remove(courseNo);
                // 이건 방 전체의 세션을 없애는 것 메모리 누수 방지 + 리소스 정리
            }
        }
    }
}