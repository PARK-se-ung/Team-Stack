<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.ts.teamstack.user.model.dto.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/main.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/main.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Users currentUser = (Users) auth.getPrincipal();
    String currentUserId = currentUser.getUserId();
%>
<script>
    window.calendarEvents = [
        <c:forEach var="c" items="${caldate}" varStatus="st">
        {
            start: '<fmt:formatDate value="${c.scheduleDate}" pattern="yyyy-MM-dd"/>',
            title: '${c.scheduleWeek}주차 강의'
        }<c:if test="${!st.last}">,</c:if>
        </c:forEach>,
        <c:forEach var="ca" items="${calassign}" varStatus="st">
        {
            start: '<fmt:formatDate value="${ca.scheduleDate}" pattern="yyyy-MM-dd"/>',
            end:   '<fmt:formatDate value="${ca.scheduleEnddate}" pattern="yyyy-MM-dd"/>',
            title: '${ca.scheduleWeek}주차 과제',
            color: '#28a745'
        }<c:if test="${!st.last}">,</c:if>
        </c:forEach>,
        <c:forEach var="cn" items="${calnotice}" varStatus="st">
        {
            start: '<fmt:formatDate value="${cn.boardDate}" pattern="yyyy-MM-dd"/>',
            title: '${cn.boardTitle}',
            color: '#dc3545'
        }<c:if test="${!st.last}">,</c:if>
        </c:forEach>
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
    <link rel="stylesheet" href="${path}/resources/css/classes.css">
    <script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
    <style>
        .sidebar-submenu .sort-tab {
            font-size: 16px;
            color: #333; /* 진한 글자색으로 가독성 확보 */
            text-decoration: none;
            padding: 8px 14px;
            margin-bottom: 8px;
            background-color: #ffe6d5; /* 밝은 톤으로 배경 */
            border-radius: 6px;
            display: flex;
            align-items: center;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .sidebar-submenu .sort-tab:hover {
            background-color: #ffd2b3; /* hover 시 살짝 강조 */
            color: #000; /* hover 시 더 진한 글자색 */
        }

        .sidebar-submenu .sort-tab.active {
            background-color: #ff944d; /* active 시 주황 강조 */
            color: #fff; /* active 시 흰색 글자 */
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
    <a class="dash1" href="${path}/class/dashboard">대시보드</a>

    <!-- 하위 메뉴: 항상 표시 -->
    <div id="dashboard-submenu" class="sidebar-submenu" style="margin-top: 10px;">
        <div class="sort-tab active" style="margin-bottom: 12px"onclick="setActiveTab(this); loadTab('home')">홈</div>

        <div id="sortable-tabs" style="display: flex; flex-direction: column; gap: 5px; margin-top: 5px;">
            <div class="sort-tab" data-side="notice">
                <span class="handle">☰</span> 공지사항
            </div>
            <div class="sort-tab" data-side="plan">
                <span class="handle">☰</span> 강의계획서
            </div>
            <div class="sort-tab" data-side="week">
                <span class="handle">☰</span> 주차학습
            </div>
            <c:if test="${loginUser.userId eq courseid}">
                <div class="sort-tab" data-side="assign2">
                    <span class="handle">☰</span> 과제게시판
                </div>
            </c:if>
            <c:if test="${loginUser.userId ne courseid}">
                <div class="sort-tab" data-side="assign">
                    <span class="handle">☰</span> 과제게시판
                </div>
            </c:if>
            <div class="sort-tab" data-side="chatting">
                <span class="handle">☰</span> 채팅
            </div>
            <div class="sort-tab" data-side="attend">
                <span class="handle">☰</span> 출결
            </div>
            <div class="sort-tab" data-side="score">
                <span class="handle">☰</span> 성적
            </div>
            <div class="sort-tab" data-side="calendar">
                <span class="handle">☰</span> 캘린더
            </div>
            <c:if test="${loginUser.userId eq courseid}">
                <div class="sort-tab" data-side="file">
                    <span class="handle">☰</span> 등록게시판
                </div>
            </c:if>
            <c:if test="${loginUser.userId ne courseid}">
                <div class="sort-tab" data-side="assignfile">
                    <span class="handle">☰</span> 과제 제출
                </div>
            </c:if>

        </div>
        <a href="${path}/mypage" class="class-to-mypage">
            <img style="width: 50px;" src="${path}/resources/images/doorarrow.png" alt="마이페이지로" >
        </a>
    </div>


</div>
<!-- SortableJS 사용 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.15.0/Sortable.min.js"></script>
<!-- 본문 영역: 메뉴 없음! 내용만 출력 -->
<div class="class-main-content">
    <div id="tab-content">
        <div class="spinner-border" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>
</div>
<style>

</style>
<!-- 알림 영역 -->
<div class="class-side-content" id="dashcontent">
    알림
    <c:if test="${completion.attendanceRate >= 10}">

    </c:if>
</div>
<script src="${path}/resources/js/pdf/build/pdf.mjs" type="module"></script>
<script type="module">
    let pdfDoc = null;
    let currentPage = 1;
    let totalPage = 0;
    let renderInProgress = false; // 렌더 중 여부 확인

    const coursePlan = async () => {
        pdfjsLib.GlobalWorkerOptions.workerSrc = "${path}/resources/js/pdf/build/pdf.worker.mjs";

        const loadingTask = pdfjsLib.getDocument('${path}/resources/pdf/${planfile.renamePlanName}');

        loadingTask.promise.then(data => {
            pdfDoc = data;
            totalPage = pdfDoc.numPages;
            currentPage = 1;

            renderPage(currentPage);

            // 버튼 이벤트 등록: 서브 JSP 가 들어온 후에 등록!
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
        moveUnderline(first);
        showForm(first.dataset.target);

        // 리사이즈 시 밑줄 재조정
        window.addEventListener('resize', () => moveUnderline(document.querySelector('#file-tabMenu .insert-select.active')));
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

    const socket = new WebSocket('ws://localhost:8080/chat?courseNo=' + courseNo);

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
    '<div style="text-align: right;">' +
        '<strong class="text-primary">나</strong>' +
        '<span class="text-muted" style="font-size: 0.85em;">(' + chat.chatTime + ')</span><br>' +
        '<span>' + chat.chatMsg + '</span>' +
        '</div>';
    } else {
    $div.innerHTML =
    '<div>' +
        '<strong class="text-success">' + chat.userId + '</strong>' +
        '<span class="text-muted" style="font-size: 0.85em;">(' + chat.chatTime + ')</span><br>' +
        '<span>' + chat.chatMsg + '</span>' +
        '</div>';
    }

    chatBox.appendChild($div);
    chatBox.scrollTop = chatBox.scrollHeight;
    };
    }
</script>
</body>
</html>