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
          <td><a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${b.courseNo}">${r.courseTitle}</a></td>
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
                <c:when test="${r.applyType == 'RESERVE'}">
                  <button class="btn-reserveRefund"
                          data-course-no="${r.courseNo}"
                    >예약취소
                  </button>
              </c:when>
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

  //예약 바로 취소 기능
  $(document).off('click','.btn-reserveRefund').on('click', '.btn-reserveRefund', async function(e){
    if(!confirm('예약 취소 하시겠습니까?')) return;
    const courseNo = $(e.target).data('course-no');
    const userId = "${loginUser.userId}";
    console.log(userId);
    const impUidResponse = await fetch('${pageContext.request.contextPath}/payment/getImpUid?courseNo='+courseNo+'&userId='+userId);
    const impUid = await impUidResponse.text();
    $.ajax({
      url:"${pageContext.request.contextPath}/payment/cancelPayment2",
      type:"POST",
      contentType:"application/json",
      data:JSON.stringify({
        "imp_uid": impUid,
        "reason": "사용자 요청 환불",
        "userId":userId,
        "courseNo":courseNo
      }),
      dataType:"text",
      success: function(result) {
        if(result === "success") {
          alert("환불이 정상적으로 처리되었습니다.");
          tabLoad('reserve'); // 페이지 새로고침
        } else {
          alert("환불 처리에 실패했습니다.");
          tabLoad('reserve');
        }
      },
      error: function() {
        alert("서버 오류로 환불 요청에 실패했습니다.");
        tabLoad('reserve');
      }
    });
  });

</script>