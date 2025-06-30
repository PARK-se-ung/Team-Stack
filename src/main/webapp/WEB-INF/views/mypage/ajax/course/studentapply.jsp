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

<style>

  .lecture-card {
    display: flex;
    align-items: center;
    border-radius: 16px;
    padding: 20px;
    margin-bottom: 20px;
    cursor: pointer;
    transition: box-shadow 0.2s ease;
    border : 1px solid #ffc4ae;
  }

  .lecture-card:hover {
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }

  .lecture-thumbnail {
    width: 300px;
    height: 150px;
    background-color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 16px;
    margin-right: 24px;
    border-radius: 8px;
    border : 1px solid #6b7280;
  }

  .lecture-info {
    display: flex;
    flex-direction: column;
    gap: 8px;
    font-size: 16px;
  }

  .lecture-title {
    font-size: 20px;
    font-weight: bold;
  }

  .lecture-detail {
    color: #333;
  }
</style>

<div class="navs">
  <div class="nav-item" data-nav="open">강의 개설</div>
  <div class="nav-item" data-nav="courseapply">강의 개설 승인</div>
  <div class="nav-item active" data-nav="studentapply">신청 학생 승인</div>
  <div class="nav-item" data-nav="coursetake">진행중인 강의</div>
  <div class="nav-item" data-nav="coursecomplete">만료한 강의</div>
</div>
<!-- 아래 div안에서 필요한 html 코드 작성 -->
<c:if test="">

</c:if>
<div class="current-container" >
  <div class="lecture-card" onclick="location.href='/course/detail?courseId=123'">
  <div class="lecture-thumbnail">모집중인 강의</div>
  <div class="lecture-info">
    <div class="lecture-title">강의 제목</div>
    <div class="lecture-detail"></div>
    <div class="lecture-detail">2025.07.01 ~ 2025.08.15</div>
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

</script>