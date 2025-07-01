/* 사이드 메뉴별 페이지 로드 함수 */
function tabLoad(tabId) {
    /* 로딩 스피너 생성 */
    $('.main-content').html(loading());


    /* 클래스 페이지 전환 분기 처리 */
    if(tabId === 'class') {
        location.assign(getContextPath() + "");
    }
    /* AJAX로 해당 페이지 로드 */
    $.ajax({
        url: getContextPath() + "/mypage/" + tabId,
        type: 'POST',
        success: function(data) {
            $(".main-content").html(data);
            if (tabId === 'open') {
                flatpickr("#datePicker", {
                    mode: "range",
                    dateFormat: "Y-m-d H:i",
                    minDate: "today",
                    defaultDate: [new Date(), (() => {
                        const d = new Date();
                        d.setDate(d.getDate() + 14);
                        return d;
                    })()],
                    locale: "ko",
                    altInput: true,
                    altFormat: "Y년 m월 d일",
                    enableTime: true,
                    onClose: function(selectedDates) {
                        if (selectedDates.length === 2) {
                            const [start, end] = selectedDates;
                            const msPerWeek = 7 * 24 * 60 * 60 * 1000;
                            const weeks = Math.round((end - start) / msPerWeek);
                            const recruit = new Date(start.getTime() + msPerWeek);

                            // 포맷 함수: yyyy-MM-dd (java.sql.Date용)
                            const pad = n => n.toString().padStart(2, "0");
                            const fmtYmd = d =>
                                `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
                            // 포맷 함수: yyyy-MM-dd HH:mm (startDate)
                            const fmtFull = d =>
                                `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ` +
                                `${pad(d.getHours())}:${pad(d.getMinutes())}`;

                            // hidden inputs 에 값 세팅
                            $("#courseStartDate").val(fmtFull(start));
                            $("#totalWeek").val(weeks);
                            $("#recruitDate").val(fmtYmd(recruit));
                        }
                    }
                });
            }

            // 폼 제출 전에도 한 번 더 확실히 세팅
            $("#courseForm").on("submit", function() {
                if (!$("#totalWeek").val()) {
                    console.warn("totalWeek가 비어있음!");
                }
            });
        },
        error: errorContent(tabId)
    })
}

/* 북마크 페이징 처리 */
function bookmarkPaging(cPage){
    $.ajax({
        url: getContextPath() + "/mypage/bookmark",
        type: 'POST',
        data:{
          "cPage":cPage
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent("bookmark")
    })
}

/* 구매 내역 페이징 처리 */
function purchasePaging(cPage){
    $.ajax({
        url: getContextPath() + "/mypage/purchase",
        type: 'POST',
        data:{
            "cPage":cPage
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent("purchase")
    })
}

/* 판매 내역 페이징 처리 */
function salesPaging(cPage){
    $.ajax({
        url: getContextPath() + "/mypage/sales",
        type: 'POST',
        data:{
            "cPage":cPage
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent("sales")
    })
}

/* 예약 내역 페이징 처리 */
function reservePaging(cPage){
    $.ajax({
        url: getContextPath() + "/mypage/reserve",
        type: 'POST',
        data:{
            "cPage":cPage
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent("reserve")
    })
}

/* 신청한 강의 내역 페이징 처리 */
function applyPaging(cPage){
    $.ajax({
        url: getContextPath() + "/mypage/apply",
        type: 'POST',
        data:{
            "cPage":cPage
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent("apply")
    })
}


/* 수강중인 강의 내역 페이징 처리 */
function takePaging(cPage){
    $.ajax({
        url: getContextPath() + "/mypage/take",
        type: 'POST',
        data:{
            "cPage":cPage
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent("take")
    })
}
/* 수강 완료 강의 내역 페이징 처리 */
function completePaging(cPage){
    $.ajax({
        url: getContextPath() + "/mypage/complete",
        type: 'POST',
        data:{
            "cPage":cPage
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent("complete")
    })
}

/* 로딩 스피너 생성 함수 */
function loading() {
    const $form = $("<div>").addClass("loading-content");
    const $spinner = $("<div>").addClass("loading-spinner");
    const $msg = $("<p>").text("페이지를 불러오는 중입니다.");
    return $form.append($spinner).append($msg);
}

/* AJAX 에러 컨텐트 로드 */
function errorContent(tabId) {
    const $form = $("<div>").addClass("loading-content");
    const $i = $("i").addClass("bi bi-exclamation-triangle")
                     .attr({
                         "font-size":"48px",
                         "margin-bottom":"20px",
                         "color":"#dc3545"
                     })
    const $msg = $("<p>").text("페이지 로드 실패");
    const $button = $("<button>").addClass("btn btn-outline-orange")
        .attr('onclick', `tabLoad(${tabId})`)
        .text("다시 시도");
    return $form.append($i).append($msg).append($button);
}


/* contextPath 호출 */
function getContextPath() {
    return "/" + window.location.pathname.split("/")[1];
}


