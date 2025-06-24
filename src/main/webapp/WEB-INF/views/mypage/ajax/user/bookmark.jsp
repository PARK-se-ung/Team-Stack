<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                  buyer_postcode: "01181",
                },
                async function (response) {
    // 결제 종료 시 호출되는 콜백 함수
    // response.imp_uid 값으로 결제 단건조회 API를 호출하여 결제 결과를 확인하고,
    // 결제 결과를 처리하는 로직을 작성합니다.
                  if(response.error_code != null){
                    return alert(`결제에 실패하였습니다. ${response.error_msg}`);
                    //고객사 서버에서 payment/complete엔드포인트 구현

                  }
                  const notified = await fetch(`${pageContext.request.contextPath}/payment/complete`,{
                    method:"POST",
                    headers:{"Content-Type":"application/json"},
                    body:JSON.stringify({
                      imp_uid:response.imp_uid,
                      merchant_uid:response.merchant_uid
                    })
                  })
                }
        );
      }


      // if(payment.price===amount)
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
          <th>교육기간</th>
          <th>접수기간</th>
          <th>신청</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td></td>
          <td><a href="">[서초1동] 헬스 오후 - 2025.3분기</a></td>
          <td>서초1동 자치회관</td>
          <td>2025-07-01 ~ 2025-09-30</td>
          <td>2025-06-23 ~ 2025-06-27</td>
          <td><button class="btn-manage" onclick="onClickPay();">결제</button>
          </td>
        </tr>
        <tr>
          <td></td>
          <td><a href="">[서초1동] 헬스 오후 - 2025.3분기</a></td>
          <td>서초1동 자치회관</td>
          <td>2025-07-01 ~ 2025-09-30</td>
          <td>2025-06-23 ~ 2025-06-27</td>
          <td><button class="btn-manage">결제</button>
          </td>
        </tr>
        <!-- 생략된 나머지 항목들도 같은 형식으로 추가 -->
        </tbody>
      </table>
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


