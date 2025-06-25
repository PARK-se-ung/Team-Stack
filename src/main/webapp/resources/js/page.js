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
            if(tabId === 'open'){
                flatpickr("#datePicker", {
                    mode: "range",
                    dateFormat: "Y-m-d H:i",
                    minDate: "today",
                    defaultDate: [new Date(), new Date()],
                    locale: "ko",
                    altInput: true,
                    altFormat: "Y년 m월 d일",
                    enableTime: true
                });
            }
        },
        error: errorContent(tabId)
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


