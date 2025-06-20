<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <link rel="stylesheet" href="${path}/resources/css/common.css">
    <link rel="stylesheet" href="${path}/resources/css/header.css">
    <link rel="stylesheet" href="${path}/resources/css/footer.css">
    <link rel="stylesheet" href="${path}/resources/css/page.css">
    <script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<!-- header -->
<header class="header">
    <div class="row flex-row justify-content-between">
        <!-- logo -->
        <div class="ms-3 col-lg-3 logo-container">
            <a href="" class="brand">
                <i class="bi bi-person-circle fs-4"></i>
                <span class="h4 mb-0">Team Stack</span>
            </a>
        </div>
        <!-- search -->
        <div class="col-lg-5 search">
            <i class="bi bi-search search-icon"></i>
            <input type="text" class="form-control" id="search" placeholder="Team Stack">
        </div>
        <!-- nav -->
        <div class="col-lg-2 top-nav">
            <div class="d-flex align-items-center">
                <a class="me-3" href="${pageContext.request.contextPath}/user/login.do">
                    로그인
                </a>
                <a class="me-3" href="">
                    관리자페이지
                </a>
                <a href="">
                    알람
                </a>
            </div>
        </div>
    </div>
</header>
