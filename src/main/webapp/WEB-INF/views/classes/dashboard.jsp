<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body id="class-body">
<!-- 사이드바 -->
<div class="class-sidebar">
    <div class="logo"><img id="class-logo" alt="로고" src="${path}/resources/images/logo.png">
    </div>
    <a class="dash1" href="">대시보드</a>
    <a href="${path}/mypage" class="class-to-mypage">
        <img style="width: 50px;" src="${path}/resources/images/doorarrow.png" alt="마이페이지로" >
    </a>
</div>

<!-- 본문 영역 -->
<div class="dash-class-main-content">

        <title>클래스</title>
        <style>

            .dash-menu {
                position: relative;
                display: flex;
                gap: 60px;
                font-size: 24px;
                font-weight: bold;
                color: #000;
                cursor: pointer;
                margin-left: 20px;
                margin-top: 20px;
            }

            .dash-select {
                position: relative;
                padding-bottom: 8px;
                z-index: 1; /* underline 보다 위 */
            }

            .tab-underline {
                position: absolute;
                bottom: -12px;
                left: 0;
                width: 0;           /* 초기 width 0 */
                height: 10px;
                background-color: #d88a16;
                border-radius: 10px;
                transition: left 0.3s ease, width 0.3s ease;
                z-index: 0;
            }
            .dash-content{
                margin-top: 30px;
            }
            .dash-board{
                flex-wrap: wrap;
                gap: 32px;
                justify-content: center;
            }

        </style>

    <div class="dash-menu" id="tabMenu">
        <div class="dash-select active" data-board="ongoing">수강중</div>
        <div class="dash-select" data-board="completed">수강완료</div>
        <div class="dash-select" data-board="all">전체</div>
        <span class="tab-underline" id="underline"></span>
    </div>

    <div class="dash-content">
        <div class="dash-board" id="dboard-active" style="display: flex">
            <c:forEach var="on" items="${ongoing}">
                <div class="card" style="width: 18rem;">
                    <a href="${path}/class/dashmain?courseNo=${on.courseNo}">
                        <img src="${path}/resources/upload/${on.thumbnail}" class="card-img-top" alt="썸네일">
                        <div class="card-body">
                            ${on.courseTitle}
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
        <div class="dash-board" id="dboard-completed" style="display:none">
            <c:forEach var="com" items="${complete}">
                <div class="card" style="width: 18rem;">
                    <a href="${path}/class/dashmain?courseNo=${com.courseNo}">
                        <img src="${path}/resources/upload/${com.thumbnail}" class="card-img-top" alt="썸네일">
                        <div class="card-body">
                                ${com.courseTitle}
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
        <div class="dash-board" id="dboard-all" style="display:none">
            <c:forEach var="all" items="${allcourse}">
                <div class="card" style="width: 18rem;">
                    <a href="${path}/class/dashmain?courseNo=${all.courseNo}">
                        <img src="${path}/resources/upload/${all.thumbnail}" class="card-img-top" alt="썸네일">
                        <div class="card-body">
                                ${all.courseTitle}
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const tabs      = document.querySelectorAll('.dash-select');
            const underline = document.getElementById('underline');
            const boards    = document.querySelectorAll('.dash-board');

            function moveUnderline(el) {
                underline.style.width = el.offsetWidth + 'px';
                underline.style.left  = el.offsetLeft + 'px';
            }

            function showBoard(key) {
                // ongoing → dboard-active, completed → dboard-completed, all → dboard-all
                const targetId = (key === 'ongoing') ? 'dboard-active' : 'dboard-' + key;
                boards.forEach(b => {
                    b.style.display = (b.id === targetId) ? 'flex' : 'none';
                });
            }

            tabs.forEach(tab => {
                tab.addEventListener('click', () => {
                    document.querySelector('.dash-select.active').classList.remove('active');
                    tab.classList.add('active');
                    moveUnderline(tab);
                    showBoard(tab.dataset.board);
                });
            });

            // 초기 상태 세팅
            const activeTab = document.querySelector('.dash-select.active');
            moveUnderline(activeTab);
            showBoard(activeTab.dataset.board);

            window.addEventListener('resize', () => {
                moveUnderline(document.querySelector('.dash-select.active'));
            });
        });
    </script>


    </div>
<div class="class-side-content" id="dashcontent">알림</div>
<link rel="stylesheet" href="${path}/resources/css/classes.css"/>
</body>
<script>
    const getActiveList=async()=>{
        loading("dashcontent");
        const response = await fetch("${path}/dashactive");
        const data = await response.text();
        document.getElementById("dashcontent").innerHTML=data;
    }
</script>
</html>
