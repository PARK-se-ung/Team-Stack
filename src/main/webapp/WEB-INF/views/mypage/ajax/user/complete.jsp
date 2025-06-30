<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2025-06-23
  Time: 오후 1:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>

<div class="navs">
  <div class="nav-item" data-nav="bookmark">북마크한 강의</div>
  <div class="nav-item" data-nav="reserve">예약한 강의</div>
  <div class="nav-item" data-nav="apply">신청한 강의</div>
  <div class="nav-item" data-nav="take">수강중인 강의</div>
  <div class="nav-item active" data-nav="complete">수강완료한 강의</div>
</div>

<div class="current-container">

  <div class="search-bar">
    <form method="get" action="" class="search-form">
      <select name="status">
        <option value="">전체</option>
        <option value="강사명">강사명</option>
        <option value="강의명">강의명</option>
      </select>
      <input type="text" name="lectureTitle" placeholder="" value="">
      <button type="submit">검색</button>
    </form>
  </div>

  <div class="view-toggle">
    <strong><a>이미지형</a></strong> | <a>리스트형</a>
  </div>

  <table>
    <thead>
    <tr>
      <th>강의명</th>
      <th>강사명</th>
      <th>학년</th>
      <th>과목</th>
      <th>지역</th>
      <th>주차</th>
      <th>강의 시작일</th>
      <th>금액</th>
      <th>수료증</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${not empty apply}">
      <c:forEach var="a" items="${apply}">
        <tr>
          <td><a href="">${a.courseTitle}</a></td>
          <td>${a.instructorName}</td>
          <td>
            <c:choose>
              <c:when test="${a.gradeType == 'E'}">초등</c:when>
              <c:when test="${a.gradeType == 'M'}">중등</c:when>
              <c:when test="${a.gradeType == 'H'}">고등</c:when>
              <c:otherwise>기타</c:otherwise>
            </c:choose>
          </td>
          <td>${a.subject}</td>
          <td>${a.region}</td>
          <td>${a.totalWeek}</td>
          <td><fmt:formatDate value="${a.courseStartDate}" pattern="yyyy-MM-dd"/></td>
          <td><fmt:formatNumber value="${a.coursePrice}" type="number"/>원</td>
          <td><button class="btn-manage">다운로드</button>
        </tr>
      </c:forEach>
    </c:if>
    <c:if test="${empty apply}">
      <tr>
        <td colspan="9" style="text-align: center;">신청한 강의가 없습니다!</td>
      </tr>
    </c:if>
    </tbody>
  </table>

  <div id="pageBar">
    ${pageBar}
  </div>
</div>

<style>

  .current-container {
    margin: 40px auto;
    background: #fff;
    border-radius: 20px;
    padding: 30px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
  }

  thead {
    background: #f5f5f5;
  }

  th, td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    vertical-align: top;
  }

  tr:hover {
    background-color: #fafafa;
  }
  .view-toggle {
    margin-top: 10px;
  }
  .btn-manage {
    padding: 4px 10px;
    font-size: 13px;
    background: #f44336;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    min-width: 70px;
    max-width: 90px;
    white-space: nowrap;
  }
  .search-bar {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 16px;
  }
  .search-form {
    display: flex;
    gap: 8px;
    align-items: center;
  }
  .search-form input[type="date"],
  .search-form select,
  .search-form input[type="text"] {
    padding: 4px 8px;
    font-size: 13px;
  }
  .search-form button {
    padding: 4px 14px;
    font-size: 13px;
    background: #455ba8;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
</style>


<!-- nav 전환 로직 -->
<script>
  $(".nav-item").on('click', function() {
    let $current = $(this);
    let tabId = $current.data('nav');
    $(".nav-item").removeClass("active");
    $current.addClass("active");
    tabLoad(tabId);
  });

</script>

