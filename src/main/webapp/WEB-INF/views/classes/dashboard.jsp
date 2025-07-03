<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body id="class-body">

<style>
    * {
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, sans-serif;
    }

    body {
        margin: 0;
        background-color: #f9f9f9;
        min-height: 100vh;
    }

    /* 왼쪽 사이드바 - dashmain과 동일한 모던한 글래스모피즘 디자인 */
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
    .dash-class-main-content {
        margin-left: 300px;
        margin-right: 320px;
        padding: 40px;
        min-height: 100vh;
        position: relative;
        z-index: 8;
    }

    /* 헤더 섹션 */
    .dashboard-header {
        background: linear-gradient(135deg, #ff7d4d 0%, #ff6b35 100%);
        border-radius: 24px;
        padding: 40px;
        margin-bottom: 40px;
        color: white;
        box-shadow: 0 20px 40px rgba(255, 125, 77, 0.2);
        position: relative;
        overflow: hidden;
    }

    .dashboard-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="20" cy="20" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="80" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="40" cy="60" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
        opacity: 0.3;
    }

    .dashboard-title {
        font-size: 32px;
        font-weight: 700;
        margin: 0 0 8px 0;
        display: flex;
        align-items: center;
        gap: 16px;
        position: relative;
        z-index: 1;
    }

    .dashboard-subtitle {
        font-size: 16px;
        opacity: 0.9;
        margin: 0;
        position: relative;
        z-index: 1;
    }

    /* 탭 메뉴 */
    .dash-menu {
        position: relative;
        display: flex;
        gap: 8px;
        margin-bottom: 40px;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        border-radius: 20px;
        padding: 8px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .dash-select {
        position: relative;
        padding: 16px 24px;
        cursor: pointer;
        border-radius: 16px;
        font-size: 16px;
        font-weight: 600;
        color: #64748b;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        user-select: none;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .dash-select:hover {
        color: #ff6b35;
        background: rgba(255, 107, 53, 0.1);
    }

    .dash-select.active {
        color: white;
        background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%);
        box-shadow: 0 8px 16px rgba(255, 107, 53, 0.3);
        transform: translateY(-2px);
    }

    .tab-underline {
        display: none;
    }

    /* 콘텐츠 영역 */
    .dash-content {
        margin-top: 20px;
    }

    .dash-board {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 32px;
    }

    /* 카드 스타일 */
    .card {
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        border: none;
        background: white;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        animation: fadeInUp 0.6s ease forwards;
        opacity: 0;
        transform: translateY(20px);
    }

    .card:nth-child(1) { animation-delay: 0.1s; }
    .card:nth-child(2) { animation-delay: 0.2s; }
    .card:nth-child(3) { animation-delay: 0.3s; }
    .card:nth-child(4) { animation-delay: 0.4s; }
    .card:nth-child(5) { animation-delay: 0.5s; }
    .card:nth-child(6) { animation-delay: 0.6s; }

    @keyframes fadeInUp {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .card:hover {
        transform: translateY(-12px) scale(1.02);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
    }

    .card a {
        text-decoration: none;
        color: inherit;
        display: block;
        height: 100%;
    }

    .card-img-top {
        height: 220px;
        object-fit: cover;
        transition: transform 0.4s ease;
        position: relative;
    }

    .card:hover .card-img-top {
        transform: scale(1.08);
    }

    .card-img-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(45deg, rgba(255, 125, 77, 0.8), rgba(255, 142, 83, 0.6));
        opacity: 0;
        transition: opacity 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .card:hover .card-img-overlay {
        opacity: 1;
    }

    .play-icon {
        color: white;
        font-size: 48px;
        transform: scale(0.8);
        transition: transform 0.3s ease;
    }

    .card:hover .play-icon {
        transform: scale(1);
    }

    .card-body {
        padding: 24px;
        background: white;
        position: relative;
    }

    .course-title {
        font-weight: 700;
        color: #1e293b;
        font-size: 18px;
        line-height: 1.4;
        margin: 0 0 12px 0;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .course-meta {
        display: flex;
        align-items: center;
        gap: 12px;
        color: #64748b;
        font-size: 14px;
        font-weight: 500;
    }

    .course-status {
        background: linear-gradient(135deg, #ff944d 0%, #ff7b1f 100%);
        color: white;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
    }

    /* 빈 상태 */
    .empty-state {
        text-align: center;
        padding: 80px 20px;
        color: #64748b;
        grid-column: 1 / -1;
    }

    .empty-icon {
        font-size: 64px;
        color: #cbd5e1;
        margin-bottom: 24px;
    }

    .empty-title {
        font-size: 20px;
        font-weight: 600;
        margin-bottom: 8px;
        color: #475569;
    }

    .empty-description {
        font-size: 16px;
        opacity: 0.8;
    }

    /* 오른쪽 알림 영역 */
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
        text-align: center;
        color: #64748b;
        padding: 20px;
    }

    /* 반응형 디자인 */
    @media (max-width: 1400px) {
        .dash-class-main-content {
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

        .dash-board {
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
        }
    }

    @media (max-width: 1200px) {
        .dash-class-main-content {
            margin-left: 300px;
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

        .dash-class-main-content {
            margin-left: 0;
            margin-right: 0;
            padding: 16px;
        }

        .dashboard-header {
            padding: 30px 24px;
            margin-bottom: 30px;
        }

        .dashboard-title {
            font-size: 24px;
        }

        .dash-menu {
            flex-wrap: wrap;
            gap: 6px;
            padding: 6px;
        }

        .dash-select {
            padding: 12px 18px;
            font-size: 14px;
        }

        .dash-board {
            grid-template-columns: 1fr;
            gap: 20px;
        }

        .card-img-top {
            height: 180px;
        }
    }
</style>

<!-- 사이드바 -->
<div class="class-sidebar">
    <div class="logo">
        <img id="class-logo" alt="로고" src="${path}/resources/images/logo.png">
    </div>
    <a class="dash1" href="">
        <i class="bi bi-house-door me-2"></i>
        대시보드
    </a>
    <a href="${path}/mypage" class="class-to-mypage">
        <i class="bi bi-arrow-left"></i>
    </a>
</div>

<!-- 본문 영역 -->
<div class="dash-class-main-content">
    <title>클래스</title>

    <!-- 헤더 섹션 -->
    <div class="dashboard-header">
        <h1 class="dashboard-title">
            <i class="bi bi-mortarboard"></i>
            내 강의실
        </h1>
        <p class="dashboard-subtitle">수강 중인 강의와 완료된 강의를 확인하세요</p>
    </div>

    <!-- 탭 메뉴 -->
    <div class="dash-menu" id="tabMenu">
        <div class="dash-select active" data-board="ongoing">
            <i class="bi bi-play-circle"></i>
            수강중
        </div>
        <div class="dash-select" data-board="completed">
            <i class="bi bi-check-circle"></i>
            수강완료
        </div>
        <div class="dash-select" data-board="all">
            <i class="bi bi-grid"></i>
            전체
        </div>
        <c:if test="${type eq 'I'}">
            <div class="dash-select" data-board="iboard">
                <i class="bi bi-person-gear"></i>
                개설한 강의
            </div>
        </c:if>
        <span class="tab-underline" id="underline"></span>
    </div>

    <!-- 콘텐츠 영역 -->
    <div class="dash-content">
        <div class="dash-board" id="dboard-active" style="display: grid">
            <c:choose>
                <c:when test="${not empty ongoing}">
                    <c:forEach var="on" items="${ongoing}">
                        <div class="card">
                            <a href="${path}/class/dashmain?courseNo=${on.courseNo}">
                                <div style="position: relative;">
                                    <img src="${path}/resources/upload/${on.thumbnail}" class="card-img-top" alt="썸네일" onerror="this.src='${pageContext.request.contextPath}/resources/images/default-thumbnail.png'">
                                    <div class="card-img-overlay">
                                        <i class="bi bi-play-circle play-icon"></i>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <h3 class="course-title">${on.courseTitle}</h3>
                                    <div class="course-meta">
                                        <span class="course-status">진행중</span>
                                        <span><i class="bi bi-calendar me-1"></i>수강중</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="bi bi-book"></i>
                        </div>
                        <h3 class="empty-title">수강 중인 강의가 없습니다</h3>
                        <p class="empty-description">새로운 강의를 시작해보세요</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="dash-board" id="dboard-completed" style="display:none">
            <c:choose>
                <c:when test="${not empty complete}">
                    <c:forEach var="com" items="${complete}">
                        <div class="card">
                            <a href="${path}/class/dashmain?courseNo=${com.courseNo}">
                                <div style="position: relative;">
                                    <img src="${path}/resources/upload/${com.thumbnail}" class="card-img-top" alt="썸네일" onerror="this.src='${pageContext.request.contextPath}/resources/images/default-thumbnail.png'">
                                    <div class="card-img-overlay">
                                        <i class="bi bi-check-circle play-icon"></i>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <h3 class="course-title">${com.courseTitle}</h3>
                                    <div class="course-meta">
                                        <span class="course-status" style="background: linear-gradient(135deg, #ff6b35 0%, #ff8e53 100%);">완료</span>
                                        <span><i class="bi bi-trophy me-1"></i>수료완료</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="bi bi-trophy"></i>
                        </div>
                        <h3 class="empty-title">완료된 강의가 없습니다</h3>
                        <p class="empty-description">강의를 완료하면 여기에 표시됩니다</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="dash-board" id="dboard-all" style="display:none">
            <c:choose>
                <c:when test="${not empty allcourse}">
                    <c:forEach var="all" items="${allcourse}">
                        <div class="card">
                            <a href="${path}/class/dashmain?courseNo=${all.courseNo}">
                                <div style="position: relative;">
                                    <img src="${path}/resources/upload/${all.thumbnail}" class="card-img-top" alt="썸네일" onerror="this.src='${pageContext.request.contextPath}/resources/images/default-thumbnail.png'">
                                    <div class="card-img-overlay">
                                        <i class="bi bi-play-circle play-icon"></i>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <h3 class="course-title">${all.courseTitle}</h3>
                                    <div class="course-meta">
                                        <span class="course-status" style="background: linear-gradient(135deg, #ff944d 0%, #ff7b1f 100%);">전체</span>
                                        <span><i class="bi bi-collection me-1"></i>모든 강의</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="bi bi-grid"></i>
                        </div>
                        <h3 class="empty-title">등록된 강의가 없습니다</h3>
                        <p class="empty-description">강의를 등록하면 여기에 표시됩니다</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="dash-board" id="dboard-iboard" style="display: none">
            <c:choose>
                <c:when test="${not empty mycourse}">
                    <c:forEach var="mc" items="${mycourse}">
                        <div class="card">
                            <a href="${path}/class/dashmain?courseNo=${mc.courseNo}">
                                <div style="position: relative;">
                                    <img src="${path}/resources/upload/${mc.thumbnail}" class="card-img-top" alt="썸네일" onerror="this.src='${pageContext.request.contextPath}/resources/images/default-thumbnail.png'">
                                    <div class="card-img-overlay">
                                        <i class="bi bi-gear play-icon"></i>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <h3 class="course-title">${mc.courseTitle}</h3>
                                    <div class="course-meta">
                                        <span class="course-status" style="background: linear-gradient(135deg, #ff7d4d 0%, #ff6b35 100%);">내 강의</span>
                                        <span><i class="bi bi-person-gear me-1"></i>강사</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="bi bi-person-gear"></i>
                        </div>
                        <h3 class="empty-title">개설한 강의가 없습니다</h3>
                        <p class="empty-description">새로운 강의를 개설해보세요</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const tabs = document.querySelectorAll('.dash-select');
            const boards = document.querySelectorAll('.dash-board');

            function showBoard(key) {
                const targetId = (key === 'ongoing') ? 'dboard-active' : 'dboard-' + key;
                boards.forEach(b => {
                    b.style.display = (b.id === targetId) ? 'grid' : 'none';
                });
            }

            tabs.forEach(tab => {
                tab.addEventListener('click', () => {
                    document.querySelector('.dash-select.active').classList.remove('active');
                    tab.classList.add('active');
                    showBoard(tab.dataset.board);
                });
            });

            // 초기 상태 세팅
            const activeTab = document.querySelector('.dash-select.active');
            showBoard(activeTab.dataset.board);
        });
    </script>

</div>

<!-- 알림 영역 -->
<div class="class-side-content" id="dashcontent">
    <div class="notification-header">
        <div class="notification-icon">
            <i class="bi bi-bell"></i>
        </div>
        <h3 class="notification-title">알림</h3>
    </div>

    <div class="notification-content">
        <i class="bi bi-info-circle" style="font-size: 24px; margin-bottom: 8px;"></i>
        <p style="margin: 0; font-size: 14px;">현재 알림이 없습니다</p>
    </div>
</div>

<script>
    const getActiveList=async()=>{
        loading("dashcontent");
        const response = await fetch("${path}/dashactive");
        const data = await response.text();
        $('#dashcontent').html(data);
    }
</script>
</body>
</html>