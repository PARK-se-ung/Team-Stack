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
  <div class="header">
    <h1>📊 내 성적표</h1>
    <p>수강 중인 과목의 성적을 확인하세요</p>
  </div>

  <div class="content">
    <div class="course-info">
      <div class="course-title">웹 개발 기초 과정</div>
      <div class="course-details">담당강사: 김교수 | 수강기간: 2024.03.01 ~ 2024.05.31</div>
    </div>

    <div class="summary-section">
      <div class="summary-title">📈 성적 현황 요약</div>
      <div class="summary-stats">
        <div class="stat-item">
          <div class="stat-number">85.5</div>
          <div class="stat-label">총 평균</div>
        </div>
        <div class="stat-item">
          <div class="stat-number">A</div>
          <div class="stat-label">최종 등급</div>
        </div>
        <div class="stat-item">
          <div class="stat-number">7</div>
          <div class="stat-label">총 과제</div>
        </div>
        <div class="stat-item">
          <div class="stat-number">2</div>
          <div class="stat-label">시험</div>
        </div>
      </div>
    </div>

    <div class="grade-grid">
      <div class="grade-card">
        <div class="grade-header">
          <div class="grade-title">중간고사</div>
          <div class="grade-type">시험</div>
        </div>
        <div class="grade-details">
          <div class="grade-row">
            <span class="grade-label">시험일</span>
            <span class="grade-value">2024.04.15</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">만점</span>
            <span class="grade-value">100점</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">취득점수</span>
            <span class="grade-value">88점</span>
          </div>
        </div>
        <div class="grade-score score-excellent">
          <span class="score-icon">🏆</span>
          <span>우수 (88점)</span>
        </div>
      </div>

      <div class="grade-card">
        <div class="grade-header">
          <div class="grade-title">기말고사</div>
          <div class="grade-type">시험</div>
        </div>
        <div class="grade-details">
          <div class="grade-row">
            <span class="grade-label">시험일</span>
            <span class="grade-value">2024.05.20</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">만점</span>
            <span class="grade-value">100점</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">취득점수</span>
            <span class="grade-value">92점</span>
          </div>
        </div>
        <div class="grade-score score-excellent">
          <span class="score-icon">🏆</span>
          <span>우수 (92점)</span>
        </div>
      </div>

      <div class="grade-card">
        <div class="grade-header">
          <div class="grade-title">HTML 기초 과제</div>
          <div class="grade-type">과제</div>
        </div>
        <div class="grade-details">
          <div class="grade-row">
            <span class="grade-label">제출일</span>
            <span class="grade-value">2024.03.10</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">만점</span>
            <span class="grade-value">20점</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">취득점수</span>
            <span class="grade-value">18점</span>
          </div>
        </div>
        <div class="grade-score score-excellent">
          <span class="score-icon">✨</span>
          <span>우수 (18점)</span>
        </div>
      </div>

      <div class="grade-card">
        <div class="grade-header">
          <div class="grade-title">CSS 스타일링 과제</div>
          <div class="grade-type">과제</div>
        </div>
        <div class="grade-details">
          <div class="grade-row">
            <span class="grade-label">제출일</span>
            <span class="grade-value">2024.03.24</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">만점</span>
            <span class="grade-value">20점</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">취득점수</span>
            <span class="grade-value">16점</span>
          </div>
        </div>
        <div class="grade-score score-good">
          <span class="score-icon">👍</span>
          <span>양호 (16점)</span>
        </div>
      </div>

      <div class="grade-card">
        <div class="grade-header">
          <div class="grade-title">JavaScript 기초 과제</div>
          <div class="grade-type">과제</div>
        </div>
        <div class="grade-details">
          <div class="grade-row">
            <span class="grade-label">제출일</span>
            <span class="grade-value">2024.04.07</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">만점</span>
            <span class="grade-value">20점</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">취득점수</span>
            <span class="grade-value">15점</span>
          </div>
        </div>
        <div class="grade-score score-average">
          <span class="score-icon">📝</span>
          <span>보통 (15점)</span>
        </div>
      </div>

      <div class="grade-card">
        <div class="grade-header">
          <div class="grade-title">반응형 웹 과제</div>
          <div class="grade-type">과제</div>
        </div>
        <div class="grade-details">
          <div class="grade-row">
            <span class="grade-label">제출일</span>
            <span class="grade-value">2024.04.28</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">만점</span>
            <span class="grade-value">20점</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">취득점수</span>
            <span class="grade-value">19점</span>
          </div>
        </div>
        <div class="grade-score score-excellent">
          <span class="score-icon">🌟</span>
          <span>우수 (19점)</span>
        </div>
      </div>

      <div class="grade-card">
        <div class="grade-header">
          <div class="grade-title">웹사이트 프로젝트</div>
          <div class="grade-type">프로젝트</div>
        </div>
        <div class="grade-details">
          <div class="grade-row">
            <span class="grade-label">제출일</span>
            <span class="grade-value">2024.05.15</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">만점</span>
            <span class="grade-value">30점</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">취득점수</span>
            <span class="grade-value">26점</span>
          </div>
        </div>
        <div class="grade-score score-excellent">
          <span class="score-icon">🚀</span>
          <span>우수 (26점)</span>
        </div>
      </div>

      <div class="grade-card">
        <div class="grade-header">
          <div class="grade-title">출석 점수</div>
          <div class="grade-type">출석</div>
        </div>
        <div class="grade-details">
          <div class="grade-row">
            <span class="grade-label">총 수업</span>
            <span class="grade-value">12회</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">출석</span>
            <span class="grade-value">10회</span>
          </div>
          <div class="grade-row">
            <span class="grade-label">출석률</span>
            <span class="grade-value">83%</span>
          </div>
        </div>
        <div class="grade-score score-good">
          <span class="score-icon">📅</span>
          <span>양호 (출석률 83%)</span>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>