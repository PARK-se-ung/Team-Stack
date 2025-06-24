<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 25. 6. 20.
  Time: 오전 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<!-- Korean locale -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<div class="page-container">
    <!-- aside -->
    <div class="side-bar">
        <h3 class="ms-3"> 마이페이지</h3>
        <div class="menu-section">
            <div class="menu-title">개인정보</div>
            <ul>
                <li class="menu-item active" data-tab="info">개인정보 수정</li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">내 강의내역</div>
            <ul>
                <li class="menu-item" data-tab="bookmark">내 활동</li>
                <li class="menu-item" data-tab="open">개설 강의 관리</li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">클래스</div>
            <ul>
                <li class="menu-item" data-tab="class">클래스 바로가기</li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">결제</div>
            <ul>
                <li class="menu-item" data-tab="purchase">결제내역조회</li>
                <li class="menu-item" data-tab="sales">환불신청조회</li>
            </ul>
        </div>
    </div>

    <!-- 메인 컨텐츠 영역 -->
    <div class="main-content">
        <div class="loading-content">
            <div class="loading-spinner"></div>
            <p>페이지를 불러오는 중입니다...</p>
        </div>
    </div>

</div>
<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<script>
$(document).ready(function() {
    tabLoad('info');

    $(".menu-item").on('click', function() {
        let $current = $(this);
        let tabId = $current.data('tab');
        $(".menu-item").removeClass("active");
        $current.addClass("active");

        tabLoad(tabId);
    })
})

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

