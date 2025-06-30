<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.ts.teamstack.user.model.dto.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Users currentUser = (Users) auth.getPrincipal();
    String currentUserId = currentUser.getUserId();
%>

<div class="container mt-3">
    <div class="card">
        <h2>${course.courseTitle}</h2>
        <div class="card-header bg-warning text-white">
            💬 실시간 채팅
        </div>
        <div class="card-body" id="chat-box" style="height: 1000px; overflow-y: scroll;">
            <c:forEach var="c" items="${chattingHistory}">
                <div class="mb-2">
                    <strong class="text-primary">${c.userId}</strong>
                    <span class="text-muted" style="font-size: 0.85em;">(${c.chatTime})</span><br>
                    <span>${c.chatMsg}</span>
                </div>
                <hr class="my-1"/>
            </c:forEach>
        </div>
        <div class="card-footer">
            <form id="chat-form" class="d-flex">
                <input type="text" class="form-control me-2" id="chat-input" placeholder="메시지를 입력하세요..." />
                <button type="button" class="btn btn-warning" id="send-btn" onclick="sendMessage()">전송</button>
            </form>
        </div>
    </div>
</div>

<script>
    const courseNo = ${course.courseNo};
    const currentUserId = '<%= currentUserId %>';
    const socket = new WebSocket("ws://localhost:8080/chat");

    // 수정된 sendMessage 함수
    function sendMessage() {
        const input = document.getElementById("chat-input");
        const message = input.value.trim();

        if (message !== "" && socket.readyState === WebSocket.OPEN) {
            // JSON 형태로 사용자 정보와 메시지를 함께 전송
            const messageData = {
                userId: currentUserId,
                message: message,
                courseNo: courseNo
            };

            socket.send(JSON.stringify(messageData));
            input.value = "";
        }
    }
</script>
