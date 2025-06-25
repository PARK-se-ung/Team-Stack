<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<!-- 상단 탭이 존재하는 경우 -->
<script>
    <!-- nav 전환 로직 -->
      $(".nav-item").on('click', function() {
        let $current = $(this);
        let tabId = $current.data('nav');
        $(".nav-item").removeClass("active");
        $current.addClass("active");
        tabLoad(tabId);
      });

    <!-- 결제 기능 -->
      IMP.init("imp02858447");

      const onClickPay = () => {
        IMP.request_pay(
                {
                  channelKey: "channel-key-1ea045b8-ac8b-4afe-8b5f-f247bda2e199",
                  pg:"uplus",
                  pay_method: "card",
                  merchant_uid: new Date().getTime(),// 주문 고유 번호
                  name: "웹 프로그래밍 입문",
                  amount: 100,
                  buyer_email: "cheonjaepo@gmail.com",
                  buyer_name: "김천재",
                  buyer_tel: "010-4242-4242",
                },
                function (rsp) {
    // 결제 종료 시 호출되는 콜백 함수
    // response.imp_uid 값으로 결제 단건조회 API를 호출하여 결제 결과를 확인하고,
    // 결제 결과를 처리하는 로직을 작성합니다.
                  if (rsp.success) {


                    $.ajax({
                      type: "POST",
                      url: '${pageContext.request.contextPath}/payment/insertPayment',
                      data: {
                        merchant_uid: rsp.merchant_uid,
                        userId:rsp.buyer_name,
                        paymentPrice:rsp.amount,
                        portonId: rsp.imp_uid,
                        paymentDate:rsp.paid_at,
                        courseNo:999
                      },
                      success:function (result){
                        if(result==="success"){
                          var msg = '결제가 완료되었습니다.';
                          console.log("결제성공 ");
                        }else{
                          var msg = '결제에 실패하였습니다.';
                          console.log("결제실패 ");

                        }
                      }
                    });
                  } else {
                    var msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                  }
                  alert(msg);
                }
        );
      }
    <!-- 북마크 취소 기능 -->
    $('.btn-bookmark-remove').on('click',function(e){
      const bookmarkNo = $(e.target).data('bookmark-no');
      if(!confirm("북마크를 취소하시겠씁니까?")) return;
      //취소면 return
      $.ajax({
        url:getContextPath()+"/course/bookmark/delete?bookmarkNo="+String(bookmarkNo),
        type:"DELETE",
        success:function (result){

        tabLoad('bookmark');//새로고침

        },
        error:function (){
          alert("북마크 취소가 안됩니당 :(");
        }
      })



    })

</script>

<div class="navs">
  <div class="nav-item active" data-nav="bookmark">북마크한 강의</div>
  <div class="nav-item" data-nav="reserve">예약한 강의</div>
  <div class="nav-item" data-nav="apply">신청한 강의</div>
  <div class="nav-item" data-nav="take">수강중인 강의</div>
  <div class="nav-item" data-nav="complete">수강완료한 강의</div>
</div>
<!-- 아래 div안에서 필요한 html 코드 작성 -->

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
          <th>북마크</th>
          <th>강의명</th>
          <th>강사명</th>
          <th>학년</th>
          <th>과목</th>
          <th>지역</th>
          <th>모집 시작일</th>
          <th>강의 시작일</th>
          <th>금액</th>
          <th>신청</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${not empty bookmarks}">
          <c:forEach var="b" items="${bookmarks}">
            <tr>
              <td>
                <!-- 북마크 해제 버튼 또는 아이콘 -->
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
              <td>${b.coursePrice}원</td>
              <td>
                <button class="btn-apply" data-course-no="${b.courseNo}">신청</button>
              </td>
            </tr>
          </c:forEach>
        </c:if>


        <c:if test="${empty bookmarks}">
          <tr>
          북마크한게 없네용!ㅋㅋ
          </tr>
        </c:if>
        </tbody>
      </table>
        <div id="pageBar">
          ${pageBar}
        </div>
    </div>

  <style>

    .current-container {
      margin: 40px auto;
      background: #fff;
      border-radius: 20px;
      padding: 30px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
    }

    thead {
      background: #f5f5f5;
    }

    th, td {
      padding: 12px;
      text-align: left;
      border-bottom: 1px solid #ddd;
      vertical-align: top;
    }

    tr:hover {
      background-color: #fafafa;
    }
    .view-toggle {
      margin-top: 10px;
    }
    .btn-manage {
      padding: 4px 10px;
      font-size: 13px;
      background: #f44336;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      min-width: 70px;
      max-width: 90px;
      white-space: nowrap;
    }
    .search-bar {
      display: flex;
      justify-content: flex-end;
      margin-bottom: 16px;
    }
    .search-form {
      display: flex;
      gap: 8px;
      align-items: center;
    }
    .search-form input[type="date"],
    .search-form select,
    .search-form input[type="text"] {
      padding: 4px 8px;
      font-size: 13px;
    }
    .search-form button {
      padding: 4px 14px;
      font-size: 13px;
      background: #455ba8;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
  </style>


