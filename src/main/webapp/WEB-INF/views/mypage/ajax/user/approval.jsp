<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
    <div class="nav-item" data-nav="info">개인 정보 수정</div>
    <div class="nav-item active" data-nav="approval">강의 개설 자격 승인</div>


</div>
<!-- 아래 div안에서 필요한 html 코드 작성 -->
<div class="approval-container">
    <form id="approveForm" enctype="multipart/form-data" method="post"
          <c:if test="${approveStatus != 'D' && not empty approveStatus}">style="pointer-events:none;opacity:0.5;"</c:if>>
        <div>
            <label for="approveFile" class="form-label">제출 서류 첨부:</label>
        </div>
        <div style="display: flex; align-items: center; gap: 10px; margin-top: 6px;">
            <input type="file" id="approveFile" name="approveFile" class="form-control"
                   accept=".pdf" required style="max-width:250px;"
                   <c:if test="${approveStatus != 'D' && not empty approveStatus}">disabled</c:if>>
            <button type="button" id="delBtn" class="btn btn-outline-danger" style="display:none;"
                    <c:if test="${approveStatus != 'D' && not empty approveStatus}">disabled</c:if>>삭제</button>
            <c:if test="${approveStatus == 'D' || empty approveStatus}">
                <button type="submit" class="btn btn-outline-orange">승인 요청</button>
            </c:if>
        </div>
    </form>
</div>

<c:if test="${not empty approveStatus}">
    <div>
        <b>승인 결과:</b>
        <c:choose>
            <c:when test="${approveStatus eq 'S'}">
                <span class="status-stay">대기중</span>
            </c:when>
            <c:when test="${approveStatus eq 'A'}">
                <span class="status-approve">승인됨</span>
            </c:when>
            <c:otherwise>
                <span class="status-deny">반려됨</span>
            </c:otherwise>
        </c:choose>
    </div>
</c:if>


<style>
    .approval-container { background: #f8f8f8; padding: 30px; border-radius: 12px; width: 900px; }
    .form-label { font-weight: bold; }
</style>
<!-- nav 전환 로직 -->
<script>
    $(".nav-item").on('click', function () {
        let $current = $(this);
        let tabId = $current.data('nav');
        $(".nav-item").removeClass("active");
        $current.addClass("active");
        tabLoad(tabId);
    });

    $("#delBtn").on("click", function() {
        $("#approveFile").val('');
        $(this).hide();
    });

    $("#approveForm").off('submit').on('submit', async function (e) {
        e.preventDefault();

        const formData = new FormData(this);

        try {
            const response = await fetch('${pageContext.request.contextPath}/mypage/requestapprove', {
                method: 'POST',
                body: formData
            });
            const result = await response.text();
            if (result === "success") {
                alert("승인 요청이 접수되었습니다.");
                tabLoad("approval");
            } else {
                alert("승인 요청에 실패했습니다.");
            }
        } catch (err) {
            alert("오류가 발생했습니다: " + err.message);
        }
    });

</script>
