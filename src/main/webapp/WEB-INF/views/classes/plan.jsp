<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/classes.css">

<div class="pdf-pagination">
    <button id="prevpage" class="pdf-btn">이전</button>
    <span id="pageInfo" class="pdf-page-info">1 / ?</span>
    <button id="nextpage" class="pdf-btn">다음</button>
</div>

<div style="display: flex;justify-content: center">
    <canvas id="pdf-render" style="border:1px solid #ccc; max-height: 75vh"></canvas>
</div>
<div class="pdf-down-btn" >
    <a href="${pageContext.request.contextPath}/resources/pdf/${planfile.renamePlanName}"
       download="${planfile.originalPlanName}"
       class="btn pdf-down">
        PDF 다운로드
    </a>

</div>
<style>
    .pdf-pagination {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        margin: 16px 0;
    }

    .pdf-btn {
        padding: 8px 16px;
        font-size: 14px;
        background-color: #ff944d;
        color: #fff;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .pdf-btn:hover {
        background-color: #ff7b1f;
    }

    .pdf-page-info {
        font-size: 16px;
        font-weight: bold;
        color: #333;
    }


    .pdf-down{
        padding: 8px 16px;
        font-size: 14px;
        background-color: #ff944d;
        color: #fff;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
</style>