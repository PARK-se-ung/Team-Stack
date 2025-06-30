<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/classes.css">
<div class="class-week-box">
  <div class="class-box-title">
    <i class="bi bi-list-check fs-2"></i>
    주차학습
  </div>
  <c:forEach var="w" items="${week}">
    <div class="class-week-item">
      <div class="class-week-week witem">
        <h5>${w.scheduleWeek}주차</h5>
      </div>
      <div class="class-week-file">
        <c:if test="${not empty w.scheduleOriname}">
          <a href="${pageContext.request.contextPath}/resources/upload/${w.scheduleRename}"
             download="${w.scheduleOriname}"
             class="btn pdf-down witem">
            <i class="bi bi-download"></i>
            강의파일 다운로드
          </a>
        </c:if>
      </div>
      <div class="class-week-assign">
        <c:if test="${not empty w.assignOriname}">
          <a href="${pageContext.request.contextPath}/resources/upload/${w.assignRename}"
             download="${w.assignOriname}"
             class="btn pdf-down witem">
            <i class="bi bi-download"></i>
            과제파일 다운로드
          </a>
        </c:if>
      </div>
    </div>
  </c:forEach>

</div>