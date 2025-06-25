<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<div id="pdf-controls">
<%--    강의계획서--%>
</div>
<div class="pdf-pagination">
    <button id="prevpage" class="pdf-btn">이전</button>
    <span id="pageInfo" class="pdf-page-info">1 / ?</span>
    <button id="nextpage" class="pdf-btn">다음</button>
</div>
<div style="display: flex;justify-content: center">
    <canvas id="pdf-render" style="border:1px solid #ccc; max-height: 80vh"></canvas>
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
</style>
