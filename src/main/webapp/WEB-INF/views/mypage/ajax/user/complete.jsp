<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css">

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
    <c:if test="${not empty complete}">
      <c:forEach var="c" items="${complete}">
        <tr>
          <td><a href="">${c.courseTitle}</a></td>
          <td>${c.instructorName}</td>
          <td>
            <c:choose>
              <c:when test="${c.gradeType == 'E'}">초등</c:when>
              <c:when test="${c.gradeType == 'M'}">중등</c:when>
              <c:when test="${c.gradeType == 'H'}">고등</c:when>
              <c:otherwise>기타</c:otherwise>
            </c:choose>
          </td>
          <td>${c.subject}</td>
          <td>${c.region}</td>
          <td>${c.totalWeek}</td>
          <td><fmt:formatDate value="${c.courseStartDate}" pattern="yyyy-MM-dd"/></td>
          <td><fmt:formatNumber value="${c.coursePrice}" type="number"/>원</td>
          <td><button class="btn-download">다운로드</button>
        </tr>
      </c:forEach>
    </c:if>
    <c:if test="${empty complete}">
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

