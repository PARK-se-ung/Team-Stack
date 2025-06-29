<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
                <button type="button" class="btn btn-warning" id="send-btn">전송</button>
            </form>
        </div>
    </div>
</div>

<script>

</script>
