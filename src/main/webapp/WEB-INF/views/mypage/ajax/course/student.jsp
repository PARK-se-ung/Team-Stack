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

  .lecture-box {
    width: 100%;
    height: 500px;
    border : 1px solid #4E4E4E;
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    margin-bottom: 20px;
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
  <div class="lecture-box" onclick="location.href='${pageContext.request.contextPath}/course/detail?userId=${userId}'" style="cursor:pointer;">

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