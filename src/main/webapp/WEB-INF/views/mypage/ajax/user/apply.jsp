<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="navs">
    <div class="nav-item" data-nav="bookmark">북마크한 강의</div>
    <div class="nav-item" data-nav="reserve">예약한 강의</div>
    <div class="nav-item active" data-nav="apply">신청한 강의</div>
    <div class="nav-item" data-nav="take">수강중인 강의</div>
    <div class="nav-item" data-nav="complete">수강완료한 강의</div>
</div>

<div class="current-container">

    <div class="search-bar">
        <form method="get" action="" class="search-form">
            <select name="status">
                <option value="">전체</option>
                <option value="강사명">강사명</option>
                <option value="강의명">강의명</option>
            </select>
            <input type="text" name="lectureTitle" placeholder="" value="">
            <button type="submit">검색</button>
        </form>
    </div>

    <div class="view-toggle">
        <strong><a>이미지형</a></strong> | <a>리스트형</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>강의명</th>
            <th>강사명</th>
            <th>학년</th>
            <th>과목</th>
            <th>지역</th>
            <th>주차</th>
            <th>강의 시작일</th>
            <th>금액</th>
            <th>환불 신청</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${not empty apply}">
            <c:forEach var="a" items="${apply}">
                <tr>
                    <td><a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${a.courseNo}">${a.courseTitle}</a></td>
                    <td>${a.instructorName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${a.gradeType == 'E'}">초등</c:when>
                            <c:when test="${a.gradeType == 'M'}">중등</c:when>
                            <c:when test="${a.gradeType == 'H'}">고등</c:when>
                            <c:otherwise>기타</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${a.subject}</td>
                    <td>${a.region}</td>
                    <td>${a.totalWeek}</td>
                    <td><fmt:formatDate value="${a.courseStartDate}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatNumber value="${a.coursePrice}" type="number"/>원</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty a.applyType}">
                            <button class="btn-applyRefund"
                                    data-course-no="${a.courseNo}"
                                    data-payment-id="${a.paymentId}">
                                신청취소
                            </button>
                        </c:when>
                        <c:otherwise>
                            <span>취소 대기중</span>
                        </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty apply}">
            <tr>
                <td colspan="9" style="text-align: center;">신청한 강의가 없습니다!</td>
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

