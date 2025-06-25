<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<!-- Flatpickr -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<!-- section -->
<section class="page-container">
    <!-- aside -->
    <aside class="side-bar">
        <h3 class="ms-3"> 관리자 페이지</h3>
        <div class="menu-section">
            <div class="menu-title">승인</div>
            <ul>
                <li class="menu-item active" data-tab="createAppr">권한 승인</li>
                <li class="menu-item" data-tab="courseAppr">강의 승인</li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">고객센터</div>
            <ul>
                <li class="menu-item" data-tab="inquire">문의사항</li>
                <li class="menu-item" data-tab="notice">공지사항</li>
                <li class="menu-item" data-tab="alarm">알람</li>
            </ul>
        </div>
    </aside>
    <!-- article -->
    <article class="main-content">
        <div class="loading-content">
            <div class="loading-spinner"></div>
            <p>페이지를 불러오는 중입니다...</p>
        </div>
    </article>
</section>
<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/manage.js"></script>
<script>
    $(document).ready(function() {
        manageLoad('createAppr');

        $(".menu-item").on('click', function() {
            let $current = $(this);
            let tabId = $current.data('tab');
            $(".menu-item").removeClass("active");
            $current.addClass("active");

            manageLoad(tabId);
        })
    });

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
