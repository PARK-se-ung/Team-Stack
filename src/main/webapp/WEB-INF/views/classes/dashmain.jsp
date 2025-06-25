<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
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
            <div class="sort-tab" data-side="assign">
                <span class="handle">☰</span> 과제게시판
            </div>
            <div class="sort-tab" data-side="file">
                <span class="handle">☰</span> 파일게시판
            </div>
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
        <p>홈 탭 내용</p>
    </div>
</div>

<!-- 알림 영역 -->
<div class="class-side-content" id="dashcontent">알림</div>



<script src="${path}/resources/js/pdf/build/pdf.mjs" type="module"></script>
<script type="module">
    let pdfDoc = null;
    let currentPage = 1;
    let totalPage = 0;
    let renderInProgress = false; // ★ 렌더 중 여부 확인

    export const coursePlan = async (e) => {
        pdfjsLib.GlobalWorkerOptions.workerSrc = "${path}/resources/js/pdf/build/pdf.worker.mjs";

        const loadingTask = pdfjsLib.getDocument('${path}/resources/pdf/example.pdf');

        loadingTask.promise.then(data => {
            pdfDoc = data;
            totalPage = pdfDoc.numPages;
            currentPage = 1;

            renderPage(currentPage);

            // ★ 버튼 이벤트 등록: 서브 JSP 가 들어온 후에 등록!
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

    function renderPage(pageNum) {
        renderInProgress = true; // ★ 렌더 시작
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

    document.querySelector("div[data-side='plan']").addEventListener("click", coursePlan);


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
            home: contextPath+'/class/home',
            notice: contextPath+'/class/notice',
            plan: contextPath+'/class/plan',
            week: contextPath+'/class/week',
        };

        <%--urlMap +="?courseNo=${}--%>

        fetch(urlMap[tabName], {
            method:'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ courseNo: courseNo })
        })
            .then(response => {
                if (!response.ok) throw new Error('네트워크 오류');
                return response.text(); // JSP 결과(html)를 텍스트로 받음
            })
            .then(html => {
                document.getElementById('tab-content').innerHTML = html;
            })
            .catch(error => {
                console.error('에러 발생:', error);
                document.getElementById('tab-content').innerHTML = '<p>내용 없음</p>';
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



</body>
</html>
