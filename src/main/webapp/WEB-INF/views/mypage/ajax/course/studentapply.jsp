<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<!-- 상단 탭이 존재하는 경우 -->

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

  .current-container .grid {
    display: grid;
    grid-template-columns: repeat(1, 1fr);
    gap: 20px;
  }
  .applystudents{
    display:flex;
    justify-content: space-around;
    width:100%;
    padding:0;
    margin: 0;
  }
  .applystudents>li{
    list-style-type: none;
  }
</style>

<div class="navs">
  <div class="nav-item" data-nav="open">강의 개설</div>
  <div class="nav-item" data-nav="courseapply">강의 개설 승인</div>
  <div class="nav-item active" data-nav="studentapply">신청 학생 승인</div>
  <div class="nav-item" data-nav="coursetake">진행중인 강의</div>
  <div class="nav-item" data-nav="coursecomplete">만료한 강의</div>
</div>
<div class="container">
  <!-- 승인 대기중 테이블 -->
  <div id="pending" class="tab-content">
    <table>
      <thead>
      <tr>
        <th>번호</th>
        <th>강의명</th>
        <th>신청자</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="apply" items="${searchApply}">
      <tr>
        <td>${apply.courseNo}</td>
        <td>${apply.courseTitle}</td>
        <td>
          <c:forEach var="user" items="${apply.applyUsers}">
            <ul class="applystudents">
              <li>${user.userId}</li>
              <li>${user.name}</li>
              <li>${user.userEmail}</li>
              <li><button class="btn btn-outline-orange" onclick="changeStatus(event)">승인</button></li>
              <li><button class="btn btn-outline-orange" onclick="deleteApply(event)">거절</button></li>
            </ul>
          </c:forEach>
        </td>
      </tr>
      </c:forEach>
    </table>
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


  async function changeStatus(e){
    const $ul=$(e.target).parents("ul");
    const userId=$ul.find("li")[0].innerText;
    const courseNo=$ul.parents("tr").find("td")[0].innerText;

    const response=await fetch("${pageContext.request.contextPath}/course/applychange",{
      method:"post",
      headers:{
        "Content-Type":"application/json;charset=UTF-8",
      },
      body:JSON.stringify({courseNo:courseNo,userId:userId})
    });
    if(response.ok){
      $(e.target).parents("ul").remove();
      alert("승인이 완료되었습니다.");
    }else{
      alert("승인실패 다시 시도하세요 :( ");
    }
  }

  async function deleteApply(e){
    const $ul=$(e.target).parents("ul");
    const userId=$ul.find("li")[0].innerText;
    const courseNo=$ul.parents("tr").find("td")[0].innerText;

    const response=await fetch("${pageContext.request.contextPath}/course/deleteApply",{
      method:"post",
      headers:{
        "Content-Type":"application/json;charset=UTF-8",
      },
      body:JSON.stringify({courseNo:courseNo,userId:userId})
    });
    if(response.ok){
      $(e.target).parents("ul").remove();
      alert("거절이 완료되었습니다.");
    }else{
      alert("거절실패 다시 시도하세요 :( ");
    }
  }


</script>