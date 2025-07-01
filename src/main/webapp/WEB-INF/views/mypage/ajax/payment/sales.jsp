<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
    <div class="nav-item active" data-nav="sales">강의 판매 내역</div>
    <div class="nav-item" data-nav="refund">환불 신청 조회</div>

</div>
<!-- 결제 관리 탭 -->
<div class="current-container">
    <!-- 검색/필터 영역 -->
    <div class="search-bar">
        <form method="get" action="" class="search-form">
            <input type="date" name="startDate" value="">
            <input type="date" name="endDate" value="">
            <select name="status">
                <option value="">전체</option>
                <option value="강사명">강사명</option>
                <option value="강의명">강의명</option>
            </select>
            <input type="text" name="lectureTitle" placeholder="강의명or강사명" value="">
            <button type="submit">검색</button>
        </form>
    </div>

    <table class="payment-table">
        <thead>
        <tr>
            <th>결제일</th>
            <th>강의명</th>
            <th>구매자명</th>
            <th>금액</th>
            <th>상태</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${not empty sales}">
            <c:forEach var="s" items="${sales}">
                <tr>
                    <td>${s.paymentDate}</td>
                    <td>${s.courseTitle}</td>
                    <td>${s.userName}</td>
                    <td>${s.paymentPrice}</td>
                    <td>
                        <c:choose>
                            <c:when test="${s.refundStatus == 'S'}">환불 승인 대기</c:when>
                            <c:when test="${s.refundStatus == 'A'}">환불 승인</c:when>
                            <c:when test="${s.refundStatus == 'D'}">환불 반려</c:when>
                            <c:when test="${empty s.refundStatus}">신청완료</c:when>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        <!-- 생략된 나머지 항목들도 같은 형식으로 추가 -->
        </tbody>
        <c:if test="${empty sales}">
            <tr>
                결제한게 없네용!ㅋㅋ
            </tr>
        </c:if>
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
