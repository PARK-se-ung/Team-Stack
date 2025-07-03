<%@ page import="org.ts.teamstack.user.model.dto.Users" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
<!-- 상단 탭이 존재하는 경우 -->

    <!-- nav 전환 로직 -->
      $(".nav-item").on('click', function(e) {
        let $current = $(this);
        let tabId = $current.data('nav');
        $(".nav-item").removeClass("active");
        $current.addClass("active");
        tabLoad(tabId);
        e.stopPropagation();
      });

<%--$(document).off('click', '.btn-applyRefund').on('click', '.btn-applyRefund', async function(e) {--%>
<%--  if(!confirm('환불 요청 하시겠습니까?')) return;--%>
<%--  const courseNo = $(e.target).data('course-no');--%>
<%--  const userId = "${sessionScope.loginUser.userId}";--%>
<%--  const impUidResponse = await fetch('${pageContext.request.contextPath}/payment/getImpUid?courseNo='+courseNo+'&userId='+userId);--%>
<%--  const impUid = await impUidResponse.text();--%>

<%--  $.ajax({--%>
<%--    url: "${pageContext.request.contextPath}/payment/requestrefund2",--%>
<%--    type: "POST",--%>
<%--    data: {--%>
<%--      imp_uid: impUid,--%>
<%--    },--%>
<%--    dataType: "text",--%>
<%--    success: function(result) {--%>
<%--      if(result === "success") {--%>
<%--        alert("환불 요청이 접수되었습니다.");--%>
<%--        tabLoad('bookmark');--%>
<%--      } else {--%>
<%--        alert("환불 요청에 실패했습니다.");--%>
<%--      }--%>
<%--    },--%>
<%--    error: function() {--%>
<%--      alert("서버 오류로 환불 요청에 실패했습니다.");--%>
<%--    }--%>
<%--  });--%>
<%--});--%>

<%--    &lt;%&ndash;<!-- 결제 기능 -->&ndash;%&gt;--%>

<%--    $('.btn-apply').on('click',async function(e){--%>

<%--          IMP.init("imp02858447");--%>
<%--          const courseNo = $(e.target).data('course-no');--%>
<%--          const courseTitle = $(e.target).data('course-title');--%>
<%--          const coursePrice = $(e.target).data('course-price');--%>
<%--          const applyType = $(e.target).data('apply-type');--%>

<%--          const merchantUidResponse = await fetch('${pageContext.request.contextPath}/payment/generatePaymentPk?courseNo='+courseNo);--%>

<%--          const merchantUid = await merchantUidResponse.text();--%>

<%--          console.log("이건 결제사전등록하면서 생성한 PK야"+merchantUid)--%>
<%--          IMP.request_pay(--%>
<%--                  {--%>
<%--                    channelKey: "channel-key-1ea045b8-ac8b-4afe-8b5f-f247bda2e199",--%>
<%--                    pg:"uplus",--%>
<%--                    pay_method: "card",--%>
<%--                    merchant_uid: merchantUid,--%>
<%--                    name: courseTitle,--%>
<%--                    amount: coursePrice,--%>
<%--                    buyer_email: "${sessionScope.loginUser.userEmail}",--%>
<%--                    buyer_name: "${sessionScope.loginUser.name}",--%>
<%--                    buyer_tel: "${sessionScope.loginUser.userPhone}"--%>
<%--                  },--%>
<%--                  async function (rsp) {--%>
<%--                  // 결제 종료 시 호출되는 콜백 함수--%>
<%--                  // response.imp_uid 값으로 결제 단건조회 API를 호출하여 결제 결과를 확인하고,--%>
<%--                  // 결제 결과를 처리하는 로직을 작성합니다.--%>
<%--                    if (rsp.success) {--%>
<%--                      const response=await fetch('${pageContext.request.contextPath}/payment/insertPayment',--%>
<%--                              {--%>
<%--                                method:"POST",--%>
<%--                                headers:{--%>
<%--                                  'Content-type':'application/json'--%>
<%--                                },--%>
<%--                                body:JSON.stringify({--%>
<%--                                  paymentId: rsp.merchant_uid,--%>
<%--                                  userId: "${sessionScope.loginUser.userId}",--%>
<%--                                  paymentPrice: rsp.paid_amount,--%>
<%--                                  portoneId: rsp.imp_uid,--%>
<%--                                  paymentDate:rsp.paid_at,--%>
<%--                                  courseNo: courseNo, // 실제 강의 번호 사용--%>
<%--                                  applyType:applyType--%>
<%--                                })--%>
<%--                              });--%>
<%--                      const result=await response.text();--%>

<%--                      if (result === "success") {--%>
<%--                        alert('결제가 완료되었습니다.');--%>
<%--                        console.log("결제성공");--%>
<%--                        tabLoad('bookmark'); // 페이지 새로고침--%>
<%--                      } else {--%>
<%--                        alert('결제에 실패하였습니다.');--%>
<%--                        tabLoad('bookmark');--%>
<%--                        console.log("결제실패 = 가격이 달라서 내가 막은거지?");--%>
<%--                      }--%>
<%--                      execute=false;--%>
<%--                    }else {--%>
<%--                      var msg = rsp.error_msg;--%>
<%--                      alert(msg);--%>
<%--                      execute=false;--%>
<%--                    }--%>

<%--                  });--%>
<%--    });--%>

    <!-- 북마크 취소 기능 -->
    $(document).ready(function() {
      $(document).on('click', '.btn-bookmark-remove', function (e) {
        // $('.btn-bookmark-remove').on('click',function(e){
        const bookmarkNo = $(e.target).data('bookmark-no');
        if (!confirm("북마크를 취소하시겠씁니까?")) return;
        //취소면 return
        $.ajax({
          url: getContextPath() + "/course/bookmark/delete?bookmarkNo=" + String(bookmarkNo),
          type: "DELETE",
          success: function (result) {

            tabLoad('bookmark');//새로고침

          },
          error: function () {
            alert("북마크 취소가 안됩니당 :(");
            tabLoad('bookmark');
          }
        });

      });
    });
