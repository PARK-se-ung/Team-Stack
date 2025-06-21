<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사이드바 페이지</title>
    <style>

    </style>
</head>
<body id="class-body">
<!-- 사이드바 -->
<div class="class-sidebar">
    <div class="logo"><img id="class-logo" alt="로고" src="${pageContext.request.contextPath}/resources/images/logo.png"> </div>
    <a href="">대시보드</a>
</div>

<!-- 본문 영역 -->
<div class="class-main-content">
    <h1>메인 페이지</h1>
    <p>이곳에 본문 내용이 들어갑니다.</p>
</div>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/classes.css"/>
</body>
</html>
