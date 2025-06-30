<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<div class="class-notice-box">
    <div class="class-box-title">
        <i class="bi bi-megaphone-fill"></i>
        공지
    </div>
    <c:forEach var="n" items="${notice}">
        <div class="class-main-item">
            <span class="home-title">${n.boardTitle}</span>
            <span class="home-date">${n.boardDate}</span>
        </div>
    </c:forEach>

</div>