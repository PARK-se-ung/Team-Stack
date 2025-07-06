<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
            <th>결제번호</th>
            <th>강의명</th>
            <th>구매자명</th>
            <th>결제일</th>
            <th>금액</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${not empty sales}">
            <c:forEach var="s" items="${sales}">
                <tr>
                    <td>${s.paymentId}</td>
                    <td>${s.courseTitle}</td>
                    <td>${s.userName}</td>
                    <td style="text-align: center;">
                        <fmt:formatDate value="${s.paymentDate}" pattern="yyyy-MM-dd"/><br>
                        <fmt:formatDate value="${s.paymentDate}" pattern="HH:mm:ss"/>
                    </td>
                    <td>${s.paymentPrice}</td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty sales}">
            <tr>
                <td colspan="5" style="text-align: center;">판매 내역이 없습니다</td>
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
