<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>

<div class="navs">
    <div class="nav-item active" data-nav="purchase">강의 구매 내역</div>
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
                <option value="결제완료">결제완료</option>
                <option value="환불신청중">환불신청중</option>
                <option value="환불완료">환불완료</option>
                <option value="OR">OR</option>
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
            <th>결제번호</th>
            <th>강의명</th>
            <th>강사명</th>
            <th>결제일</th>
            <th>금액</th>
            <th>결제ID</th>
        </tr>
        </thead>
        <c:forEach var="pay" items="${paymentList}">
            <tr>
                <td>${pay.paymentNo}</td>
                <td>${pay.courseTitle}</td>
                <td>${pay.instructorName}</td>
                <td>${pay.paymentDate}</td>
                <td>${pay.paymentPrice}</td>
                <td>${pay.portoneId}</td>
            </tr>
        </c:forEach>

        <!-- 생략된 나머지 항목들도 같은 형식으로 추가 -->
        </tbody>
    </table>

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

