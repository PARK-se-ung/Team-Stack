<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
    <div class="nav-item" data-nav="info">개인 정보 수정</div>
    <div class="nav-item active" data-nav="approval">강의 개설 자격 승인</div>

</div>
<!-- 아래 div안에서 필요한 html 코드 작성 -->

    <div class="approval-container">
        <p>제출 서류를 첨부하십시오</p>
        <div class="file-upload-row">
            <input type="file" id="fileInput" accept="" style="display:none" />
            <button id="fileBtn">파일첨부</button>
            <span id="fileName">선택된 파일 없음</span>
        </div>
        <button id="submitBtn" disabled>승인 요청</button>
        <div id="statusMsg" class="status-msg"></div>
    </div>

<style>
    .approval-container { background: #f8f8f8; padding: 30px; border-radius: 12px; width: 900px; }
    .file-upload-row { margin: 16px 0; }
    #fileName { margin-left: 10px; color: #666; }
    #submitBtn { margin-top: 12px; }
    .status-msg { margin-top: 16px; color: #007bff; }
</style>
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