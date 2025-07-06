<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="navs">
    <div class="nav-item" data-nav="purchase">강의 구매 내역</div>
    <div class="nav-item active" data-nav="requestRefund">환불 신청</div>
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
            <th>강사명</th>
            <th>결제일</th>
            <th>금액</th>
            <th>환불 신청</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${not empty purchase}">
            <c:forEach var="rf" items="${purchase}">
                <tr>
                    <td>${rf.paymentId}</td>
                    <td>${rf.courseTitle}</td>
                    <td>${rf.instructorName}</td>
                    <td style="text-align: center;">
                        <fmt:formatDate value="${rf.paymentDate}" pattern="yyyy-MM-dd"/><br>
                        <fmt:formatDate value="${rf.paymentDate}" pattern="HH:mm:ss"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${rf.paymentPrice}" type="number"/>원
                    </td>
                    <td>

                        <c:choose>

                            <c:when test="${empty rf.refundStatus}">
                                <c:choose>
                                    <c:when test="${rf.applyType == 'RESERVE'}">
                                        <button class="btn-reserveRefund"
                                                data-course-no="${rf.courseNo}"
                                                data-payment-id="${rf.paymentId}">
                                            예약취소
                                        </button>
                                    </c:when>
                                    <c:when test="${rf.applyType == 'APPLY' || rf.applyType == 'TAKE'}">
                                        <button class="btn-applyRefund"
                                                data-course-no="${rf.courseNo}"
                                                data-payment-id="${rf.paymentId}">
                                            신청취소
                                        </button>
                                    </c:when>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                <c:when test="${rf.refundStatus == 'S'}">
                                    <span style="color:#888;">취소 승인 대기</span>
                                </c:when>
                                <c:when test="${rf.refundStatus == 'A'}">
                                    <span style="color:green;">취소 승인</span>
                                </c:when>
                                <c:when test="${rf.refundStatus == 'D'}">
                                    <span style="color:red;">취소 반려</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#888;">알 수 없음</span>
                                </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </td>

                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty purchase}">
            <tr>
                <td colspan="5" style="text-align: center;">환불 신청이 없습니다!</td>
            </tr>
        </c:if>
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

    //예약 바로 취소 기능
    $(document).off('click','.btn-reserveRefund').on('click', '.btn-reserveRefund', async function(e){
        if(!confirm('예약 취소 하시겠습니까?')) return;
        const courseNo = $(e.target).data('course-no');
        const userId = "${loginUser.userId}";
        console.log(userId);
        const impUidResponse = await fetch('${pageContext.request.contextPath}/payment/getImpUid?courseNo='+courseNo+'&userId='+userId);
        const impUid = await impUidResponse.text();
        $.ajax({
            url:"${pageContext.request.contextPath}/payment/cancelPayment2",
            type:"POST",
            contentType:"application/json",
            data:JSON.stringify({
                "imp_uid": impUid,
                "reason": "사용자 요청 환불",
                "userId":userId,
                "courseNo":courseNo
            }),
            dataType:"text",
            success: function(result) {
                if(result === "success") {
                    alert("환불이 정상적으로 처리되었습니다.");
                    tabLoad('requestrefund'); // 페이지 새로고침
                } else {
                    alert("환불 처리에 실패했습니다.");
                    tabLoad('requestrefund');
                }
            },
            error: function() {
                alert("서버 오류로 환불 요청에 실패했습니다.");
                tabLoad('requestrefund');
            }
        });
    });


    //apply, take 신청 취소 기능
    $(document).off('click', '.btn-applyRefund').on('click', '.btn-applyRefund', async function(e) {
        if(!confirm('신청 취소 하시겠습니까?')) return;
        const paymentId = $(e.target).data('payment-id');
        console.log(paymentId);
        $.ajax({
            url: "${pageContext.request.contextPath}/payment/requestrefund",
            type: "POST",
            data: {
                paymentId: paymentId
            },
            dataType: "text",
            success: function(result) {
                if(result === "success") {
                    alert("환불 요청이 접수되었습니다.");
                    tabLoad('requestrefund');
                } else {
                    alert("환불 요청에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버 오류로 환불 요청에 실패했습니다.");
            }
        });
    });

</script>


