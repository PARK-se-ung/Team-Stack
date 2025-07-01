<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
    <div class="nav-item" data-nav="sales">강의 판매 내역</div>
    <div class="nav-item active" data-nav="refund">환불 신청 조회</div>
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
            <th style="width: 120px;">결제일</th>
            <th style="width: 200px;">강의명</th>
            <th style="width: 120px;">강사명</th>
            <th style="width: 100px;">금액</th>
            <th style="width: 90px;">관리</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>2025-05-12</td>
            <td>웹 프로그래밍</td>
            <td>홍길동</td>
            <td>50,000원</td>
            <td>
                <button class="btn-manage">승인</button>
                <button class="btn-manage">반려</button>
            </td>
        </tr>
        <tr>
            <td>2025-05-24</td>
            <td>파이썬 마스터하기</td>
            <td>홍길동</td>
            <td>50,000원</td>
            <td>
                <button class="btn-manage">승인</button>
                <button class="btn-manage">반려</button>
            </td>
        </tr>
        <!-- 생략된 나머지 항목들도 같은 형식으로 추가 -->
        </tbody>
    </table>


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
