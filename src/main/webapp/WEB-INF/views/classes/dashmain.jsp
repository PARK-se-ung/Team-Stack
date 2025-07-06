<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.ts.teamstack.user.model.dto.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/main.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Users currentUser = (Users) auth.getPrincipal();
    String currentUserId = currentUser.getUserId();
%>
<script>
    window.calendarEvents = [
        <c:if test="${not empty caldate}">
            <c:forEach var="c" items="${caldate}" varStatus="st">
            {
                start: '<fmt:formatDate value="${c.scheduleDate}" pattern="yyyy-MM-dd"/>',
                title: '${c.scheduleWeek}주차 강의'
            }<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        </c:if>
        <c:if test="${not empty calassign}">,
            <c:forEach var="ca" items="${calassign}" varStatus="st">
            {
                start: '<fmt:formatDate value="${ca.scheduleDate}" pattern="yyyy-MM-dd"/>',
                end:   '<fmt:formatDate value="${ca.scheduleEnddate}" pattern="yyyy-MM-dd"/>',
                title: '${ca.scheduleWeek}주차 과제',
                color: '#28a745'
            }<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        </c:if>
        <c:if test="${not empty calnotice}">,
            <c:forEach var="cn" items="${calnotice}" varStatus="st">
            {
                start: '<fmt:formatDate value="${cn.boardDate}" pattern="yyyy-MM-dd"/>',
                title: '${cn.boardTitle}',
                color: '#dc3545'
            }<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        </c:if>
    ];
</script>
<c:if test="${not empty msg}">
    <script>alert("${msg}");</script>
