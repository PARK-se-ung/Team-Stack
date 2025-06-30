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
                <button type="button" class="btn btn-warning" id="send-btn" >전송</button>
            </form>
        </div>
    </div>
</div>

<script>
    <%--const socket = new WebSocket("ws://localhost:8080/teamstack/chat?courseNo=${course.courseNo}");--%>

    <%--const sendMessage =  function () {--%>
    <%--    console.log("✅ [클릭됨] sendMessage 실행됨"); // ⬅ 이거 무조건 넣자--%>

    <%--    const input = document.getElementById("chat-input");--%>
    <%--    const message = input.value.trim();--%>

    <%--    if (message !== "" && socket.readyState == WebSocket.OPEN) {--%>
    <%--        // JSON 형태로 사용자 정보와 메시지를 함께 전송--%>
    <%--        const messageData = {--%>
    <%--            userId: "<%=currentUserId%>",--%>
    <%--            chatMsg: message,--%>
    <%--            courseNo: ${course.courseNo}--%>
    <%--        };--%>

    <%--        socket.send(JSON.stringify(messageData));--%>
    <%--        input.value = "";--%>
    <%--    }--%>
    <%--}--%>

    <%--document.getElementById('send-btn').addEventListener('click', sendMessage);--%>


    <%--// 브라우저 WebSocket 연결을 생성하는 JavaScript 객체--%>

    <%--socket.onmessage = function(event){--%>
    <%--    console.log("sendMessage 함수 호출됨!");--%>
    <%--    // 메시지가 오면 발생--%>
    <%--    const chat = JSON.parse(event.data);--%>
    <%--    const chatBox = document.getElementById('chat-box');--%>
    <%--    const $div = document.createElement('div');--%>
    <%--    $div.classList.add("mb-2");--%>

    <%--    if (chat.userId === "<%=currentUserId%>") {--%>
    <%--        $div.innerHTML =--%>
    <%--            '<div style="text-align: right;">' +--%>
    <%--            '<strong class="text-primary">나</strong>' +--%>
    <%--            '<span class="text-muted" style="font-size: 0.85em;">(' + chat.chatTime + ')</span><br>' +--%>
    <%--            '<span>' + chat.chatMsg + '</span>' +--%>
    <%--            '</div>';--%>
    <%--    } else {--%>
    <%--        $div.innerHTML =--%>
    <%--            '<div>' +--%>
    <%--            '<strong class="text-success">' + chat.userId + '</strong>' +--%>
    <%--            '<span class="text-muted" style="font-size: 0.85em;">(' + chat.chatTime + ')</span><br>' +--%>
    <%--            '<span>' + chat.chatMsg + '</span>' +--%>
    <%--            '</div>';--%>
    <%--    }--%>

    <%--    // 5️⃣ 화면에 메시지 추가--%>
    <%--    chatBox.appendChild($div);--%>
    <%--    chatBox.scrollTop = chatBox.scrollHeight; // 자동 스크롤--%>
    <%--};--%>
    document.addEventListener('DOMContentLoaded', function() {
        const courseNo = ${course.courseNo};
        const currentUserId = ${currentUserId};
        // 메인에서 정의한 함수 호출
        initChattingSocket(courseNo, currentUserId);
    });
</script>
