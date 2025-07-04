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

<style>
    .chat-container {
        height: 90vh;
        max-width: 100%;
        margin: 0 auto;
        padding: 0;
    }

    .chat-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        border-radius: 24px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.2);
        height: 100%;
        display: flex;
        flex-direction: column;
        overflow: hidden;
    }

    .chat-header {
        background: linear-gradient(135deg, #ff7d4d 0%, #ff6b35 100%);
        padding: 24px 32px;
        color: white;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        position: relative;
        overflow: hidden;
    }

    .chat-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="20" cy="20" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="80" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="40" cy="60" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
        opacity: 0.3;
    }

    .chat-title {
        font-size: 24px;
        font-weight: 700;
        margin: 0 0 8px 0;
        position: relative;
        z-index: 1;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .chat-subtitle {
        font-size: 16px;
        opacity: 0.9;
        margin: 0;
        position: relative;
        z-index: 1;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .status-indicator {
        width: 8px;
        height: 8px;
        background: #4ade80;
        border-radius: 50%;
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.5; }
    }

    .chat-body {
        flex: 1;
        padding: 24px;
        overflow-y: auto;
        background: linear-gradient(180deg, #fafafa 0%, #f5f5f5 100%);
        position: relative;
    }

    .chat-body::-webkit-scrollbar {
        width: 8px;
    }

    .chat-body::-webkit-scrollbar-track {
        background: rgba(0, 0, 0, 0.05);
        border-radius: 4px;
    }

    .chat-body::-webkit-scrollbar-thumb {
        background: rgba(255, 107, 53, 0.3);
        border-radius: 4px;
    }

    .chat-body::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 107, 53, 0.5);
    }

    .chat-message {
        margin-bottom: 16px;
        animation: fadeInUp 0.3s ease;
    }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .message-bubble {
        background: white;
        padding: 16px 20px;
        border-radius: 16px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        border: 1px solid rgba(0, 0, 0, 0.05);
        position: relative;
        max-width: 80%;
    }

    .message-bubble.own-message {
        background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%);
        color: white;
        margin-left: auto;
        text-align: right;
    }

    .message-bubble.own-message::before {
        content: '';
        position: absolute;
        top: 12px;
        right: -8px;
        width: 0;
        height: 0;
        border-left: 8px solid #ff6b35;
        border-top: 8px solid transparent;
        border-bottom: 8px solid transparent;
    }

    .message-bubble:not(.own-message)::before {
        content: '';
        position: absolute;
        top: 12px;
        left: -8px;
        width: 0;
        height: 0;
        border-right: 8px solid white;
        border-top: 8px solid transparent;
        border-bottom: 8px solid transparent;
    }

    .message-header {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 8px;
    }

    .message-author {
        font-weight: 600;
        font-size: 14px;
    }

    .own-message .message-author {
        color: rgba(255, 255, 255, 0.9);
    }

    .message-author:not(.own-message .message-author) {
        color: #ff6b35;
    }

    .message-time {
        font-size: 12px;
        opacity: 0.7;
    }

    .message-content {
        font-size: 15px;
        line-height: 1.4;
        word-wrap: break-word;
    }

    .message-divider {
        height: 1px;
        background: linear-gradient(90deg, transparent, rgba(255, 107, 53, 0.2), transparent);
        margin: 8px 0;
        border: none;
    }

    .chat-footer {
        padding: 20px 24px;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-top: 1px solid rgba(0, 0, 0, 0.05);
    }

    .chat-form {
        display: flex;
        gap: 12px;
        align-items: center;
    }

    .chat-input {
        flex: 1;
        padding: 12px 16px;
        border: 2px solid rgba(255, 107, 53, 0.2);
        border-radius: 12px;
        font-size: 14px;
        transition: all 0.3s ease;
        background: white;
    }

    .chat-input:focus {
        outline: none;
        border-color: #ff6b35;
        box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1);
    }

    .chat-input::placeholder {
        color: #94a3b8;
    }

    .send-button {
        background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%);
        color: white;
        border: none;
        padding: 12px 20px;
        border-radius: 12px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
        box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
    }

    .send-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(255, 107, 53, 0.4);
    }

    .send-button:active {
        transform: translateY(0);
    }

    /* 빈 채팅 상태 */
    .empty-chat {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100%;
        color: #64748b;
        text-align: center;
    }

    .empty-chat-icon {
        font-size: 48px;
        color: #cbd5e1;
        margin-bottom: 16px;
    }

    .empty-chat-title {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 8px;
        color: #475569;
    }

    .empty-chat-description {
        font-size: 14px;
        opacity: 0.8;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .chat-header {
            padding: 20px;
        }

        .chat-title {
            font-size: 20px;
        }

        .chat-body {
            padding: 16px;
        }

        .message-bubble {
            max-width: 90%;
            padding: 12px 16px;
        }

        .chat-footer {
            padding: 16px;
        }

        .chat-form {
            gap: 8px;
        }

        .send-button {
            padding: 12px 16px;
        }
    }
</style>

<div class="chat-container">
    <div class="chat-card">
        <div class="chat-header">
            <h2 class="chat-title">
                <i class="bi bi-chat-dots"></i>
                ${course.courseTitle}
            </h2>
            <div class="chat-subtitle">
                <span class="status-indicator"></span>
                실시간 채팅
            </div>
        </div>

        <div class="chat-body" id="chat-box">
            <c:choose>
                <c:when test="${not empty chattingHistory}">
                    <c:forEach var="c" items="${chattingHistory}">
                        <div class="chat-message">
                            <div class="message-bubble ${c.userId eq currentUserId ? 'own-message' : ''}">
                                <div class="message-header">
                                    <span class="message-author">
                                            ${c.userId eq currentUserId ? '나' : c.userId}
                                    </span>
                                    <span class="message-time">${c.chatTime}</span>
                                </div>
                                <div class="message-content">${c.chatMsg}</div>
                            </div>
                        </div>
                        <hr class="message-divider"/>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-chat">
                        <div class="empty-chat-icon">
                            <i class="bi bi-chat-square-dots"></i>
                        </div>
                        <h3 class="empty-chat-title">아직 대화가 없습니다</h3>
                        <p class="empty-chat-description">첫 번째 메시지를 보내서 대화를 시작해보세요!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="chat-footer">
            <form id="chat-form" class="chat-form">
                <input
                        type="text"
                        class="chat-input"
                        id="chat-input"
                        placeholder="메시지를 입력하세요..."
                />
                <button type="button" class="send-button" id="send-btn">
                    <i class="bi bi-send"></i>
                    전송
                </button>
            </form>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/chatting.js"></script>
<script>
    connectionChatting('<%=currentUserId%>');
</script>