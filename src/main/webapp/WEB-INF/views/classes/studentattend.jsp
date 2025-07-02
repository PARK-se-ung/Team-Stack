<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생 출석부</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: white;
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

        .attendance-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .session-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            border: 2px solid #f0f0f0;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .session-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff8c42, #ff6b35);
        }

        .session-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            border-color: #ff8c42;
        }

        .session-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .session-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
        }

        .session-date {
            font-size: 0.9rem;
            color: #666;
            background: #fff4f0;
            padding: 5px 12px;
            border-radius: 20px;
        }

        .attendance-status {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 15px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1.1rem;
        }

        .status-attend {
            background: linear-gradient(135deg, #56ab2f, #a8e6cf);
            color: white;
        }

        .status-absent {
            background: linear-gradient(135deg, #ff6b6b, #ffa8a8);
            color: white;
        }

        .status-icon {
            font-size: 1.3rem;
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

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }

            .attendance-grid {
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
            <div class="course-details">담당강사:  | 수강기간: ${course.courseStartDate} ~ </div>
        </div>

        <div class="summary-section">
            <div class="summary-title">📊 출석 현황 요약</div>
            <div class="summary-stats">
                <div class="stat-item">
                    <div class="stat-number">${course.totalWeek}</div>
                    <div class="stat-label">총 수업</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${attendCount}</div>
                    <div class="stat-label">출석</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><fmt:formatNumber value="${course.totalWeek - attendCount}" type="number" maxFractionDigits="0"/></div>
                    <div class="stat-label">결석</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><fmt:formatNumber value="${(attendCount/course.totalWeek)*100}" type="number" maxFractionDigits="0"/>%</div>
                    <div class="stat-label">출석률</div>
                </div>
            </div>
        </div>


        <div class="attendance-grid">
            <c:forEach var="a" items="${attends}">
                <div class="session-card">
                    <div class="session-header">
                        <div class="session-title">${a.courseRound}회차</div>
                    </div>
                    <div class="attendance-status status-${a.attendStatus}">
                        <span class="status-icon">✓</span>
                        <span><c:choose>
                            <c:when test="${a.attendStatus == 'ABSENT'}">
                                결석
                            </c:when>
                            <c:otherwise>
                                출석
                            </c:otherwise>
                        </c:choose></span>
                    </div>
                </div>
            </c:forEach>

        </div>
    </div>
</div>
</body>
</html>
