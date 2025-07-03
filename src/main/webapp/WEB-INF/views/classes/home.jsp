<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<c:set var="path" value="${pageContext.request.contextPath}"/>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #f9f9f9 0%, #fff5f2 100%);
        min-height: 100vh;
        padding: 2vh 2vw;
    }

    .container {
        max-width: 90vw;
        margin: 0 auto;
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 3vw;
    }

    .class-home-box {
        background: linear-gradient(135deg, #ff9966 0%, #ff7d4d 100%);
        border-radius: 2vw;
        padding: 2.5vh 2vw;
        box-shadow: 0 1vh 3vh rgba(255, 125, 77, 0.2);
        position: relative;
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        min-height: 50vh;
    }

    .class-home-box:hover {
        transform: translateY(-0.5vh);
        box-shadow: 0 1.5vh 4vh rgba(255, 125, 77, 0.3);
    }

    .class-home-box::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 100%;
        height: 100%;
        background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
        transform: rotate(45deg);
        transition: all 0.6s ease;
    }

    .class-home-box:hover::before {
        top: -40%;
        right: -40%;
    }

    .class-box-title {
        display: flex;
        align-items: center;
        font-weight: 700;
        font-size: clamp(1.2rem, 2.5vw, 1.6rem);
        color: white;
        margin-bottom: 2vh;
        text-shadow: 0 0.2vh 0.4vh rgba(0, 0, 0, 0.1);
    }

    .class-box-title i {
        font-size: clamp(1.1rem, 2.2vw, 1.4rem);
        margin-right: 1vw;
        padding: 0.8vh 1vw;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 1vw;
        backdrop-filter: blur(10px);
    }

    .class-main-item {
        background: linear-gradient(135deg, #ffd4b0 0%, #ffb885 100%);
        border-radius: 1.5vw;
        margin-bottom: 1.5vh;
        padding: 1.8vh 2vw;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: space-between;
        border: 0.2vw solid transparent;
        position: relative;
        overflow: hidden;
        min-height: 6vh;
    }

    .class-main-item::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        height: 100%;
        width: 0.4vw;
        background: linear-gradient(to bottom, #ff7d4d, #ff944d);
        transition: width 0.3s ease;
    }

    .class-main-item:hover {
        transform: translateX(0.5vw);
        background: linear-gradient(135deg, #ff854d 0%, #ff7d4d 100%);
        color: white;
        border-color: rgba(255, 255, 255, 0.3);
        box-shadow: 0 0.5vh 1.5vh rgba(255, 125, 77, 0.4);
    }

    .class-main-item:hover::before {
        width: 100%;
        opacity: 0.1;
    }

    .home-title {
        font-weight: 600;
        font-size: clamp(0.9rem, 1.8vw, 1.1rem);
        flex: 1;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        margin-right: 1.5vw;
    }

    .home-content {
        padding-right: 2vw;
        width: 15vw;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .home-date {
        display: inline-block;      /* make it size to its contents */
        width: auto;                /* (this is the default, but good to be explicit) */
        font-size: clamp(0.8rem, 1.5vw, 1rem);
        font-weight: 500;
        background: rgba(255, 255, 255, 0.3);
        padding: 0.5vh 1.2vw;
        border-radius: 2vw;
        backdrop-filter: blur(10px);
        border: 0.1vw solid rgba(255, 255, 255, 0.2);
        white-space: nowrap;
    }


    .class-main-item:hover .home-date {
        background: rgba(255, 255, 255, 0.9);
        color: #ff7d4d;
    }

    .empty-message {
        text-align: center;
        color: rgba(255, 255, 255, 0.9);
        font-style: italic;
        padding: 3vh 2vw;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 1.5vw;
        backdrop-filter: blur(10px);
        border: 0.1vw dashed rgba(255, 255, 255, 0.3);
    }

    .empty-message i {
        font-size: clamp(1.5rem, 3vw, 2.5rem);
        margin-bottom: 1vh;
        opacity: 0.7;
    }

    .download-btn {
        background: rgba(255, 255, 255, 0.9);
        border: none;
        border-radius: 10%;
        width: 7vw;
        height: 2.5vw;
        min-width: 30px;
        min-height: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.3s ease;
        color: #ff7d4d;
        font-size: clamp(0.8rem, 1.2vw, 1rem);
        backdrop-filter: blur(10px);
        box-shadow: 0 0.2vh 0.5vh rgba(0, 0, 0, 0.1);
        text-decoration: none;
    }

    .download-btn:hover {
        background: white;
        transform: scale(1.1);
        box-shadow: 0 0.4vh 1vh rgba(0, 0, 0, 0.2);
        color: #ff6b3d;
    }

    .class-main-item:hover .download-btn {
        background: rgba(255, 255, 255, 0.95);
        color: #ff7d4d;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .container {
            grid-template-columns: 1fr;
            gap: 2vh;
            padding: 0 2vw;
        }

        .class-home-box {
            padding: 2vh 3vw;
            min-height: 40vh;
        }

        .class-box-title {
            font-size: clamp(1.1rem, 4vw, 1.4rem);
        }

        .class-main-item {
            padding: 2vh 3vw;
            flex-direction: column;
            align-items: flex-start;
            gap: 1vh;
            min-height: 8vh;
        }

        .home-title {
            margin-right: 0;
            white-space: normal;
            font-size: clamp(0.9rem, 3vw, 1.1rem);
        }

        .home-date {
            align-self: flex-end;
            font-size: clamp(0.8rem, 2.5vw, 1rem);
        }
    }

    /* 애니메이션 효과 */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(2vh);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .class-home-box {
        animation: fadeInUp 0.6s ease;
    }

    .class-home-box:nth-child(2) {
        animation-delay: 0.2s;
    }

    .class-main-item {
        animation: fadeInUp 0.4s ease;
    }

    .class-main-item:nth-child(even) {
        animation-delay: 0.1s;
    }

    .class-main-item:nth-child(odd) {
        animation-delay: 0.2s;
    }
</style>

<div class="homecontainer">
    <!-- 최근 공지 섹션 -->
    <div class="class-home-box">
        <div class="class-box-title">
            <i class="bi bi-megaphone-fill"></i>
            최근 공지
        </div>
        <c:choose>
            <c:when test="${not empty homenotice}">
                <c:forEach var="hn" items="${homenotice}">
                    <div class="class-main-item">
                        <span class="home-title">${hn.boardTitle}</span>
                        <span class="home-content">${hn.boardContent}</span>
                        <span class="home-date">${hn.boardDate}</span>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-message">
                    <i class="bi bi-info-circle"></i>
                    <div>등록된 공지가 없습니다.</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 최근 과제 섹션 -->
    <div class="class-home-box">
        <div class="class-box-title">
            <i class="bi bi-book"></i>
            최근 과제
        </div>
        <c:choose>
            <c:when test="${not empty homeassign}">
                <c:forEach var="an" items="${homeassign}">
                    <div class="class-main-item">
                        <span class="home-title">${an.scheduleWeek}주차과제</span>
<%--                        <button class="download-btn">--%>
<%--                            <i class="bi bi-download">다운로드</i>--%>
<%--                        </button>--%>
                        <a href="${pageContext.request.contextPath}/resources/upload/classes/assigns/${an.assignRename}"
                           download="${an.assignOriname}"
                           class="download-btn">
                            <i class="bi bi-download"></i>
                            다운로드
                        </a>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-message">
                    <i class="bi bi-clipboard-x"></i>
                    <div>등록된 과제가 없습니다.</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>