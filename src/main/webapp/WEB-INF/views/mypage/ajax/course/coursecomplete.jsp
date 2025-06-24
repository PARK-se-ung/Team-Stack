<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 25. 6. 20.
  Time: 오후 2:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
  <div class="nav-item" data-nav="manage">강의 개설</div>
  <div class="nav-item" data-nav="courseapply">강의 개설 승인</div>
  <div class="nav-item" data-nav="studentapply">신청 학생 승인</div>
  <div class="nav-item" data-nav="coursetake">진행중인 강의</div>
  <div class="nav-item active" data-nav="coursecomplete">만료한 강의</div>
</div>
<!-- 아래 div안에서 필요한 html 코드 작성 -->
<div class="current-container">


  <style>

    .top-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      margin-bottom: 20px;
    }

    .search-box input {
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 8px;
      width: 220px;
    }

    .sort-select {
      padding: 8px;
      border-radius: 8px;
      border: 1px solid #ccc;
    }

    .view-toggle {
      margin-top: 10px;
    }

    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 20px;
    }

    .card {
      background: #fff;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      transition: transform 0.2s;
    }

    .card:hover {
      transform: scale(1.02);
    }

    .card img {
      width: 100%;
      height: 150px;
      object-fit: cover;
    }

    .card-body {
      padding: 12px;
    }

    .card-title {
      font-size: 16px;
      font-weight: bold;
      margin-bottom: 6px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .card-meta {
      font-size: 12px;
      color: #555;
    }
  </style>
  </head>
  <body>

  <div class="top-bar">
    <div class="search-box">
      <input type="text" placeholder="강의명, 지식공유자 이름 검색">
      <button class="btn btn-outline-orange">검색</button>
    </div>

    <div>
      <select class="sort-select">
        <option>제목순</option>
        <option>최신순</option>
        <option>인기순</option>
      </select>
    </div>
  </div>

  <div class="view-toggle">
    <strong><a>이미지형</a></strong> | <a>리스트형</a>
  </div>

  <div class="grid">
    <!-- 카드 예시 1 -->
    <div class="card">
      <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="강의 썸네일">
      <div class="card-body">
        <div class="card-title">[서초1동] 수학 A - 2025년 3분기</div>
        <div class="card-meta">2025-07-01 ~ 2025-09-23</div>
      </div>
    </div>

    <!-- 카드 예시 2 -->
    <div class="card">
      <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="강의 썸네일">
      <div class="card-body">
        <div class="card-title">[방배3동] 2025년 3분기 수강생 모집</div>
        <div class="card-meta">2025-07-02 ~ 2025-09-29</div>
      </div>
    </div>

    <!-- 필요한 만큼 반복 -->
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

</script>