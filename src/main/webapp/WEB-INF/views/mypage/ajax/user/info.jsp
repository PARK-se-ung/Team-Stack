<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
    <div class="nav-item active" data-nav="info">개인 정보 수정</div>
    <div class="nav-item" data-nav="approval">강의 개설 자격 승인</div>
</div>
<!-- 아래 div안에서 필요한 html 코드 작성 -->
<div class="current-container">


    <h1>top nav test</h1>


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