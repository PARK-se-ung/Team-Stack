<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


<style>
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

  .class-assign-item {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 16px;
    margin: 12px 8px;
    padding: 20px 24px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease;
    border: 1px solid rgba(255, 255, 255, 0.8);
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: relative;
    overflow: hidden;
  }

  .class-assign-item::before {
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

  .class-assign-item:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
  }

  .class-assign-item:hover::before {
    opacity: 1;
  }

  .class-assign-item:last-child {
    margin-bottom: 8px;
  }

  .class-week-week {
    position: relative;
    z-index: 1;
  }

  .class-week-week h5 {
    background: linear-gradient(135deg, #ff7d4d 0%, #ff6b35 100%);
    color: #fff;
    padding: 8px 16px;
    border-radius: 12px;
    font-size: 14px;
    font-weight: 600;
    margin: 0;
    display: inline-block;
    box-shadow: 0 4px 8px rgba(255, 125, 77, 0.3);
    letter-spacing: 0.5px;
  }

  .witem {
    padding: 0;
    margin: 0;
  }

  .pdf-down {
    background: linear-gradient(135deg, #ff944d 0%, #ff7b1f 100%);
    color: #fff;
    padding: 12px 20px;
    border-radius: 8px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 8px rgba(255, 148, 77, 0.3);
    border: none;
    position: relative;
    z-index: 1;
  }

  .pdf-down:hover {
    background: linear-gradient(135deg, #ff7b1f 0%, #e6691a 100%);
    transform: translateY(-1px);
    box-shadow: 0 6px 12px rgba(255, 148, 77, 0.4);
    text-decoration: none;
    color: #fff;
  }

  .pdf-down i {
    font-size: 14px;
  }

  /* 반응형 디자인 */
  @media (max-width: 768px) {
    .class-notice-box {
      border-radius: 16px;
    }

    .class-box-title {
      padding: 20px;
      font-size: 20px;
    }

    .class-box-title i {
      width: 40px;
      height: 40px;
      font-size: 18px;
    }

    .class-assign-item {
      padding: 16px 20px;
      flex-direction: column;
      align-items: flex-start;
      gap: 12px;
    }

    .pdf-down {
      align-self: stretch;
      justify-content: center;
    }
  }

  /* 애니메이션 */
  .class-assign-item {
    animation: fadeInUp 0.6s ease forwards;
    opacity: 0;
    transform: translateY(20px);
  }

  .class-assign-item:nth-child(2) { animation-delay: 0.1s; }
  .class-assign-item:nth-child(3) { animation-delay: 0.2s; }
  .class-assign-item:nth-child(4) { animation-delay: 0.3s; }
  .class-assign-item:nth-child(5) { animation-delay: 0.4s; }
  .class-assign-item:nth-child(6) { animation-delay: 0.5s; }

  @keyframes fadeInUp {
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  /* 과제가 없을 때 스타일 */
  .no-assignments {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 16px;
    padding: 40px;
    text-align: center;
    margin: 8px;
    color: #4a5568;
  }

  .no-assignments i {
    font-size: 48px;
    color: #ff9966;
    margin-bottom: 16px;
  }
</style>

<div class="class-notice-box">
  <div class="class-box-title">
    <i class="bi bi-clipboard-check"></i>
    과제
  </div>
  <c:forEach var="w" items="${week}">
    <c:if test="${not empty w.assignOriname}">
      <div class="class-assign-item">
        <div class="class-week-week witem">
          <h5>${w.scheduleWeek}주차</h5>
        </div>
        <a href="${pageContext.request.contextPath}/resources/upload/${w.assignRename}"
           download="${w.assignOriname}"
           class="btn pdf-down witem">
          <i class="bi bi-download"></i>
          과제파일 다운로드
        </a>
      </div>
    </c:if>
  </c:forEach>


  <c:set var="hasAssignment" value="false" />
  <c:forEach var="w" items="${week}">
    <c:if test="${not empty w.assignOriname}">
      <c:set var="hasAssignment" value="true" />
    </c:if>
  </c:forEach>

  <c:if test="${empty week or not hasAssignment}">
    <div class="no-assignments">
      <i class="bi bi-clipboard-x"></i>
      <div>등록된 과제가 없습니다</div>
    </div>
  </c:if>
</div>