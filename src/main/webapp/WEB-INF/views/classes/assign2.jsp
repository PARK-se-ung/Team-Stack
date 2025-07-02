<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/classes.css">

<div class="class-notice-box">
    <div class="class-box-title">
        <i class="bi bi-clipboard-check"></i>
        과제
    </div>
    <div class="accordion" id="accordionExample">
        <c:forEach var="ss" items="${schedules}" varStatus="st">
            <div class="accordion-item">
                <h2 class="accordion-header" id="heading${st.index}">
                    <button
                            class="accordion-button collapsed"
                            type="button"
                            data-bs-toggle="collapse"
                            data-bs-target="#collapse${st.index}"
                            aria-expanded="false"
                            aria-controls="collapse${st.index}">
                            ${ss.scheduleWeek}주차
                    </button>
                </h2>
                <div
                        id="collapse${st.index}"
                        class="accordion-collapse collapse"
                        aria-labelledby="heading${st.index}"
                        data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <div>
                            <c:forEach var="sa" items="${ss.studentAssigns}">
                                <c:if test="${not empty sa.userId}">
                                    <div class="assigns d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center">
                                                ${sa.userName}(${sa.userId})
                                        </div>
                                        <div>
                                            <a href="${pageContext.request.contextPath}/resources/upload/student/${sa.stuAssignRename}"
                                               download="${sa.stuAssignOriname}"
                                               class="btn pdf-down witem float-end">
                                                <i class="bi bi-download"></i>
                                                과제파일 다운로드
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${empty sa.userId}">
                                    과제를 제출한 학생이 없습니다.
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    $(document).ready(function (){

    })
</script>
<style>
    /* 전체 박스 배경 */
    .class-notice-box {
        background-color: #ff7d4d;
        border-radius: 0.5rem;
        padding: 1rem;
    }

    /* 제목 영역 (아이콘 + 공지) */
    .class-notice-box .class-box-title {
        color: #fff;
        font-size: 1.25rem;
        margin-bottom: 0.75rem;
    }

    /* Accordion 아이템 자체 테두리 없애고 배경 맞춤 */
    .class-notice-box .accordion-item {
        background-color: transparent;
        border: none;
    }

    /* 닫힌/기본 상태의 버튼 */
    .class-notice-box .accordion-button {
        background-color: #ff7d4d;
        color: #fff;
        font-weight: bold;
    }

    /* 펼쳐진 상태의 버튼 */
    .class-notice-box .accordion-button:not(.collapsed) {
        background-color: #e0663a; /* #ff7d4d 보다 살짝 어두운 톤 */
        color: #fff;
    }

    /* 부트스트랩 화살표 아이콘 색상 반전 */
    .class-notice-box .accordion-button::after {
        filter: invert(100%);
    }

    /* 본문 영역 (펼쳐진 컨텐츠) */
    .class-notice-box .accordion-body {
        background-color: #ffe4d8; /* 연한 #ff7d4d 톤 */
        color: #333;
    }

    .assigns{
        height: 7vh;
    }
</style>