</c:if>
<c:if test="${not empty error}">
    <script>alert("${error}");</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사이드바 페이지</title>
    <script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
    <style>
        * {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, sans-serif;
        }

        body {
            margin: 0;
            background-color: #f9f9f9;
            min-height: 100vh;
        }

        /* 왼쪽 사이드바 - 모던한 글래스모피즘 디자인 */
        .class-sidebar {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 280px !important;
            height: 100vh !important;
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(20px) !important;
            border-top-right-radius: 24px !important;
            border-bottom-right-radius: 24px !important;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1) !important;
            display: flex !important;
            flex-direction: column !important;
            z-index: 1000 !important;
            border: 1px solid rgba(255, 255, 255, 0.2) !important;
            padding: 0 !important;
        }

        .class-sidebar .logo {
            text-align: center !important;
            padding: 32px 20px 24px !important;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05) !important;
            margin-bottom: 0 !important;
        }

        #class-logo {
            width: 64px !important;
            height: 64px !important;
            border-radius: 16px !important;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1) !important;
        }

        .class-sidebar .dash1 {
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            margin: 20px 16px !important;
            padding: 16px 24px !important;
            text-decoration: none !important;
            background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%) !important;
            color: #fff !important;
            font-weight: 600 !important;
            font-size: 16px !important;
            border-radius: 16px !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            box-shadow: 0 8px 16px rgba(255, 107, 53, 0.3) !important;
            letter-spacing: 0.5px !important;
            border: none !important;
        }

        .class-sidebar .dash1:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 12px 24px rgba(255, 107, 53, 0.4) !important;
            color: #fff !important;
            text-decoration: none !important;
        }

        /* 사이드바 서브메뉴 */
        .sidebar-submenu {
            flex: 1;
            padding: 0 16px 20px;
            overflow-y: auto;
        }

        .sidebar-submenu .sort-tab {
            font-size: 15px;
            color: #4a5568;
            text-decoration: none;
            padding: 12px 16px;
            margin-bottom: 8px;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 12px;
            display: flex;
            align-items: center;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
            font-weight: 500;
        }

        .sidebar-submenu .sort-tab:hover {
            background: rgba(255, 107, 53, 0.1);
            color: #ff6b35;
            transform: translateX(4px);
        }

        .sidebar-submenu .sort-tab.active {
            background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%);
            color: #fff;
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
            transform: translateX(4px);
        }

        .handle {
            margin-right: 12px;
            color: #a0aec0;
            font-size: 14px;
            cursor: move;
        }

        .sort-tab.active .handle {
            color: rgba(255, 255, 255, 0.8);
        }

        .class-to-mypage {
            position: absolute !important;
            bottom: 20px !important;
            right: 20px !important;
            width: 56px !important;
            height: 56px !important;
            border-radius: 16px !important;
            background: rgba(255, 255, 255, 0.9) !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            transition: all 0.3s ease !important;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1) !important;
            text-decoration: none !important;
        }

        .class-to-mypage:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15) !important;
        }

        .class-to-mypage img {
            width: 28px !important;
            height: 28px !important;
        }

        /* 메인 콘텐츠 영역 */
        .class-main-content {
            margin-left: 300px;
            margin-right: 320px;
            padding: 40px;
            min-height: 100vh;
            position: relative;
            z-index: 8;
        }

        #tab-content {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 32px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            min-height: 600px;
            position: relative;
        }

        /* 로딩 스피너 */
        .spinner-border {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #ff6b35;
        }

        /* 오른쪽 알림 영역 - 왼쪽 사이드바와 동일한 디자인 */
        .class-side-content {
            position: fixed !important;
            top: 0 !important;
            right: 0 !important;
            width: 300px !important;
            height: 100vh !important;
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(20px) !important;
            border-top-left-radius: 24px !important;
            border-bottom-left-radius: 24px !important;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1) !important;
            display: flex !important;
            flex-direction: column !important;
            z-index: 999 !important;
            border: 1px solid rgba(255, 255, 255, 0.2) !important;
            padding: 32px 24px !important;
            box-sizing: border-box !important;
            overflow-y: auto !important;
        }

        .notification-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .notification-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
        }

        .notification-title {
            font-size: 20px;
            font-weight: 700;
            color: #2d3748;
            margin: 0;
        }

        .notification-content {
            flex: 1;
        }

        .certificate-section {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            border-radius: 16px;
            padding: 20px;
            color: white;
            margin-bottom: 20px;
        }

        .certificate-section .btn {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 12px 20px;
            border-radius: 12px;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 12px;
        }

        .certificate-section .btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
            color: white;
        }

        /* 스크롤바 커스터마이징 */
        .sidebar-submenu::-webkit-scrollbar,
        .class-side-content::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar-submenu::-webkit-scrollbar-track,
        .class-side-content::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.05);
            border-radius: 3px;
        }

        .sidebar-submenu::-webkit-scrollbar-thumb,
        .class-side-content::-webkit-scrollbar-thumb {
            background: rgba(255, 107, 53, 0.3);
            border-radius: 3px;
        }

        .sidebar-submenu::-webkit-scrollbar-thumb:hover,
        .class-side-content::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 107, 53, 0.5);
        }

        /* 과제 섹션 CSS 포함 */
        .class-notice-box {
            background: linear-gradient(135deg, #ff7d4d 0%, #ff6b35 100%);
            border-radius: 20px;
            padding: 0;
            box-shadow: 0 20px 40px rgba(255, 125, 77, 0.15);
            overflow: hidden;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .class-box-title {
            background: rgba(255, 255, 255, 0.1);
            padding: 24px 28px;
            display: flex;
            align-items: center;
            gap: 16px;
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            font-size: 24px;
            font-weight: 700;
            margin: 0;
            letter-spacing: -0.5px;
        }

        .class-box-title i {
            background: rgba(255, 255, 255, 0.2);
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: #fff;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        /* 반응형 디자인 */
        @media (max-width: 1400px) {
            .class-main-content {
                margin-left: 290px;
                margin-right: 310px;
                padding: 30px;
            }

            .class-sidebar {
                width: 270px !important;
            }

            .class-side-content {
                width: 290px !important;
            }
        }

        @media (max-width: 1200px) {
            .class-main-content {
                margin-left: 280px;
                margin-right: 0;
                padding: 20px;
            }

            .class-side-content {
                display: none !important;
            }
        }

        @media (max-width: 768px) {
            .class-sidebar {
                transform: translateX(-100%) !important;
                transition: transform 0.3s ease !important;
            }

            .class-main-content {
                margin-left: 0;
                margin-right: 0;
                padding: 16px;
            }

            #tab-content {
                padding: 20px;
            }
        }

        /* 애니메이션 */
        .sort-tab {
            animation: fadeInUp 0.6s ease forwards;
            opacity: 0;
        }

        .sort-tab:nth-child(1) { animation-delay: 0.1s; }
        .sort-tab:nth-child(2) { animation-delay: 0.2s; }
        .sort-tab:nth-child(3) { animation-delay: 0.3s; }
        .sort-tab:nth-child(4) { animation-delay: 0.4s; }
        .sort-tab:nth-child(5) { animation-delay: 0.5s; }
        .sort-tab:nth-child(6) { animation-delay: 0.6s; }
        .sort-tab:nth-child(7) { animation-delay: 0.7s; }
        .sort-tab:nth-child(8) { animation-delay: 0.8s; }
        .sort-tab:nth-child(9) { animation-delay: 0.9s; }
        .sort-tab:nth-child(10) { animation-delay: 1.0s; }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .message-bubble {
            background: white;
            padding: 16px 20px;
            border-radius: 16px;
            /* ... */
        }

        .message-bubble.own-message {
            background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%);
            color: white;
            margin-left: auto;
            /* ... */
        }
    </style>
</head>
<body id="class-body">

<!-- 사이드바 -->
<div class="class-sidebar">
    <div class="logo">
        <img id="class-logo" alt="로고" src="${path}/resources/images/logo.png">
    </div>

    <!-- 대시보드: 그냥 페이지 이동 -->
    <a class="dash1" href="${path}/class/dashboard">
        <i class="bi bi-house-door me-2"></i>
        대시보드
    </a>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.15.0/Sortable.min.js"></script>
    <div id="dashboard-submenu" class="sidebar-submenu">
        <div class="sort-tab active" onclick="setActiveTab(this); loadTab('home')">
            <i class="bi bi-house me-2"></i>
            홈
        </div>

        <div id="sortable-tabs">
            <div class="sort-tab" data-side="notice">
                <span class="handle">☰</span>
                <i class="bi bi-megaphone me-2"></i>
                공지사항
            </div>
            <div class="sort-tab" data-side="plan">
                <span class="handle">☰</span>
                <i class="bi bi-file-text me-2"></i>
                강의계획서
            </div>
            <div class="sort-tab" data-side="week">
                <span class="handle">☰</span>
                <i class="bi bi-calendar-week me-2"></i>
                주차학습
            </div>
            <c:if test="${loginUser.userId eq courseid}">
                <div class="sort-tab" data-side="assign2">
                    <span class="handle">☰</span>
                    <i class="bi bi-clipboard-check me-2"></i>
                    과제게시판
                </div>
            </c:if>
            <c:if test="${loginUser.userId ne courseid}">
                <div class="sort-tab" data-side="assign">
                    <span class="handle">☰</span>
                    <i class="bi bi-clipboard-check me-2"></i>
                    과제게시판
                </div>
            </c:if>
            <div class="sort-tab" data-side="chatting">
                <span class="handle">☰</span>
                <i class="bi bi-chat-dots me-2"></i>
                채팅
            </div>
            <div class="sort-tab" data-side="attend">
                <span class="handle">☰</span>
                <i class="bi bi-person-check me-2"></i>
                출결
            </div>
            <div class="sort-tab" data-side="score">
                <span class="handle">☰</span>
                <i class="bi bi-graph-up me-2"></i>
                성적
            </div>
            <div class="sort-tab" data-side="calendar">
                <span class="handle">☰</span>
                <i class="bi bi-calendar3 me-2"></i>
                캘린더
            </div>
            <c:if test="${loginUser.userId eq courseid}">
                <div class="sort-tab" data-side="file">
                    <span class="handle">☰</span>
                    <i class="bi bi-folder-plus me-2"></i>
                    등록게시판
                </div>
            </c:if>
            <c:if test="${loginUser.userId ne courseid}">
                <div class="sort-tab" data-side="assignfile">
                    <span class="handle">☰</span>
                    <i class="bi bi-cloud-upload me-2"></i>
                    과제 제출
                </div>
            </c:if>
        </div>
    </div>

    <a href="${path}/mypage" class="class-to-mypage">
        <i class="bi bi-arrow-left"></i>
    </a>
</div>

<!-- SortableJS 사용 -->


<!-- 본문 영역: 메뉴 없음! 내용만 출력 -->
<div class="class-main-content">
    <div id="tab-content">
        <div class="spinner-border" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>
</div>

<!-- 알림 영역 -->
<div class="class-side-content" id="dashcontent">
    <div class="notification-content">
        <c:if test="${completion.attendanceRate >= 80}">
            <div class="certificate-section">
                <h4 style="margin: 0 0 8px 0; font-size: 16px;">🎓 수료 가능</h4>
                <p style="margin: 0 0 12px 0; font-size: 14px; opacity: 0.9;">
                    축하합니다! 강의를 완료하셨습니다.
                </p>
                <a href="${pageContext.request.contextPath}/class/certificate?courseNo=${completion.courseNo}"
                   class="btn">
                    <i class="bi bi-award me-2"></i>
                    수료증 출력
                </a>
            </div>
        </c:if>
    </div>
</div>

<script src="${path}/resources/js/pdf/build/pdf.mjs" type="module"></script>
<script type="module">
    let pdfDoc = null; let currentPage = 1; let totalPage = 0;  let renderInProgress = false;
    const coursePlan = async () => {
        pdfjsLib.GlobalWorkerOptions.workerSrc = "${path}/resources/js/pdf/build/pdf.worker.mjs";

        const loadingTask = pdfjsLib.getDocument('${path}/resources/upload/course/${planfile.renamePlanName}');

        loadingTask.promise.then(data => {
            pdfDoc = data;
            totalPage = pdfDoc.numPages;
            currentPage = 1;
            renderPage(currentPage);
            document.getElementById("prevpage").addEventListener('click', () => {
                if (pdfDoc === null || currentPage <= 1 || renderInProgress) return;
                currentPage--;
                renderPage(currentPage);
            });

            document.getElementById("nextpage").addEventListener('click', () => {
                if (pdfDoc === null || currentPage >= totalPage || renderInProgress) return;
                currentPage++;
                renderPage(currentPage);
            });
        });
    };

    window.coursePlan = coursePlan;

    function renderPage(pageNum) {
        renderInProgress = true;
        pdfDoc.getPage(pageNum).then(page => {
            const viewport = page.getViewport({ scale: 1.5 });
            const canvas = document.getElementById('pdf-render');
            const context = canvas.getContext('2d');//canvas 2d로 설정
            canvas.height = viewport.height;//pdf높이 canvas높이로 설정
            canvas.width = viewport.width;//pdf넓이 canvas넓이로 설정
            const renderContext = {
                canvasContext: context,
                viewport: viewport
            };

            const renderTask = page.render(renderContext);

            renderTask.promise.then(() => {
                renderInProgress = false;
                const pageInfo = document.getElementById('pageInfo');
                if (pageInfo) {
                    pageInfo.innerText = currentPage + ` / ` +totalPage;
                }
            });
        });
    }

</script>
<script>
    const contextPath="${path}";
    // 드래그 가능
    new Sortable(document.getElementById('sortable-tabs'), {
        handle: '.handle',
        animation: 150
    });

    // 탭 클릭
    function setActiveTab(element) {
        document.querySelectorAll('.sidebar-submenu .sort-tab').forEach(tab => {
            tab.classList.remove('active');
        });
        element.classList.add('active');
    }

    const courseNo = ${course}

        function loadTab(tabName) {
            const urlMap = {
                home: `${path}/class/home`,
                notice: '${path}/class/notice',
                plan: '${path}/class/plan',
                week: '${path}/class/week',
                assign: '${path}/class/assign',
                assign2: '${path}/class/assign2',
                file: '${path}/class/file',
                chatting: '${path}/class/chatting',
                attend: '${path}/class/attend',
                score: '${path}/class/score',
                calendar: '${path}/class/calendar',
                assignfile: '${path}/class/assignfile'
            };

            fetch(urlMap[tabName]+`?courseNo=${course}`)
                .then(response => {
                    if (!response.ok) throw new Error('네트워크 오류');
                    return response.text(); // JSP 결과(html)를 텍스트로 받음
                })
                .then(html => {
                    $('#tab-content').html(html);
                    if (tabName === 'plan') {
                        coursePlan();
                    }
                    if (tabName === 'chatting'){
                        setTimeout(() => {
                            initChattingSocket(courseNo, currentUserId);
                        }, 200);
                    }
                    if (tabName === 'file') {
                        insertTabs();
                    }
                    if (tabName === 'calendar'){
                        const calendarEl = document.getElementById('calendar');
                        const calendar = new FullCalendar.Calendar(calendarEl, {
                            initialView: 'dayGridMonth',
                            locale: 'ko',
                            headerToolbar: {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'dayGridMonth,timeGridWeek,listWeek'
                            },
                            events: window.calendarEvents
                        });
                        calendar.render();
                    }
                })

                .catch(error => {
                    console.error('에러 발생:', error);
                    $('#tab-content').html('<p>내용 없음</p>');
                });
        }

    // 파일 탭 전용 탭–폼 전환 초기화 함수
    function insertTabs() {
        const tabs      = document.querySelectorAll('#file-tabMenu .insert-select');
        const underline = document.getElementById('file-underline');
        const forms     = document.querySelectorAll('.insert-form');

        // 모든 폼 숨기기
        forms.forEach(f => f.style.display = 'none');

        // 밑줄 이동 함수
        function moveUnderline(el) {
            underline.style.width = el.offsetWidth + 'px';
            underline.style.left  = el.offsetLeft + 'px';
        }

        // 폼 보이기 함수
        function showForm(sel) {
            forms.forEach(f => f.style.display = 'none');
            document.querySelector(sel).style.display = 'block';
        }

        // 탭 클릭 바인딩
        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                document.querySelector('#file-tabMenu .insert-select.active').classList.remove('active');
                tab.classList.add('active');
                moveUnderline(tab);
                showForm(tab.dataset.target);
            });
        });

        // 초기 상태: 첫 번째 탭 활성화
        const first = document.querySelector('#file-tabMenu .insert-select.active');
        if (first) {
            moveUnderline(first);
            showForm(first.dataset.target);
        }

        // 리사이즈 시 밑줄 재조정
        window.addEventListener('resize', () => {
            const activeTab = document.querySelector('#file-tabMenu .insert-select.active');
            if (activeTab) {
                moveUnderline(activeTab);
            }
        });
    }


    //data-tab의 값을
    document.querySelectorAll('#sortable-tabs .sort-tab').forEach(tab => {
        tab.addEventListener('click', function() {
            setActiveTab(this);
            loadTab(this.getAttribute('data-side'));
        });
    });

    // 처음에 홈 탭 내용 로드
    window.addEventListener('DOMContentLoaded', () => {
        loadTab('home');
    });

