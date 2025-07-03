<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>학생 성적 조회</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f5f5f5;
      min-height: 100vh;
      padding: 20px;
    }

    .container {
      max-width: 1000px;
      margin: 0 auto;
      background: white;
      border-radius: 15px;
      box-shadow: 0 20px 40px rgba(0,0,0,0.1);
      overflow: hidden;
    }

    .header {
      background: linear-gradient(135deg, #ff8c42 0%, #ff6b35 100%);
      color: white;
      padding: 30px;
      text-align: center;
    }

    .header h1 {
      font-size: 2.5rem;
      margin-bottom: 10px;
      font-weight: 300;
    }

    .header p {
      font-size: 1.1rem;
      opacity: 0.9;
    }

    .content {
      padding: 30px;
    }

    .course-info {
      background: #fff4f0;
      border-radius: 10px;
      padding: 20px;
      margin-bottom: 30px;
      border-left: 5px solid #ff8c42;
    }

    .course-title {
      font-size: 1.3rem;
      font-weight: 600;
      color: #333;
      margin-bottom: 5px;
    }

    .course-details {
      color: #666;
      font-size: 0.95rem;
    }

    .summary-section {
      background: linear-gradient(135deg, #ff9a56, #ff6b35);
      color: white;
      border-radius: 12px;
      padding: 25px;
      margin-bottom: 30px;
      text-align: center;
    }

    .summary-title {
      font-size: 1.4rem;
      margin-bottom: 20px;
      font-weight: 300;
    }

    .summary-stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
      gap: 20px;
    }

    .stat-item {
      background: rgba(255,255,255,0.2);
      border-radius: 10px;
      padding: 15px;
      backdrop-filter: blur(10px);
    }

    .stat-number {
      font-size: 2rem;
      font-weight: 600;
      margin-bottom: 5px;
    }

    .stat-label {
      font-size: 0.9rem;
      opacity: 0.9;
    }

    .grade-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 20px;
      margin-top: 20px;
    }

    .grade-card {
      background: white;
      border-radius: 12px;
      padding: 20px;
      border: 2px solid #f0f0f0;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .grade-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(90deg, #ff8c42, #ff6b35);
    }

    .grade-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(0,0,0,0.1);
      border-color: #ff8c42;
    }

    .grade-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }

    .grade-title {
      font-size: 1.2rem;
      font-weight: 600;
      color: #333;
    }

    .grade-type {
      font-size: 0.9rem;
      color: #666;
      background: #fff4f0;
      padding: 5px 12px;
      border-radius: 20px;
    }

    .grade-details {
      margin-bottom: 15px;
    }

    .grade-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 8px;
      padding: 8px 0;
      border-bottom: 1px solid #f0f0f0;
    }

    .grade-row:last-child {
      border-bottom: none;
      font-weight: 600;
      color: #ff6b35;
    }

    .grade-label {
      color: #666;
      font-size: 0.95rem;
    }

    .grade-value {
      font-weight: 500;
      color: #333;
    }

    .grade-score {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 15px;
      border-radius: 8px;
      font-weight: 500;
      font-size: 1.1rem;
      background: #f8f9fa;
      margin-top: 10px;
    }

    .score-excellent {
      background: linear-gradient(135deg, #56ab2f, #a8e6cf);
      color: white;
    }

    .score-good {
      background: linear-gradient(135deg, #4facfe, #00f2fe);
      color: white;
    }

    .score-average {
      background: linear-gradient(135deg, #ffa726, #ffcc02);
      color: white;
    }

    .score-poor {
      background: linear-gradient(135deg, #ff6b6b, #ffa8a8);
      color: white;
    }

    .score-icon {
      font-size: 1.3rem;
    }

    @media (max-width: 768px) {
      .header h1 {
        font-size: 2rem;
      }

      .grade-grid {
        grid-template-columns: 1fr;
      }

      .content {
        padding: 20px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="content">
    <div class="course-info">
      <div class="course-title">${course.courseTitle}</div>
      <div class="course-details">담당강사: 김교수 | 수강기간: ${course.courseStartDate}  ~ </div>
    </div>

    <div class="summary-section">
      <div class="summary-title">📈 성적 현황 요약</div>
      <div class="summary-stats">
        <div class="stat-item">
          <div class="stat-number">
            <c:set var="totalScore" value="0"/>
            <c:set var="examCount" value="0"/>
            <c:set var="taskCount" value="0"/>
            <c:forEach var="s" items="${scores}">
              <c:choose>
                <c:when test="${s.scoreType == 'EXAM1'}">
                  <c:set var="totalScore" value="${totalScore + (s.score * 0.25)}"/>
                  <c:set var="examCount" value="${examCount + 1}"/>
                </c:when>
                <c:when test="${s.scoreType == 'EXAM2'}">
                  <c:set var="totalScore" value="${totalScore + (s.score * 0.25)}"/>
                  <c:set var="examCount" value="${examCount + 1}"/>
                </c:when>
                <c:when test="${s.scoreType == 'TASK1'}">
                  <c:set var="totalScore" value="${totalScore + (s.score * 0.2)}"/>
                  <c:set var="taskCount" value="${taskCount + 1}"/>
                </c:when>
                <c:when test="${s.scoreType == 'TASK2'}">
                  <c:set var="totalScore" value="${totalScore + (s.score * 0.2)}"/>
                  <c:set var="taskCount" value="${taskCount + 1}"/>
                </c:when>
                <c:when test="${s.scoreType == 'TASK3'}">
                  <c:set var="totalScore" value="${totalScore + (s.score * 0.1)}"/>
                  <c:set var="taskCount" value="${taskCount + 1}"/>
                </c:when>
              </c:choose>
            </c:forEach>
            ${totalScore}
          </div>
          <div class="stat-label">총 평균</div>
        </div>
        <div class="stat-item">
          <div class="stat-number">
            <c:choose>
              <c:when test="${totalScore >= 95}">A+</c:when>
              <c:when test="${totalScore >= 90}">A</c:when>
              <c:when test="${totalScore >= 85}">B+</c:when>
              <c:when test="${totalScore >= 80}">B</c:when>
              <c:when test="${totalScore >= 75}">C+</c:when>
              <c:when test="${totalScore >= 70}">C</c:when>
              <c:when test="${totalScore >= 65}">D+</c:when>
              <c:when test="${totalScore >= 60}">D</c:when>
              <c:otherwise>F</c:otherwise>
            </c:choose>
          </div>
          <div class="stat-label">최종 등급</div>
        </div>
        <div class="stat-item">
          <div class="stat-number">${taskCount}</div>
          <div class="stat-label">총 과제</div>
        </div>
        <div class="stat-item">
          <div class="stat-number">${examCount}</div>
          <div class="stat-label">시험</div>
        </div>
      </div>
    </div>

    <div class="grade-grid">
      <!-- DB에서 가져온 성적 데이터 반복 -->
      <c:forEach var="s" items="${scores}">
        <div class="grade-card">
          <div class="grade-header">
            <div class="grade-title">
              <c:choose>
                <c:when test="${s.scoreType == 'EXAM1'}">중간평가</c:when>
                <c:when test="${s.scoreType == 'EXAM2'}">기말평가</c:when>
                <c:when test="${s.scoreType == 'TASK1'}">과제1</c:when>
                <c:when test="${s.scoreType == 'TASK2'}">과제2</c:when>
                <c:when test="${s.scoreType == 'TASK3'}">과제3</c:when>
                <c:otherwise>${s.scoreType}</c:otherwise>
              </c:choose>
            </div>
            <div class="grade-type">
              <c:choose>
                <c:when test="${s.scoreType == 'EXAM1' || s.scoreType == 'EXAM2'}">시험</c:when>
                <c:when test="${s.scoreType == 'TASK1' || s.scoreType == 'TASK2' || s.scoreType == 'TASK3'}">과제</c:when>
                <c:otherwise>기타</c:otherwise>
              </c:choose>
            </div>
          </div>
          <div class="grade-details">
            <div class="grade-row">
              <span class="grade-label">만점</span>
              <span class="grade-value">100점</span>
            </div>
            <div class="grade-row">
              <span class="grade-label">취득점수</span>
              <span class="grade-value">${s.score}점</span>
            </div>
            <div class="grade-row">
              <span class="grade-label">반영비율</span>
              <span class="grade-value">
                <c:choose>
                  <c:when test="${s.scoreType == 'EXAM1' || s.scoreType == 'EXAM2'}">25%</c:when>
                  <c:when test="${s.scoreType == 'TASK1' || s.scoreType == 'TASK2'}">20%</c:when>
                  <c:when test="${s.scoreType == 'TASK3'}">10%</c:when>
                  <c:otherwise>0%</c:otherwise>
                </c:choose>
              </span>
            </div>
            <div class="grade-row">
              <span class="grade-label">반영점수</span>
              <span class="grade-value">
                <c:choose>
                  <c:when test="${s.scoreType == 'EXAM1' || s.scoreType == 'EXAM2'}">${s.score * 0.25}점</c:when>
                  <c:when test="${s.scoreType == 'TASK1' || s.scoreType == 'TASK2'}">${s.score * 0.2}점</c:when>
                  <c:when test="${s.scoreType == 'TASK3'}">${s.score * 0.1}점</c:when>
                  <c:otherwise>0점</c:otherwise>
                </c:choose>
              </span>
            </div>
          </div>
          <c:choose>
            <c:when test="${s.score >= 90}">
              <div class="grade-score score-excellent">
                <span class="score-icon">🏆</span>
                <span>우수 (${s.score}점)</span>
              </div>
            </c:when>
            <c:when test="${s.score >= 80}">
              <div class="grade-score score-good">
                <span class="score-icon">👍</span>
                <span>양호 (${s.score}점)</span>
              </div>
            </c:when>
            <c:when test="${s.score >= 70}">
              <div class="grade-score score-average">
                <span class="score-icon">📝</span>
                <span>보통 (${s.score}점)</span>
              </div>
            </c:when>
            <c:otherwise>
              <div class="grade-score score-poor">
                <span class="score-icon">📉</span>
                <span>미흡 (${s.score}점)</span>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </c:forEach>
    </div>
  </div>
</div>
</body>
</html>