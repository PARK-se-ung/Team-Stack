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
                <li class="menu-item active" data-tab="authorAppr">권한 승인</li>
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
    <div>
        <button disabled type="button" class="btn btn-outline-orange arrows" data-type="prev">prev</button>
    </div>
    <article class="main-content">
        <div class="loading-content">
            <div class="loading-spinner"></div>
            <p>페이지를 불러오는 중입니다...</p>
        </div>
    </article>
    <div>
        <button disabled type="button" class="btn btn-outline-orange arrows" data-type="next">next</button>
    </div>
</section>
<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/manage.js"></script>
<script>
    $(document).ready(function() {
        manageLoad('authorAppr');

        /* 페이지 객체 생성 */
        const dequeData = new DequeData();

        /* 사이드 탭 전환 핸들러 */
        $(".menu-item").on('click', function() {
            let $current = $(this);
            let current = $current.data('tab');
            let prev = $(".menu-item.active").data('tab');
            if(current !== prev) dequeData.move('shift', prev);
            disableHandler(dequeData);
            $(".menu-item").removeClass("active");
            $current.addClass("active");
            manageLoad(current);
        });

        /* 메모리 탭 전환 핸들러 */
        $(".arrows").on('click', function() {
            let $current = $(this);
            let type = $current.data('type');
            let tabId = $(".menu-item.active").data("tab");
            let activeTab = dequeData.move(type, tabId);
            $(".menu-item").removeClass("active");
            $(`.menu-item[data-tab=\${activeTab}]`).addClass("active");
            manageLoad(activeTab);

            disableHandler(dequeData);
        });


    });
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