</script>
<script> const currentUserId = "<%= currentUserId%>";</script>
<script>
    function initChattingSocket(courseNo, currentUserId) {
        console.log("<%= currentUserId%>");

        const socket = new WebSocket('ws://localhost:9090/chat?courseNo=' + courseNo);

        const sendMessage = function () {
            console.log("✅ [클릭됨] sendMessage 실행됨");

            const input = document.getElementById("chat-input");
            if (!input) return; // 요소가 없으면 리턴

            const message = input.value.trim();

            if (message !== "" && socket.readyState == WebSocket.OPEN) {
                const messageData = {
                    userId: currentUserId,
                    chatMsg: message,
                    courseNo: courseNo
                };

                socket.send(JSON.stringify(messageData));
                input.value = "";
            }
        }

        // 이벤트 리스너 등록
        setTimeout(() => { // DOM 로딩 대기
            const sendBtn = document.getElementById('send-btn');
            if (sendBtn) {
                sendBtn.removeEventListener('click', sendMessage);
                sendBtn.addEventListener('click', sendMessage);
            }
        }, 100);

        socket.onmessage = function(event) {
            console.log("메세지를 수신");
            const chat = JSON.parse(event.data);
            const chatBox = document.getElementById('chat-box');
            if (!chatBox) return;

            const $div = document.createElement('div');
            $div.classList.add("mb-2");

            if (chat.userId === currentUserId) {
                $div.innerHTML =
                    '<div class="message-bubble own-message">' +
                    '<div class="message-header">' +
                    '<span class="message-author">나</span>' +
                    '<span class="message-time">(' + chat.chatTime + ')</span>' +
                    '</div>' +
                    '<div class="message-content">' + chat.chatMsg + '</div>' +
                    '</div>';
            } else {
                $div.innerHTML =
                    '<div class="message-bubble">' +
                    '<div class="message-header">' +
                    '<span class="message-author">' + chat.userId + '</span>' +
                    '<span class="message-time">(' + chat.chatTime + ')</span>' +
                    '</div>' +
                    '<div class="message-content">' + chat.chatMsg + '</div>' +
                    '</div>';
            }

            chatBox.appendChild($div);
            chatBox.scrollTop = chatBox.scrollHeight;
        };
    }
</script>
</body>
</html>