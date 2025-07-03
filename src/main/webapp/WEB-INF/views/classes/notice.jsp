<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>

<div class="notice-container">
    <div class="notice-header">
        <div class="notice-header-content">
            <div class="notice-icon">
                <i class="bi bi-megaphone-fill"></i>
            </div>
            <h3 class="notice-title">공지사항</h3>
        </div>
        <div class="notice-badge">
            <span class="badge-text">${notice.size()}개</span>
        </div>
    </div>

    <div class="notice-content">
        <div class="accordion" id="noticeAccordion">
            <c:forEach var="n" items="${notice}" varStatus="st">
                <div class="notice-item">
                    <h2 class="accordion-header" id="heading${st.index}">
                        <button
                                class="notice-button"
                                type="button"
                                data-bs-toggle="collapse"
                                data-bs-target="#collapse${st.index}"
                                aria-expanded="false"
                                aria-controls="collapse${st.index}">
                            <div class="notice-button-content">
                                <div class="notice-text">
                                    <span class="notice-item-title">${n.boardTitle}</span>
                                    <span class="notice-item-date">
                                        <i class="bi bi-calendar3"></i>
                                        ${n.boardDate}
                                    </span>
                                </div>
                                <div class="notice-arrow">
                                    <i class="bi bi-chevron-down"></i>
                                </div>
                            </div>
                        </button>
                    </h2>
                    <div
                            id="collapse${st.index}"
                            class="accordion-collapse collapse"
                            aria-labelledby="heading${st.index}"
                            data-bs-parent="#noticeAccordion">
                        <div class="notice-body">
                            <div class="notice-content-text">
                                    ${n.boardContent}
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<style>
    .notice-container {
        background: linear-gradient(135deg, #ff7d4d 0%, #ff6b35 100%);
        border-radius: 20px;
        padding: 0;
        box-shadow: 0 20px 40px rgba(255, 125, 77, 0.15);
        overflow: hidden;
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .notice-header {
        background: rgba(255, 255, 255, 0.1);
        padding: 24px 28px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        backdrop-filter: blur(20px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .notice-header-content {
        display: flex;
        align-items: center;
        gap: 16px;
    }

    .notice-icon {
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

    .notice-title {
        color: #fff;
        font-size: 24px;
        font-weight: 700;
        margin: 0;
        letter-spacing: -0.5px;
    }

    .notice-badge {
        background: rgba(255, 255, 255, 0.2);
        padding: 8px 16px;
        border-radius: 20px;
        backdrop-filter: blur(10px);
    }

    .badge-text {
        color: #fff;
        font-size: 14px;
        font-weight: 600;
    }

    .notice-content {
        padding: 8px;
    }

    .notice-item {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 16px;
        margin-bottom: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.8);
    }

    .notice-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
    }

    .notice-item:last-child {
        margin-bottom: 0;
    }

    .notice-button {
        width: 100%;
        background: transparent;
        border: none;
        padding: 20px 24px;
        text-align: left;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .notice-button::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, rgba(255, 125, 77, 0.05) 0%, rgba(255, 107, 53, 0.05) 100%);
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .notice-button:hover::before {
        opacity: 1;
    }

    .notice-button:focus {
        outline: none;
        box-shadow: 0 0 0 3px rgba(255, 125, 77, 0.2);
    }

    .notice-button-content {
        display: flex;
        align-items: center;
        justify-content: space-between;
        position: relative;
        z-index: 1;
    }

    .notice-text {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .notice-item-title {
        color: #2d3748;
        font-size: 16px;
        font-weight: 600;
        line-height: 1.4;
        margin: 0;
    }

    .notice-item-date {
        color: #718096;
        font-size: 14px;
        display: flex;
        align-items: center;
        gap: 6px;
        font-weight: 500;
    }

    .notice-arrow {
        color: #a0aec0;
        font-size: 18px;
        transition: all 0.3s ease;
        margin-left: 16px;
    }

    .notice-button:not(.collapsed) .notice-arrow {
        transform: rotate(180deg);
        color: #ff7d4d;
    }

    .notice-body {
        background: #fafafa;
        border-top: 1px solid rgba(255, 125, 77, 0.1);
    }

    .notice-content-text {
        padding: 24px;
        color: #4a5568;
        line-height: 1.6;
        font-size: 15px;
        border-left: 4px solid #ff7d4d;
        background: #fff;
        margin: 0;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .notice-container {
            border-radius: 16px;
        }

        .notice-header {
            padding: 20px;
        }

        .notice-title {
            font-size: 20px;
        }

        .notice-icon {
            width: 40px;
            height: 40px;
            font-size: 18px;
        }

        .notice-button {
            padding: 16px 20px;
        }

        .notice-item-title {
            font-size: 15px;
        }

        .notice-content-text {
            padding: 20px;
            font-size: 14px;
        }
    }

    /* 애니메이션 */
    .notice-item {
        animation: fadeInUp 0.6s ease forwards;
        opacity: 0;
        transform: translateY(20px);
    }

    .notice-item:nth-child(1) { animation-delay: 0.1s; }
    .notice-item:nth-child(2) { animation-delay: 0.2s; }
    .notice-item:nth-child(3) { animation-delay: 0.3s; }
    .notice-item:nth-child(4) { animation-delay: 0.4s; }
    .notice-item:nth-child(5) { animation-delay: 0.5s; }

    @keyframes fadeInUp {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* 스크롤바 커스터마이징 */
    .notice-container::-webkit-scrollbar {
        width: 6px;
    }

    .notice-container::-webkit-scrollbar-track {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 3px;
    }

    .notice-container::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.3);
        border-radius: 3px;
    }

    .notice-container::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.5);
    }
</style>