<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
  <div class="nav-item" data-nav="bookmark">북마크한 강의</div>
  <div class="nav-item active" data-nav="reserve">예약한 강의</div>
  <div class="nav-item" data-nav="apply">신청한 강의</div>
  <div class="nav-item" data-nav="take">수강중인 강의</div>
  <div class="nav-item" data-nav="complete">수강완료한 강의</div>
</div>
<!-- 아래 div안에서 필요한 html 코드 작성 -->

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
      <th>모집 시작일</th>
      <th>강의 시작일</th>
      <th>금액</th>
      <th>환불 신청</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${not empty reserve}">
      <c:forEach var="r" items="${reserve}">
        <tr>
          <td>${r.courseTitle}</td>
          <td>${r.instructorName}</td>
          <td>
            <c:choose>
              <c:when test="${r.gradeType == 'E'}">초등</c:when>
              <c:when test="${r.gradeType == 'M'}">중등</c:when>
              <c:when test="${r.gradeType == 'H'}">고등</c:when>
              <c:otherwise>기타</c:otherwise>
            </c:choose>
          </td>
          <td>${r.subject}</td>
          <td>${r.region}</td>
          <td><fmt:formatDate value="${r.recruitDate}" pattern="yyyy-MM-dd"/></td>
          <td><fmt:formatDate value="${r.courseStartDate}" pattern="yyyy-MM-dd"/></td>
          <td><fmt:formatNumber value="${r.coursePrice}" type="number"/>원</td>
          <td>

            <c:choose>

              <c:when test="${empty rf.refundStatus}">
                <c:if test="${rf.applyType == 'RESERVE'}">
                  <button class="btn-reserveRefund"
                          data-course-no="${rf.courseNo}"
                          data-payment-id="${rf.paymentId}">
                    예약취소
                  </button>
                </c:if>
              </c:when>
              <c:otherwise>
                <c:choose>
                  <c:when test="${rf.refundStatus == 'S'}">
                    <span style="color:#888;">취소 승인 대기</span>
                  </c:when>
                  <c:when test="${rf.refundStatus == 'A'}">
                    <span style="color:green;">취소 승인</span>
                  </c:when>
                  <c:when test="${rf.refundStatus == 'D'}">
                    <span style="color:red;">취소 반려</span>
                  </c:when>
                  <c:otherwise>
                    <span style="color:#888;">알 수 없음</span>
                  </c:otherwise>
                </c:choose>
              </c:otherwise>
            </c:choose>

          </td>
        </tr>
      </c:forEach>
    </c:if>
    <c:if test="${empty reserve}">
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