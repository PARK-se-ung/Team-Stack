package org.ts.teamstack.classpage.websocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.ts.teamstack.classpage.model.dto.Chat;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

@Slf4j
public class ChattingServer extends TextWebSocketHandler {

    private final List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
    private final ObjectMapper objectMapper = new ObjectMapper();  // JSON 처리용

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        log.debug("클라이언트 접속: {}", session.getId());
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        try {
            String messageText = message.getPayload();
            Map<String, Object> messageData = objectMapper.readValue(messageText, Map.class);

            String userId = (String) messageData.get("userId");
            String chatMsg = (String) messageData.get("message");
            Integer courseNo = (Integer) messageData.get("courseNo");

            Chat chat = new Chat();
            chat.setCourseNo(courseNo);
            chat.setUserId(userId);
            chat.setChatMsg(chatMsg);

//            service.saveChatMessage(chat);  // DB 저장

            // 2. 실시간 브로드캐스트
            String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            Map<String, Object> response = Map.of(
                    "userId", userId,
                    "message", chatMsg,
                    "chatTime", currentTime,
                    "courseNo", courseNo
            );

            String responseJson = objectMapper.writeValueAsString(response);

            for (WebSocketSession s : sessions) {
                if (s.isOpen()) {
                    s.sendMessage(new TextMessage(responseJson));
                }
            }

        } catch (Exception e) {
            log.error("메시지 처리 중 오류:", e);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        log.debug("클라이언트 연결 종료: {}", session.getId());
    }
}