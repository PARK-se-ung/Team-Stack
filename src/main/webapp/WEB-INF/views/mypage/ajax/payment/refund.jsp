<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
    <div class="nav-item" data-nav="sales">강의 판매 내역</div>
    <div class="nav-item active" data-nav="refund">환불 신청 조회</div>
</div>

<!-- 결제 관리 탭 -->
<div class="current-container">
    <!-- 검색/필터 영역 -->
    <div class="search-bar">
        <form method="get" action="" class="search-form">
            <input type="date" name="startDate" value="">
            <input type="date" name="endDate" value="">
            <select name="status">
                <option value="강사명">강사명</option>
                <option value="강의명">강의명</option>
            </select>
            <input type="text" name="lectureTitle" placeholder="강의명" value="">
            <button type="submit">검색</button>
        </form>
    </div>

    <table class="payment-table">
        <thead>
        <tr>
            <th>결제번호</th>
            <th>강의명</th>
            <th>구매자명</th>
            <th>결제일</th>
            <th>금액</th>
            <th>환불 신청</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${not empty refund}">
            <c:forEach var="r" items="${refund}">
                <tr>
                    <td>${r.paymentId}</td>
                    <td>${r.courseTitle}</td>
                    <td>${r.userName}</td>
                    <td style="text-align: center;">
                        <fmt:formatDate value="${r.paymentDate}" pattern="yyyy-MM-dd"/><br>
                        <fmt:formatDate value="${r.paymentDate}" pattern="HH:mm:ss"/>
                    </td>
                    <td>${r.paymentPrice}</td>
                    <td>
                        <c:choose>
                            <c:when test="${r.refundStatus == 'S'}">
                                <button class="btn-approveRefund"
                                        data-course-no="${r.courseNo}"
                                        data-imp-uid="${r.portoneId}"
                                        data-user-id="${r.userId}">
                                    환불 승인
                                </button>
                                <button class="btn-rejectRefund"
                                        data-course-no="${r.courseNo}"
                                        data-imp-uid="${r.portoneId}"
                                        data-user-id="${r.userId}">
                                    반려</button>
                            </c:when>
                            <c:when test="${r.refundStatus == 'A'}">
                                <span style="color:green;">승인 완료</span>
                            </c:when>
                            <c:when test="${r.refundStatus == 'D'}">
                                <span style="color:red;">반려됨</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color:#888;">-</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        <!-- 생략된 나머지 항목들도 같은 형식으로 추가 -->
        </tbody>
    </table>
    <div id="pageBar">
        ${pageBar}
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

    $(document).off('click', '.btn-approveRefund').on('click','.btn-approveRefund',function (e){
        if(!confirm("환불 승인하시겠습니까?")) return;

        const courseNo = $(e.target).data('course-no');
        const impUid = $(e.target).data('imp-uid');
        const userId = $(e.target).data('user-id');

    $.ajax({
        url: "${pageContext.request.contextPath}/payment/cancelPayment",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            "imp_uid": impUid,
            "reason": "사용자 요청 환불 강사 승인",
            "userId":userId,
            "courseNo":courseNo
        }),
        dataType: "text",
        success: function(result) {
            if(result === "success") {
                alert("환불이 승인되었습니다.");
                tabLoad('refund');
            } else {
                alert("환불 승인에 실패했습니다.");
            }
        },
        error: function() {
            alert("서버 오류로 환불 승인에 실패했습니다.");
        }
    });
    });

    $(document).off('click', '.btn-rejectRefund').on('click','.btn-rejectRefund',function (e){
        if(!confirm("환불 반려하시겠습니까?")) return;

        const courseNo = $(e.target).data('course-no');
        const impUid = $(e.target).data('imp-uid');
        const userId = $(e.target).data('user-id');

        $.ajax({
            url: "${pageContext.request.contextPath}/payment/denyRefund",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                "imp_uid": impUid,
                "userId":userId,
                "courseNo":courseNo
            }),
            dataType: "text",
            success: function(result) {
                if(result === "success") {
                    alert("환불이 반려되었습니다.");
                    tabLoad('refund');
                } else {
                    alert("환불 반려에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버 오류로 환불 반려에 실패했습니다.");
            }
        });
    });


</script>
