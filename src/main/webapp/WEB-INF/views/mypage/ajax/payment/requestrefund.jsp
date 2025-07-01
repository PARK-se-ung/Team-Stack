<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>

<div class="navs">
    <div class="nav-item" data-nav="purchase">강의 구매 내역</div>
    <div class="nav-item active" data-nav="requestRefund">환불 신청</div>
</div>
<!-- 결제 관리 탭 -->
<div class="current-container">
    <!-- 검색/필터 영역 -->
    <div class="search-bar">
        <form method="get" action="" class="search-form">
            <input type="date" name="startDate" value="">
            <input type="date" name="endDate" value="">
            <select name="status">
                <option value="강사명">강사명</option>
                <option value="강의명">강의명</option>
            </select>
            <input type="text" name="lectureTitle" placeholder="강의명" value="">
            <button type="submit">검색</button>
        </form>
    </div>
    <table class="payment-table">
        <thead>
        <tr>
            <th>강의명</th>
            <th>강사명</th>
            <th>결제일</th>
            <th>금액</th>
            <th>환불 신청</th>

        </tr>
        </thead>
        <tbody>
        <c:if test="${not empty paymentList}">
            <c:forEach var="pay" items="${paymentList}">
                <tr>
                    <td>${pay.courseTitle}</td>
                    <td>${pay.instructorName}</td>
                    <td>${pay.paymentDate}</td>
                    <td>${pay.paymentPrice}</td>
                    <td>  <button class="btn-apply"
                                  data-course-no="${b.courseNo}"
                                  data-course-title="${b.courseTitle}"
                                  data-course-price="${b.coursePrice}">신청</button></td>

                </tr>
            </c:forEach>
        </c:if>
        <!-- 생략된 나머지 항목들도 같은 형식으로 추가 -->
        </tbody>

        <c:if test="${empty paymentList}">
            <tr>
                결제한게 없네용!ㅋㅋ
            </tr>
        </c:if>
    </table>


    <div id="pageBar">
        ${pageBar}
    </div>

</div>

<script>



</script>

<style>
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

    .payment-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
        table-layout: fixed;
    }
    .payment-table th, .payment-table td {
        padding: 10px 8px;
        text-align: left;
        border-bottom: 1px solid #ddd;
        vertical-align: middle;
        word-break: break-all;
    }
    .payment-table th {
        background: #f5f5f5;
    }
    .payment-table tr:hover {
        background-color: #fafafa;
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


