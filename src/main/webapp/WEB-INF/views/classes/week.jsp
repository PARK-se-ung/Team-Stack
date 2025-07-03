<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/classes.css">

<div class="class-week-box">
  <div class="class-box-title">
    <div class="title-icon">
      <i class="bi bi-list-check" style="font-size: 20px"></i>
    </div>
    <h3 class="title-text">주차학습</h3>
  </div>

  <div class="week-content">
    <c:forEach var="w" items="${week}" varStatus="status">
      <div class="class-week-item">
        <div class="week-header">
          <div class="week-number">
            <span class="week-label">${w.scheduleWeek}</span>
            <span class="week-text">주차</span>
          </div>

        </div>

        <div class="week-downloads">
          <c:if test="${not empty w.scheduleOriname}">
            <div class="download-item">
              <a href="${pageContext.request.contextPath}/resources/upload/${w.scheduleRename}"
                 download="${w.scheduleOriname}"
                 class="download-btn lecture-btn">
                <div class="btn-icon">
                  <i class="bi bi-file-earmark-text"></i>
                </div>
                <div class="btn-content">
                  <span class="btn-title">강의파일</span>
                  <span class="btn-subtitle">다운로드</span>
                </div>
                <div class="btn-arrow">
                  <i class="bi bi-download"></i>
                </div>
              </a>
            </div>
          </c:if>

          <c:if test="${not empty w.assignOriname}">
            <div class="download-item">
              <a href="${pageContext.request.contextPath}/resources/upload/${w.assignRename}"
                 download="${w.assignOriname}"
                 class="download-btn assignment-btn">
                <div class="btn-icon">
                  <i class="bi bi-file-earmark-check"></i>
                </div>
                <div class="btn-content">
                  <span class="btn-title">과제파일</span>
                  <span class="btn-subtitle">다운로드</span>
                </div>
                <div class="btn-arrow">
                  <i class="bi bi-download"></i>
                </div>
              </a>
            </div>
          </c:if>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<style>
  .class-week-box {
    background: #fff;
    border-radius: 16px;
    padding: 0;
    box-shadow: 0 8px 32px rgba(255, 125, 77, 0.08);
    border: 1px solid rgba(255, 125, 77, 0.1);
    overflow: hidden;
  }

  .class-box-title {
    background: linear-gradient(135deg, #ff7d4d 0%, #ff6b35 100%);
    padding: 24px 28px;
    display: flex;
    align-items: center;
    gap: 16px;
    color: #fff;
    position: relative;
    overflow: hidden;
  }

  .class-box-title::before {
    content: '';
    position: absolute;
    top: 0;
    right: 0;
    width: 100px;
    height: 100px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    transform: translate(30%, -30%);
  }

  .title-icon {
    /* 기존 스타일 유지 */
    background: rgba(255, 255, 255, 0.2);
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 3.5vh;
  }

  .title-text {
    font-size: 24px;
    font-weight: 700;
    margin: 0;
    flex: 1;
    letter-spacing: -0.5px;
  }

  .title-badge {
    background: rgba(255, 255, 255, 0.2);
    padding: 8px 16px;
    border-radius: 20px;
    backdrop-filter: blur(10px);
  }

  .badge-count {
    font-size: 14px;
    font-weight: 600;
  }

  .week-content {
    padding: 8px;
  }

  .class-week-item {
    background: #fff;
    border-radius: 12px;
    margin-bottom: 12px;
    border: 1px solid #f1f5f9;
    overflow: hidden;
    transition: all 0.3s ease;
  }

  .class-week-item:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(255, 125, 77, 0.1);
    border-color: rgba(255, 125, 77, 0.2);
  }

  .class-week-item:last-child {
    margin-bottom: 0;
  }

  .week-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 20px 24px;
    background: linear-gradient(135deg, #fff7f4 0%, #ffede6 100%);
    border-bottom: 1px solid #f1f5f9;
  }

  .week-number {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .week-label {
    font-size: 28px;
    font-weight: 800;
    color: #ff7d4d;
    line-height: 1;
  }

  .week-text {
    font-size: 16px;
    font-weight: 600;
    color: #64748b;
  }

  .week-downloads {
    padding: 20px 24px;
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .download-item {
    width: 100%;
  }

  .download-btn {
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 16px 20px;
    background: #fff;
    border: 2px solid #f1f5f9;
    border-radius: 12px;
    text-decoration: none;
    transition: all 0.3s ease;
    width: 100%;
    position: relative;
    overflow: hidden;
  }

  .download-btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 125, 77, 0.05), transparent);
    transition: left 0.5s;
  }

  .download-btn:hover::before {
    left: 100%;
  }

  .download-btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(255, 125, 77, 0.15);
    border-color: #ff7d4d;
    text-decoration: none;
  }

  .lecture-btn .btn-icon {
    background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
    color: #fff;
  }

  .assignment-btn .btn-icon {
    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
    color: #fff;
  }

  .btn-icon {
    width: 48px;
    height: 48px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    flex-shrink: 0;
  }

  .btn-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 2px;
  }

  .btn-title {
    font-size: 16px;
    font-weight: 600;
    color: #1e293b;
  }

  .btn-subtitle {
    font-size: 14px;
    color: #64748b;
    font-weight: 500;
  }

  .btn-arrow {
    color: #94a3b8;
    font-size: 18px;
    transition: all 0.3s ease;
  }

  .download-btn:hover .btn-arrow {
    color: #ff7d4d;
    transform: translateX(4px);
  }

  /* 반응형 디자인 */
  @media (max-width: 768px) {
    .class-box-title {
      padding: 20px;
    }

    .title-text {
      font-size: 20px;
    }

    .week-content {
      padding: 4px;
    }

    .week-header {
      padding: 16px 20px;
    }

    .week-label {
      font-size: 24px;
    }

    .week-text {
      font-size: 14px;
    }

    .week-downloads {
      padding: 16px 20px;
    }

    .download-btn {
      padding: 14px 16px;
      gap: 12px;
    }

    .btn-icon {
      width: 40px;
      height: 40px;
      font-size: 18px;
    }

    .btn-title {
      font-size: 14px;
    }

    .btn-subtitle {
      font-size: 12px;
    }
  }

  /* 애니메이션 */
  .class-week-item {
    animation: fadeInUp 0.6s ease forwards;
    opacity: 0;
    transform: translateY(20px);
  }

  .class-week-item:nth-child(1) { animation-delay: 0.1s; }
  .class-week-item:nth-child(2) { animation-delay: 0.2s; }
  .class-week-item:nth-child(3) { animation-delay: 0.3s; }
  .class-week-item:nth-child(4) { animation-delay: 0.4s; }
  .class-week-item:nth-child(5) { animation-delay: 0.5s; }
  .class-week-item:nth-child(6) { animation-delay: 0.6s; }

  @keyframes fadeInUp {
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
</style>