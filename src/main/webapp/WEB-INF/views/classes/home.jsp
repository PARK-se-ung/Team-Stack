<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="class-home-box">
    <div class="class-box-title">
        <i class="bi bi-megaphone-fill"></i>
        최근 공지
    </div>
    <c:choose>
        <c:when test="${not empty homenotice}">
            <c:forEach var="hn" items="${homenotice}">
                <div class="class-main-item">
                    <span class="home-title">${hn.boardTitle}</span>
                    <span class="home-date">${hn.boardDate}</span>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="class-main-item">
                <span class="home-title">등록된 공지가 없습니다.</span>
                <span class="home-date"></span>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<div class="class-home-box">
    <div class="class-box-title">
        <i class="bi bi-book"></i>
        최근 과제
    </div>
    <c:choose>
        <c:when test="${not empty homeassign}">
            <c:forEach var="an" items="${homeassign}">
                <div class="class-main-item">
                    <span class="home-title">${an.assignTitle}</span>
                    <span class="home-date">${an.scheduleNo}주차</span>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="class-main-item">
                <span class="home-title">등록된 과제가 없습니다.</span>
                <span class="home-date"></span>
            </div>
        </c:otherwise>
    </c:choose>
</div>
