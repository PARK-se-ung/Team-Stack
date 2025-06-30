<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 25. 6. 20.
  Time: 오후 2:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="org.ts.teamstack.course.model.dto.Course" %>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
  <div class="nav-item" data-nav="open">강의 개설</div>
  <div class="nav-item active" data-nav="courseapply">강의 개설 승인</div>
  <div class="nav-item" data-nav="studentapply">신청 학생 승인</div>
  <div class="nav-item" data-nav="coursetake">진행중인 강의</div>
  <div class="nav-item" data-nav="coursecomplete">만료한 강의</div>
</div>
<!-- 아래 div안에서 필요한 html 코드 작성 -->
<div class="current-container">


  <style>

    .container {
      margin: 40px auto;
      background: #fff;
      border-radius: 20px;
      padding: 30px;
    }

    h1 {
      font-size: 28px;
      margin-bottom: 30px;
    }

    .tabs {
      display: flex;
      border-bottom: 2px solid #ff7d4d;
      margin-bottom: 20px;
    }

    .tab {
      flex: 1;
      text-align: center;
      padding: 15px 0;
      cursor: pointer;
      font-weight: bold;
      background: #fff;
      border-radius: 10px 10px 0 0;
    }

    .tab.active {
      border-bottom: 2px solid #fff;
      background: #ff7d4d;
      color: white;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
    }

    thead {
      background: #f5f5f5;
    }

    th {
      font-size: 16px;
    }

    th, td {
      padding: 12px;
      text-align: left;
      border-bottom: 1px solid #ddd;
      vertical-align: top;
      font-size : 18px;
    }

    tr {
      font-weight: 500;
    }

    tr:hover {
      background-color: #fafafa;
    }

    .status {
      color: #333;
      font-weight: bold;
    }
  </style>

  <div class="container">

    <div class="tabs">
      <div class="tab active" onclick="showTab('pending')">승인 대기중</div>
      <div class="tab" onclick="showTab('result')">결과</div>
    </div>

    <!-- 승인 대기중 테이블 -->
    <div id="pending" class="tab-content">
      <table>
        <thead>
        <tr>
          <th>번호</th>
          <th>강의명</th>
          <th>교육기간</th>
          <th>접수기간</th>
          <th>상태</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td></td>
          <td>[서초1동] 헬스 오후 - 2025.3분기</td>
          <td>courseStartDate</td>
          <td>recuitDate</td>
          <td class="status">STAY</td>
        </tr>

        <!-- 생략된 나머지 항목들도 같은 형식으로 추가 -->
        </tbody>
      </table>
    </div>

    <!-- 결과 탭 내용 -->
    <div id="result" class="tab-content" style="display: none;">
      <table>
        <thead>
        <tr>
          <th>번호</th>
          <th>강의명</th>
          <th>교육기간</th>
          <th>접수기간</th>
          <th>상태</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td>1039</td>
          <td>[예시] 미술 심화 - 2025.3분기</td>
          <td>2025-07-01 ~ 2025-09-30</td>
          <td>2025-06-20 ~ 2025-06-27</td>
          <td class="status">승인완료</td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>





</div>

<!-- nav 전환 로직 -->
<script>
  $(".nav-item").on('click', function() {
    let $current = $(this);
    let tabId = $current.data('nav');
    $(".nav-item").removeClass("active");
    $current.addClass("active");
    tabLoad(tabId);
  });

  function showTab(tabId) {
    const tabs = document.querySelectorAll(".tab");
    const contents = document.querySelectorAll(".tab-content");

    // 모든 탭에서 active 제거, 콘텐츠 숨김
    tabs.forEach(tab => tab.classList.remove("active"));
    contents.forEach(content => content.style.display = "none");

    // 클릭한 탭 활성화 및 해당 콘텐츠 보이기
    const clickedTab = Array.from(tabs).find(tab => tab.textContent.includes(tabId === 'pending' ? '승인 대기중' : '결과'));
    if (clickedTab) clickedTab.classList.add("active");

    const targetContent = document.getElementById(tabId);
    if (targetContent) targetContent.style.display = "block";
  }

</script>