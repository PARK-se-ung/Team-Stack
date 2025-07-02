<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <title>출결 관리</title>
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
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #e65100, #ff8c42);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .content {
            padding: 30px;
        }

        .session-list {
            display: grid;
            gap: 15px;
            margin-bottom: 30px;
        }

        .session-item {
            background: #fff8f0;
            border: 2px solid #ffcc80;
            border-radius: 15px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .session-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 140, 66, 0.1), transparent);
            transition: left 0.5s;
        }

        .session-item:hover::before {
            left: 100%;
        }

        .session-item:hover {
            border-color: #ff8c42;
            box-shadow: 0 8px 25px rgba(255, 140, 66, 0.2);
            transform: translateY(-2px);
        }

        .session-item.active {
            background: linear-gradient(135deg, #ff8c42, #ffa726);
            color: white;
            border-color: #e65100;
        }

        .session-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .session-title {
            font-size: 1.3rem;
            font-weight: 600;
        }

        .session-date {
            font-size: 0.95rem;
            opacity: 0.8;
        }

        .session-stats {
            display: flex;
            gap: 15px;
            margin-top: 10px;
            font-size: 0.9rem;
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.2);
            padding: 5px 12px;
            border-radius: 20px;
        }

        .student-list {
            display: none;
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            margin-top: 20px;
            border: 2px solid #ffcc80;
        }

        .student-list.active {
            display: block;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                max-height: 0;
            }
            to {
                opacity: 1;
                max-height: 1000px;
            }
        }

        .student-list h3 {
            color: #e65100;
            margin-bottom: 20px;
            font-size: 1.4rem;
            text-align: center;
        }

        .student-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 15px;
        }

        .student-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .student-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .student-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .student-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
        }

        .student-id {
            font-size: 0.9rem;
            color: #666;
        }

        .attendance-buttons {
            display: flex;
            gap: 10px;
        }

        .attendance-btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }

        .attendance-btn.present {
            background: #4caf50;
            color: white;
        }

        .attendance-btn.present:hover {
            background: #45a049;
            transform: scale(1.05);
        }

        .attendance-btn.absent {
            background: #f44336;
            color: white;
        }

        .attendance-btn.absent:hover {
            background: #da190b;
            transform: scale(1.05);
        }

        .attendance-btn.active {
            box-shadow: 0 0 0 3px rgba(255, 140, 66, 0.4);
            transform: scale(1.1);
        }

        .summary-bar {
            background: linear-gradient(135deg, #ff8c42, #ffa726);
            color: white;
            padding: 15px 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-around;
            text-align: center;
        }

        .summary-item h4 {
            font-size: 1.8rem;
            margin-bottom: 5px;
        }

        .summary-item p {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .save-btn {
            background: linear-gradient(135deg, #e65100, #ff8c42);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 25px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            float: right;
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        .save-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(230, 81, 0, 0.3);
        }

        @media (max-width: 768px) {
            .student-grid {
                grid-template-columns: 1fr;
            }

            .session-header {
                flex-direction: column;
                gap: 10px;
            }

            .session-stats {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>📚 ${course.getCourseTitle()}출결 관리</h1>
        <p>강의별 수강생 출석 현황을 관리하세요</p>
    </div>

    <div class="content">
        <div class="session-list">
            <c:forEach var="c" items="${classweeks}">
                <c:set var="attend" value="${attendCount[c] != null ? attendCount[c] : 0}" />
                <c:set var="absent" value="${totalStudentCount - attend}" />
                <div class="session-item" data-session="${c}">
                    <div class="session-header">
                        <div class="session-title">${c}회차</div>
                    </div>
                    <div class="session-stats">
                        <div class="stat-item">총 ${students.size()}명</div>
                        <div class="stat-item">출석${attend} 명</div>
                        <div class="stat-item">결석${absent} 명</div>
                    </div>
                </div>
            </c:forEach>
            <div class="student-list" id="studentList">
                <h3 id="studentListTitle">📋회차 수강생 출석 체크</h3>

                <div class="summary-bar">
                    <div class="summary-item">
                        <h4 id="totalCount">${students.size()}</h4>
                        <p>총 수강생</p>
                    </div>
                    <div class="summary-item">
                        <h4 id="presentCount">0</h4>
                        <p>출석</p>
                    </div>
                    <div class="summary-item">
                        <h4 id="absentCount">0</h4>
                        <p>결석</p>
                    </div>
                </div>
                <div class="student-grid" id="studentGrid">
                <c:forEach var="s" items="${students}">
                        <div class="student-card" data-name="${s}" data-courseno="${course.courseNo}">
                            <div class="student-info">
                                <div class="student-name">${s}</div>
                                <select name="attendanceStatus" class="attendance-select">
                                    <option value="ATTEND">출석</option>
                                    <option value="ABSENT">결석</option>
                                </select>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <button class="save-btn" onclick="saveAttendance()">💾 출석 저장</button>
                <div style="clear: both;"></div>
            </div>
        </div>
    </div>
</div>



<script>
    let currentSession = null;
    // 회차 클릭 토글 이벤트
    document.querySelectorAll('.session-item').forEach(item => {
        item.addEventListener('click', function() {
            const studentList = document.getElementById('studentList');
            const sessionId = this.dataset.session;

            // 같은 세션을 클릭한 경우 토글
            if (this.classList.contains('active')) {
                this.classList.remove('active');
                studentList.classList.remove('active');
                currentSession =null;
            } else {
                // 모든 세션 비활성화
                document.querySelectorAll('.session-item').forEach(s => s.classList.remove('active'));
                studentList.classList.remove('active');

                // 현재 세션 활성화
                this.classList.add('active');
                currentSession = sessionId;

                setTimeout(() => {
                    studentList.classList.add('active');
                    document.getElementById('studentListTitle').textContent =
                        `📋 ${sessionId}회차 수강생 출석 체크`;
                }, 100);

            }
        });
    });

    const saveAttendance = function(){
        const studentData =[];

        document.querySelectorAll('.student-card').forEach(card=>{
            const name = card.dataset.name;
            const attend = card.querySelector('.attendance-select').value;
            const courseNo = card.dataset.courseno;
            const courseCount = currentSession;
            studentData.push({
                userId: name,
                attendStatus : attend,
                courseNo : courseNo,
                courseRound :currentSession
            });
        });
        console.log(studentData);

        fetch("${pageContext.request.contextPath}/class/insertattend.do",{
            method:"post",
            headers : {
                "content-type" : "application/json"
            },
            body : JSON.stringify(studentData)
        })
            .then(response=>{
                if(!response.ok){
                    throw new Error('서버 오류가 발생 하였습니다.');
                    return response.json();
                }
            })
            .then(data=>{
                alert('저장에 완료되었습니다.')
            })
            .catch(error=>{
                console.log("에러 : ", error);
            })




    }


</script>
</body>
</html>