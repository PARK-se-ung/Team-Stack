<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>강사 성적 관리</title>
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
      max-width: 1200px;
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
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .course-details h2 {
      font-size: 1.3rem;
      font-weight: 600;
      color: #333;
      margin-bottom: 5px;
    }

    .course-details p {
      color: #666;
      font-size: 0.95rem;
    }

    .course-stats {
      display: flex;
      gap: 20px;
    }

    .stat-box {
      text-align: center;
      padding: 10px 15px;
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .stat-number {
      font-size: 1.5rem;
      font-weight: 600;
      color: #ff6b35;
    }

    .stat-label {
      font-size: 0.8rem;
      color: #666;
      margin-top: 5px;
    }

    .controls {
      display: flex;
      gap: 15px;
      margin-bottom: 30px;
      align-items: center;
      flex-wrap: wrap;
    }

    .control-group {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .control-group label {
      font-weight: 500;
      color: #333;
      white-space: nowrap;
    }

    select, input {
      padding: 10px 15px;
      border: 2px solid #e0e0e0;
      border-radius: 8px;
      font-size: 0.95rem;
      transition: border-color 0.3s ease;
    }

    select:focus, input:focus {
      outline: none;
      border-color: #ff8c42;
    }

    .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 8px;
      font-size: 0.95rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .btn-primary {
      background: linear-gradient(135deg, #ff8c42, #ff6b35);
      color: white;
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(255, 107, 53, 0.3);
    }

    .btn-secondary {
      background: #6c757d;
      color: white;
    }

    .btn-secondary:hover {
      background: #5a6268;
    }

    .grade-table-container {
      background: white;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }

    .table-header {
      background: linear-gradient(135deg, #ff9a56, #ff6b35);
      color: white;
      padding: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .table-title {
      font-size: 1.2rem;
      font-weight: 500;
    }

    .grade-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 0.95rem;
    }

    .grade-table th {
      background: #f8f9fa;
      color: #333;
      padding: 15px 10px;
      text-align: center;
      font-weight: 600;
      border-bottom: 2px solid #e9ecef;
      position: sticky;
      top: 0;
      z-index: 10;
    }

    .grade-table td {
      padding: 12px 8px;
      text-align: center;
      border-bottom: 1px solid #e9ecef;
      vertical-align: middle;
    }

    .grade-table tbody tr:hover {
      background: #f8f9ff;
    }

    .student-name {
      font-weight: 500;
      color: #333;
      text-align: left !important;
      padding-left: 15px !important;
    }

    .grade-input {
      width: 60px;
      padding: 5px 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      text-align: center;
      font-size: 0.9rem;
    }

    .grade-input:focus {
      border-color: #ff8c42;
      outline: none;
    }

    .grade-total {
      background: #fff4f0 !important;
      font-weight: 600;
      color: #ff6b35;
    }

    .grade-letter {
      padding: 5px 10px;
      border-radius: 15px;
      font-weight: 500;
      font-size: 0.85rem;
    }

    .grade-a { background: #d4edda; color: #155724; }
    .grade-b { background: #cce5ff; color: #004085; }
    .grade-c { background: #fff3cd; color: #856404; }
    .grade-d { background: #f8d7da; color: #721c24; }

    .save-section {
      padding: 20px;
      background: #f8f9fa;
      border-top: 1px solid #e9ecef;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .save-info {
      color: #666;
      font-size: 0.9rem;
    }

    .summary-cards {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .summary-card {
      background: white;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
      text-align: center;
      border-top: 4px solid #ff8c42;
    }

    .summary-card h3 {
      color: #333;
      margin-bottom: 10px;
      font-size: 0.9rem;
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    .summary-card .number {
      font-size: 2rem;
      font-weight: 600;
      color: #ff6b35;
    }

    @media (max-width: 768px) {
      .header h1 {
        font-size: 2rem;
      }

      .content {
        padding: 20px;
      }

      .course-info {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
      }

      .controls {
        flex-direction: column;
        align-items: stretch;
      }

      .grade-table-container {
        overflow-x: auto;
      }

      .grade-table {
        min-width: 800px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="header">
    <h1>📊 성적 관리</h1>
    <p>수강생들의 성적을 입력하고 관리하세요</p>
  </div>

  <div class="content">
    <div class="course-info">
      <div class="course-details">
        <h2>웹 개발 기초 과정</h2>
        <p>담당강사: 김교수 | 수강기간: 2024.03.01 ~ 2024.05.31</p>
      </div>
      <div class="course-stats">
        <div class="stat-box">
          <div class="stat-number">15</div>
          <div class="stat-label">총 수강생</div>
        </div>
        <div class="stat-box">
          <div class="stat-number">82.5</div>
          <div class="stat-label">반 평균</div>
        </div>
      </div>
    </div>

    <div class="summary-cards">
      <div class="summary-card">
        <h3>A 등급</h3>
        <div class="number">5명</div>
      </div>
      <div class="summary-card">
        <h3>B 등급</h3>
        <div class="number">7명</div>
      </div>
      <div class="summary-card">
        <h3>C 등급</h3>
        <div class="number">2명</div>
      </div>
      <div class="summary-card">
        <h3>D 등급</h3>
        <div class="number">1명</div>
      </div>
    </div>

    <div class="controls">
      <div class="control-group">
        <label for="examSelect">평가 항목:</label>
        <select id="examSelect">
          <option value="all">전체 보기</option>
          <option value="midterm">중간고사</option>
          <option value="final">기말고사</option>
          <option value="assignment1">과제1</option>
          <option value="assignment2">과제2</option>
          <option value="project">프로젝트</option>
        </select>
      </div>
      <div class="control-group">
        <label for="searchStudent">학생 검색:</label>
        <input type="text" id="searchStudent" placeholder="학생 이름 입력">
      </div>
      <button class="btn btn-primary" onclick="calculateGrades()">📊 성적 계산</button>
      <button class="btn btn-secondary" onclick="exportGrades()">📤 엑셀 내보내기</button>
    </div>

    <div class="grade-table-container">
      <div class="table-header">
        <div class="table-title">💯 학생 성적표</div>
        <div>총 15명</div>
      </div>

      <table class="grade-table">
        <thead>
        <tr>
          <th style="width: 100px;">번호</th>
          <th style="width: 120px;">학생명</th>
          <th style="width: 80px;">중간고사<br>(30%)</th>
          <th style="width: 80px;">기말고사<br>(30%)</th>
          <th style="width: 80px;">과제1<br>(10%)</th>
          <th style="width: 80px;">과제2<br>(10%)</th>
          <th style="width: 80px;">과제3<br>(15%)</th>
          <th style="width: 80px;">총점</th>
          <th style="width: 60px;">등급</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="student" items="${students}" varStatus="loop">
          <tr>
            <td>${loop.count}</td>
            <td class="student-name">${student.userId}</td>
            <td>
              <c:set var="found" value="false"/>
              <c:forEach var="s" items="${scores}">
                <c:if test="${s.userId == student.userId && s.scoreType == 'EXAM1'}">
                  <input type="number" class="grade-input" data-type="EXAM1" value="${s.score}" />
                  <c:set var="found" value="true"/>
                </c:if>
              </c:forEach>
              <c:if test="${!found}">
                <input type="number" class="grade-input" data-type="EXAM1" value="0" />
              </c:if>
            </td>
            <td>
              <c:set var="found" value="false"/>
              <c:forEach var="s" items="${scores}">
                <c:if test="${s.userId == student.userId && s.scoreType == 'EXAM2'}">
                  <input type="number" class="grade-input" data-type="EXAM2" value="${s.score}" />
                  <c:set var="found" value="true"/>
                </c:if>
              </c:forEach>
              <c:if test="${!found}">
                <input type="number"class="grade-input" data-type="EXAM2" value="0" />
              </c:if>
            </td>
            <td>
              <c:set var="found" value="false"/>
              <c:forEach var="s" items="${scores}">
                <c:if test="${s.userId == student.userId && s.scoreType == 'TASK1'}">
                  <input type="number" class="grade-input" data-type="TASK1" value="${s.score}" />
                  <c:set var="found" value="true"/>
                </c:if>
              </c:forEach>
              <c:if test="${!found}">
                <input type="number"class="grade-input" data-type="TASK1" value="0" />
              </c:if>
            </td><td>
            <c:set var="found" value="false"/>
            <c:forEach var="s" items="${scores}">
              <c:if test="${s.userId == student.userId && s.scoreType == 'TASK2'}">
                <input type="number" class="grade-input" data-type="TASK2" value="${s.score}" />
                <c:set var="found" value="true"/>
              </c:if>
            </c:forEach>
            <c:if test="${!found}">
              <input type="number" class="grade-input" data-type="TASK2" value="0" />
            </c:if>
          </td><td>
            <c:set var="found" value="false"/>
            <c:forEach var="s" items="${scores}">
              <c:if test="${s.userId == student.userId && s.scoreType == 'TASK3'}">
                <input type="number" class="grade-input"  data-type="TASK3" value="${s.score}" />
                <c:set var="found" value="true"/>
              </c:if>
            </c:forEach>
            <c:if test="${!found}">
              <input type="number" class="grade-input" data-type="TASK3" value="0" />
            </c:if>
          </td>
            <td class="grade-total"></td>
            <td><span class="grade-letter"></span></td>
          </tr>
        </c:forEach>

        </tbody>
      </table>
      <input type="hidden" id="courseNo" value="${course.courseNo}">
      <div class="save-section">
        <div class="save-info">
          💡 성적을 수정한 후 저장 버튼을 클릭하세요
        </div>
        <button class="btn btn-primary" onclick="saveGrades()">💾 성적 저장</button>
      </div>
    </div>
  </div>
</div>

<script>
    function calculateGrades() {
    const rows = document.querySelectorAll(".grade-table tbody tr");
    rows.forEach(row => {
    const inputs = row.querySelectorAll(".grade-input");
    let total = 0;
    inputs.forEach(input => {
    const type = input.dataset.type;
    const value = parseFloat(input.value) || 0;
    switch (type) {
    case "EXAM1": case "EXAM2": total += value * 0.3; break;
    case "TASK1": case "TASK2": total += value * 0.1; break;
    case "TASK3": total += value * 0.15; break;
  }
  });
    const totalCell = row.querySelector(".grade-total");
    const gradeCell = row.querySelector(".grade-letter");
    totalCell.textContent = total.toFixed(1);
    let grade = "F", gradeClass = "";
    if (total >= 90) grade = "A", gradeClass = "grade-a";
    else if (total >= 80) grade = "B", gradeClass = "grade-b";
    else if (total >= 70) grade = "C", gradeClass = "grade-c";
    else if (total >= 60) grade = "D", gradeClass = "grade-d";
    gradeCell.textContent = grade;
    gradeCell.className = `grade-letter ${gradeClass}`;
  });
  }

    function saveGrades() {
      const rows = document.querySelectorAll(".grade-table tbody tr");
      const scoreList = [];

      rows.forEach(row => {
        const userId = row.querySelector(".student-name").textContent.trim();
        const courseNo = document.getElementById("courseNo").value;

        const inputs = row.querySelectorAll(".grade-input");
        inputs.forEach(input => {
          const scoreType = input.dataset.type;
          const score = parseFloat(input.value) || 0;

          scoreList.push({
            userId: userId,
            courseNo: parseInt(courseNo),
            scoreType: scoreType,
            score: score
          });
        });
      });

      fetch("${pageContext.request.contextPath}/class/saveGrades.do", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(scoreList)
      })
              .then(response => {
                if (!response.ok) throw new Error("서버 오류");
                return response.text();
              })
              .then(data => {
              })
              .catch(error => {
                console.error("저장 실패:", error);
                alert("성적 저장 중 오류가 발생했습니다.");
              });
    }


    function exportGrades() {
    alert("엑셀 파일로 내보내기 기능을 구현해주세요!");
  }

    document.getElementById("searchStudent").addEventListener("input", function(e) {
    const keyword = e.target.value.toLowerCase();
    document.querySelectorAll(".grade-table tbody tr").forEach(row => {
    const name = row.querySelector(".student-name").textContent.toLowerCase();
    row.style.display = name.includes(keyword) ? "" : "none";
  });
  });

    // 실시간 성적 계산 반영

    document.addEventListener("input", function(e) {
    if (e.target.classList.contains("grade-input")) {
    calculateGrades();
  }
  });
</script>
</body>
</html>