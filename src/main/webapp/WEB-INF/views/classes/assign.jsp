<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<div class="class-notice-box">
  <div class="class-box-title">
    <i class="bi bi-clipboard-check"></i>
    과제
  </div>
  <c:forEach var="w" items="${week}">
    <c:if test="${not empty w.assignOriname}">

      <div class="class-assign-item">
        <div class="class-week-week witem">
          <h5>${w.scheduleWeek}주차</h5>
        </div>
        <a href="${pageContext.request.contextPath}/resources/upload/${w.assignRename}"
           download="${w.assignOriname}"
           class="btn pdf-down witem">
          <i class="bi bi-download"></i>
          과제파일 다운로드
        </a>
      </div>
    </c:if>
  </c:forEach>
</div>