</script>

<div class="navs">
  <div class="nav-item active" data-nav="bookmark">북마크한 강의</div>
  <div class="nav-item" data-nav="reserve">예약한 강의</div>
  <div class="nav-item" data-nav="apply">신청한 강의</div>
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

  <table>
    <thead>
    <tr>
      <th>북마크</th>
      <th>강의명</th>
      <th>강사명</th>
      <th>학년</th>
      <th>과목</th>
      <th>지역</th>
      <th>모집 시작일</th>
      <th>강의 시작일</th>
      <th>금액</th>
<%--      <th>신청</th>--%>
    </tr>
    </thead>
    <tbody>
    <c:if test="${not empty bookmarks}">
      <c:forEach var="b" items="${bookmarks}">
        <%-- 모집 시작일 Date 객체로 변환 --%>
        <fmt:parseDate value="${b.recruitDate}" pattern="yyyy-MM-dd" var="recruitDateObj"/>
        <%-- 모집 종료일 = 모집 시작일 + 7일(밀리초) --%>
        <c:set var="millisIn7Days" value="${7 * 24 * 60 * 60 * 1000}" />
        <c:set var="recruitEndDateMillis" value="${recruitDateObj.time + millisIn7Days}" />
        <%-- 오늘 날짜 --%>
        <c:set var="now" value="<%= new java.util.Date() %>" />
        <c:set var="nowMillis" value="${now.time}" />

        <tr>
          <td>
            <button class="btn-bookmark-remove" data-bookmark-no="${b.bookmarkNo}">★</button>
          </td>
          <td>${b.courseTitle}</td>
          <td>${b.instructorName}</td>
          <td>
            <c:choose>
              <c:when test="${b.gradeType == 'E'}">초등</c:when>
              <c:when test="${b.gradeType == 'M'}">중등</c:when>
              <c:when test="${b.gradeType == 'H'}">고등</c:when>
              <c:otherwise>기타</c:otherwise>
            </c:choose>
          </td>
          <td>${b.subject}</td>
          <td>${b.region}</td>
          <td><fmt:formatDate value="${b.recruitDate}" pattern="yyyy-MM-dd"/></td>
          <td><fmt:formatDate value="${b.courseStartDate}" pattern="yyyy-MM-dd"/></td>
          <td><fmt:formatNumber value="${b.coursePrice}" type="number"/>원</td>
<%--          <td>--%>
<%--            <c:choose>--%>
<%--              <c:when test="${not empty b.applyNo}">--%>
<%--                <c:choose>--%>
<%--                  <c:when test="${}">--%>

<%--                  </c:when>--%>

