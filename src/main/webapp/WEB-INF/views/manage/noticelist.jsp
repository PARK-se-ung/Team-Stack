<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/manage.css">
<section class="main-container">
  <h2>공지 사항</h2>
  <div id="notice-container" class="me-3">
    <table>
      <thead>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성일</th>
      </tr>
      </thead>
      <tbody>
      <c:if var="noticeFlag" test="${empty notices}">
        <td colspan="5" class="text-center"> 조회된 결과가 없습니다.</td>
      </c:if>
      <c:if test="${!noticeFlag}">
        <c:forEach var="notice" items="${notices}">
          <tr>
            <td>${notice.noticeNo}</td>
            <td>
              <a class="text-decoration-none" href="${pageContext.request.contextPath}/home/noticelocal?noticeNo=${notice.noticeNo}">
                  ${notice.noticeTitle}
              </a>
            </td>
            <td><fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
          </tr>
        </c:forEach>
      </c:if>
      </tbody>
    </table>
  </div>
  <br>
  <div class="pageBar-container">
    ${pageBar}
  </div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
