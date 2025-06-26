<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="class-box">
    <div class="class-box-title">
        <i class="bi bi-megaphone-fill"></i>
        최근 공지
    </div>
    <c:forEach var="hn" items="${homenotice}">
        <div class="class-main-item">
            <span class="home-title">${hn.boardTitle}</span><span class="home-date">${hn.boardDate}</span>
        </div>
    </c:forEach>

</div>

<div class="class-box">
    <div class="class-box-title">
        <i class="bi bi-book"></i>
        최근 과제
    </div>
    <div class="class-main-item">
        <span class="home-title">과제 제목</span><span class="home-date">2025년 12월 31일</span>
    </div>
    <div class="class-main-item">
        <span class="home-title">과제 제목</span><span class="home-date">2025년 12월 31일</span>
    </div>
    <div class="class-main-item">
        <span class="home-title">과제 제목</span><span class="home-date">2025년 12월 31일</span>
    </div>
</div>