<%--                </c:choose>--%>
<%--                <span style="color:orange;">환불 대기</span>--%>
<%--              </c:when>--%>
<%--              <c:otherwise>--%>
<%--                &lt;%&ndash;여기는 apply가 없으니까 신청이 가능해야해 모집일과&ndash;%&gt;--%>
<%--                &lt;%&ndash; 아래는 기존 신청/결제/환불 버튼 로직 &ndash;%&gt;--%>
<%--                <c:choose>--%>
<%--                  &lt;%&ndash; 1. 무료 강의 &ndash;%&gt;--%>
<%--                  <c:when test="${b.coursePrice == 0}">--%>
<%--                    <c:choose>--%>
<%--                      <c:when test="${nowMillis > recruitEndDateMillis}">--%>
<%--                        <span style="color:#888;">모집 종료</span>--%>
<%--                      </c:when>--%>
<%--                      <c:when test="${nowMillis < recruitDateObj.time}">--%>
<%--                        <button class="btn-freeApply"--%>
<%--                                data-course-no="${b.courseNo}"--%>
<%--                                data-course-title="${b.courseTitle}"--%>
<%--                                data-apply-type="RESERVE">예약</button>--%>
<%--                      </c:when>--%>
<%--                      <c:otherwise>--%>
<%--                        <button class="btn-freeApply"--%>
<%--                                data-course-no="${b.courseNo}"--%>
<%--                                data-course-title="${b.courseTitle}"--%>
<%--                                data-apply-type="APPLY">신청</button>--%>
<%--                      </c:otherwise>--%>
<%--                    </c:choose>--%>
<%--                  </c:when>--%>
<%--                  &lt;%&ndash; 2. 유료 강의 &ndash;%&gt;--%>
<%--                  <c:otherwise>--%>
<%--                    <c:choose>--%>
<%--                      <c:when test="${empty b.applyNo}">--%>
<%--                        <c:choose>--%>
<%--                          <c:when test="${nowMillis > recruitEndDateMillis}">--%>
<%--                            <span style="color:#888;">모집 종료</span>--%>
<%--                          </c:when>--%>
<%--                          <c:when test="${nowMillis < recruitDateObj.time}">--%>
<%--                            <button class="btn-apply"--%>
<%--                                    data-course-no="${b.courseNo}"--%>
<%--                                    data-course-title="${b.courseTitle}"--%>
<%--                                    data-course-price="${b.coursePrice}"--%>
<%--                                    data-apply-type="RESERVE">예약</button>--%>
<%--                          </c:when>--%>
<%--                          <c:otherwise>--%>
<%--                            <button class="btn-apply"--%>
<%--                                    data-course-no="${b.courseNo}"--%>
<%--                                    data-course-title="${b.courseTitle}"--%>
<%--                                    data-course-price="${b.coursePrice}"--%>
<%--                                    data-apply-type="APPLY">결제</button>--%>
<%--                          </c:otherwise>--%>
<%--                        </c:choose>--%>
<%--                      </c:when>--%>
<%--                      <c:otherwise>--%>
<%--                        <c:choose>--%>
<%--                          <c:when test="${b.applyType == 'APPLY' || b.applyType == 'RESERVE'}">--%>
<%--                            <button class="btn-applyRefund"--%>
<%--                                    data-apply-no="${b.applyNo}"--%>
<%--                                    data-course-no="${b.courseNo}">환불</button>--%>
<%--                          </c:when>--%>
<%--                          <c:when test="${b.applyType == 'TAKE' || b.applyType == 'COMPLETE'}">--%>
<%--                            <span style="color:#888;">수강중/완료</span>--%>
<%--                          </c:when>--%>
<%--                          <c:otherwise>--%>
<%--                            <!-- 기타 상태 처리 -->--%>
<%--                          </c:otherwise>--%>
<%--                        </c:choose>--%>
<%--                      </c:otherwise>--%>
<%--                    </c:choose>--%>
<%--                  </c:otherwise>--%>
<%--                </c:choose>--%>
<%--              </c:otherwise>--%>
<%--            </c:choose>--%>
<%--          </td>--%>

        </tr>
      </c:forEach>
    </c:if>

    <c:if test="${empty bookmarks}">
      <tr>
        <td colspan="10" style="text-align: center;">북마크한게 없네용!ㅋㅋ</td>
      </tr>
    </c:if>
    </tbody>
  </table>

  <div id="pageBar">
    ${pageBar}
  </div>
</div>
