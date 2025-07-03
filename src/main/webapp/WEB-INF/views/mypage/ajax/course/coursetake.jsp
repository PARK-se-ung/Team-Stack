<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 25. 6. 20.
  Time: 오후 2:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
  <div class="nav-item" data-nav="open">강의 개설</div>
  <div class="nav-item" data-nav="courseapply">강의 개설 승인</div>
  <div class="nav-item" data-nav="studentapply">신청 학생 승인</div>
  <div class="nav-item active" data-nav="coursetake">진행중인 강의</div>
  <div class="nav-item" data-nav="coursecomplete">만료한 강의</div>
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

    .current-container .grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 20px;
    }
  </style>
  </head>

  <div class="top-bar">
    <div class="search-box">
      <input type="text" placeholder="강의명 검색" id="searchKeyword" name="keyword">
      <button class="btn btn-outline-orange" id="searchBtn">검색</button>
    </div>

    <div>
      <select id="sortSelect" class="sort-select">
        <option value="title">제목순</option>
        <option value="recent">최신순</option>
      </select>
    </div>
  </div>

  <div class="grid">
    <c:forEach var="course" items="${takeCourses}">
      <!-- 시작일·총 주수를 data 속성으로 저장 -->
      <div class="card"
           data-start="${course.courseStartDate}"
           data-weeks="${course.totalWeek}"
           onclick="location.href='${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${course.courseNo}'">
        <img src="${pageContext.request.contextPath}/resources/images/${course.thumbnail}"
             alt="강의 썸네일">
        <div class="card-body">
          <div class="card-title">${course.courseTitle}</div>
          <div class="card-meta">
            <!-- 시작일 -->
            <span class="card-meta-start">${course.courseStartDate}</span>
            ~
            <!-- JS로 채워질 종료일 자리 -->
            <span class="card-meta-end">${course.courseEndDate}</span>
          </div>
        </div>
      </div>
    </c:forEach>
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


  // 검색 버튼 클릭
  $(document).on('click', '#searchBtn', function(){
    const q = $('#searchKeyword').val().trim().toLowerCase();

    // 입력이 비었으면 모두 표시
    if (!q) {
      $('.card').show();
      return;
    }

    $('.card').each(function(){
      const title = $(this).find('.card-title').text().toLowerCase();
      // 제목에 키워드가 포함되면 보이고, 아니면 숨김
      title.indexOf(q) !== -1 ? $(this).show() : $(this).hide();
    });
  });

  $('#searchKeyword').on('keypress', function(e){
    if (e.which === 13) $('#searchBtn').click();
  });

  // 정렬 셀렉트 변경 처리
  $(document).on('change', '#sortSelect', function(){
    const order = this.value; // "title" 또는 "recent"
    const $grid = $('.grid');
    // 현재 카드들을 배열로 꺼내기
    const cards = $grid.find('.card').get();

    cards.sort((a, b) => {
      if (order === 'title') {
        // 카드 타이틀 텍스트로 오름차순 정렬
        const ta = $(a).find('.card-title').text().trim().toLowerCase();
        const tb = $(b).find('.card-title').text().trim().toLowerCase();
        return ta.localeCompare(tb);
      } else if (order === 'recent') {
        // 시작일(data-start) 기준 내림차순 (최신순)
        const da = new Date(a.dataset.start);
        const db = new Date(b.dataset.start);
        return db - da;
      }
      return 0;
    });

    // 정렬된 순서대로 다시 붙여 넣기
    $grid.append(cards);
  });




</script>