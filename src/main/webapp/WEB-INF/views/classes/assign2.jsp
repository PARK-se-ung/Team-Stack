<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>

<style>
    .assignment-container {
        background: linear-gradient(135deg, #ff7d4d 0%, #ff6b35 100%);
        border-radius: 20px;
        padding: 0;
        box-shadow: 0 20px 40px rgba(255, 125, 77, 0.15);
        overflow: hidden;
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        margin-bottom: 20px;
    }

    .assignment-header {
        background: rgba(255, 255, 255, 0.1);
        padding: 24px 28px;
        display: flex;
        align-items: center;
        gap: 16px;
        backdrop-filter: blur(20px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .assignment-icon {
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

    .assignment-title {
        color: #fff;
        font-size: 24px;
        font-weight: 700;
        margin: 0;
        letter-spacing: -0.5px;
    }

    .assignment-content {
        padding: 8px;
    }

    .week-card {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 16px;
        margin: 12px 8px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.8);
    }

    .week-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
    }

    .week-card:last-child {
        margin-bottom: 8px;
    }

    .week-header {
        background: linear-gradient(135deg, #ff9966 0%, #ff8e53 100%);
        padding: 28px 24px;
        cursor: pointer;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        min-height: 80px;
        display: flex;
        align-items: center;
    }

    .week-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, rgba(255, 125, 77, 0.1) 0%, rgba(255, 107, 53, 0.1) 100%);
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .week-header:hover::before {
        opacity: 1;
    }

    .week-header.collapsed {
        background: linear-gradient(135deg, #ff7d4d 0%, #ff6b35 100%);
    }

    .week-title {
        color: #fff;
        font-size: 18px;
        font-weight: 700;
        margin: 0;
        display: flex;
        align-items: center;
        justify-content: space-between;
        position: relative;
        z-index: 1;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        width: 100%;
    }

    .week-title-text {
        color: #2d3748;
        font-size: 16px;
        font-weight: 700;
        text-shadow: none;
        padding: 6px 12px;
        border-radius: 12px;
        background: rgba(255, 255, 255, 0.9);
    }

    .week-badge {
        background: rgba(255, 255, 255, 0.9);
        color: #ff6b35;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: 700;
        backdrop-filter: blur(10px);
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .chevron-icon {
        transition: transform 0.3s ease;
        font-size: 20px;
        color: #fff;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .week-header:not(.collapsed) .chevron-icon {
        transform: rotate(180deg);
    }

    .week-content {
        background: #fafafa;
        padding: 0;
    }

    .student-assignment {
        padding: 16px 20px;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        display: flex;
        align-items: center;
        justify-content: space-between;
        transition: all 0.3s ease;
        position: relative;
    }

    .student-assignment:last-child {
        border-bottom: none;
    }

    .student-assignment:hover {
        background: rgba(255, 125, 77, 0.05);
    }

    .student-info {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .student-details {
        display: flex;
        flex-direction: column;
    }

    .student-name {
        font-weight: 600;
        color: #2d3748;
        font-size: 15px;
        margin: 0;
    }

    .student-id {
        color: #718096;
        font-size: 13px;
        margin: 0;
    }

    .download-btn {
        background: linear-gradient(135deg, #ff944d 0%, #ff7b1f 100%);
        color: #fff;
        padding: 10px 16px;
        border-radius: 8px;
        text-decoration: none;
        font-size: 13px;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 6px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 8px rgba(255, 148, 77, 0.3);
        border: none;
    }

    .download-btn:hover {
        background: linear-gradient(135deg, #ff7b1f 0%, #e6691a 100%);
        transform: translateY(-1px);
        box-shadow: 0 6px 12px rgba(255, 148, 77, 0.4);
        text-decoration: none;
        color: #fff;
    }

    .download-btn i {
        font-size: 14px;
    }

    .no-submissions {
        padding: 40px 20px;
        text-align: center;
        color: #718096;
        background: rgba(255, 255, 255, 0.5);
    }

    .no-submissions-icon {
        font-size: 32px;
        color: #cbd5e1;
        margin-bottom: 12px;
    }

    .no-submissions-text {
        font-size: 15px;
        font-weight: 500;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .assignment-container {
            border-radius: 16px;
        }

        .assignment-header {
            padding: 20px;
        }

        .assignment-title {
            font-size: 20px;
        }

        .assignment-icon {
            width: 40px;
            height: 40px;
            font-size: 18px;
        }

        .student-assignment {
            flex-direction: column;
            align-items: flex-start;
            gap: 12px;
            padding: 16px;
        }

        .download-btn {
            align-self: stretch;
            justify-content: center;
        }

        .week-header {
            padding: 24px 20px;
            min-height: 70px;
        }

        .week-title {
            font-size: 16px;
        }

        .week-title-text {
            font-size: 14px;
        }
    }

    /* 애니메이션 */
    .week-card {
        animation: fadeInUp 0.6s ease forwards;
        opacity: 0;
        transform: translateY(20px);
    }

    .week-card:nth-child(1) { animation-delay: 0.1s; }
    .week-card:nth-child(2) { animation-delay: 0.2s; }
    .week-card:nth-child(3) { animation-delay: 0.3s; }
    .week-card:nth-child(4) { animation-delay: 0.4s; }
    .week-card:nth-child(5) { animation-delay: 0.5s; }

    @keyframes fadeInUp {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* 커스텀 Accordion 스타일 */
    .custom-accordion .accordion-item {
        border: none;
        background: transparent;
    }

    .custom-accordion .accordion-button {
        background: transparent;
        border: none;
        padding: 0;
        box-shadow: none;
    }

    .custom-accordion .accordion-button:focus {
        box-shadow: none;
    }

    .custom-accordion .accordion-button::after {
        display: none;
    }

    .custom-accordion .accordion-collapse {
        border: none;
    }

    .custom-accordion .accordion-body {
        padding: 0;
    }
</style>

<div class="assignment-container">
    <div class="assignment-header">
        <div class="assignment-icon">
            <i class="bi bi-clipboard-check"></i>
        </div>
        <h3 class="assignment-title">과제 관리</h3>
    </div>

    <div class="assignment-content">
        <div class="accordion custom-accordion" id="assignmentAccordion">
            <c:forEach var="ss" items="${schedules}" varStatus="st">
                <div class="week-card">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="heading${st.index}">
                            <button
                                    class="accordion-button collapsed week-header"
                                    type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#collapse${st.index}"
                                    aria-expanded="false"
                                    aria-controls="collapse${st.index}">
                                <div class="week-title">
                                    <div class="d-flex align-items-center gap-3">
                                        <span class="week-badge">${ss.scheduleWeek}주차</span>
                                        <span class="week-title-text">과제 제출 현황</span>
                                    </div>
                                    <i class="bi bi-chevron-down chevron-icon"></i>
                                </div>
                            </button>
                        </h2>
                        <div
                                id="collapse${st.index}"
                                class="accordion-collapse collapse"
                                aria-labelledby="heading${st.index}"
                                data-bs-parent="#assignmentAccordion">
                            <div class="accordion-body week-content">
                                <c:set var="hasSubmissions" value="false" />
                                <c:forEach var="sa" items="${ss.studentAssigns}">
                                    <c:if test="${not empty sa.userId}">
                                        <c:set var="hasSubmissions" value="true" />
                                        <div class="student-assignment">
                                            <div class="student-info">
                                                <div class="student-details">
                                                    <div class="student-name">${sa.userName}</div>
                                                    <div class="student-id">${sa.userId}</div>
                                                </div>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/resources/upload/student/${sa.stuAssignRename}"
                                               download="${sa.stuAssignOriname}"
                                               class="download-btn">
                                                <i class="bi bi-download"></i>
                                                다운로드
                                            </a>
                                        </div>
                                    </c:if>
                                </c:forEach>

                                <c:if test="${not hasSubmissions}">
                                    <div class="no-submissions">
                                        <div class="no-submissions-icon">
                                            <i class="bi bi-inbox"></i>
                                        </div>
                                        <div class="no-submissions-text">
                                            과제를 제출한 학생이 없습니다
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>