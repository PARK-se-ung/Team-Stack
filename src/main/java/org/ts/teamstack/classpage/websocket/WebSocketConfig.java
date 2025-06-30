package org.ts.teamstack.classpage.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import java.util.Map;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Autowired
    private ChattingServer chattingServer;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {

        // /chat 으로 들어오는 요청을 모두 ChattingServer 클래스가 처리하도록 지정
        registry.addHandler(chattingServer,"/chat")
                .addInterceptors(new HttpSessionHandshakeInterceptor() {
                    // WebSocket 연결과정 중 HandShake 단계에서 세션정보를 확인하여 필요한 정보를 확인하여 저장할때 사용
                    //  -> 로그인만 사용자만 사용한다던가, 강좌를 수강한 사람만 채팅하는 것을 위해서 사용
                    @Override
                    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                                   WebSocketHandler wsHandler, Map<String, Object> attributes)
                            throws Exception {
                        if (request instanceof ServletServerHttpRequest req) {
                            // ServerHttpRequest는 추상 타입(인터페이스)이기 때문에,
                            // 실제 객체가 어떤 구현 클래스인지 확인하고 써야 하기 때문 (다운 캐스팅을 해줘야지 getParameter 같은 것이 사용 가능)
                            String courseNo = req.getServletRequest().getParameter("courseNo");
                            if (courseNo != null) {
                                attributes.put("courseNo", Integer.valueOf(courseNo));
                            }
                        }
                        return true;
                    }
                })
                .setAllowedOrigins("*");
    }
}