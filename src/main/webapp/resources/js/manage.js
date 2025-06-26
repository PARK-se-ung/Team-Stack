/* 관리자 페이지 */
function manageLoad(tabId) {
    $('.main-content').html(loading());

    $.ajax({
        url: getContextPath() + "/manage/" + tabId,
        type: 'POST',
        success: function(data) {
            $(".main-content").html(data);
            if(tabId === 'alarm') {
                const now = new Date();
                $(document).ready(function() {
                    flatpickr("#timeId", {
                        enableTime: true,
                        dateFormat: "Y-m-d H:i",
                        time_24hr: true,
                        defaultDate: now,
                        minDate: now
                    });
                })
            }
        },
        error: errorContent(tabId)
    })
}



/* 페이지 전환*/
function loadNotice(cPage) {
    $.ajax({
        url: getContextPath() + "/manage/notice",
        type: 'POST',
        data: {"cPage" : cPage},
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent('notice')
    })
}

/* 공지 등록 */
function insertNotice() {
    const alarm = $("#alarm").val();
    const title = $("#title").val();
    const content = $("#content").val();
    $('.main-content').html(loading());

    $.ajax({
        url: getContextPath() + "/manage/insertnotice",
        type: 'POST',
        data:{
            "alarm": alarm,
            "title": title,
            "content": content
        },
        success: function(data) {

            manageLoad('notice');
        },
        error: errorContent('notice')
    })
}

/* 알람 전송 */
function insertAlarm(tabId) {
    let type = $("#alarmTarget").val();
    if(type === 'custom'){
        type = $("#targetId").val();
    }
    let time = $("#alarmTime").val();
    if(time === 'custom'){
        time = $("#timeId").val();
    } else {
        time = getCurrentTimestamp(new Date());
    }
    const content = $("#alarm-content").val();
    const no = $("#inquire-no").val();
    console.log(no);
    $.ajax({
            url: getContextPath() + "/manage/insertalarm",
            type: 'POST',
            data:{
                "type": type,
                "time": time,
                "content": content,
                "tabId": tabId,
                "no": no
            },
            success: function(data) {
                if(tabId === 'alarm'){
                    if(data === -1) alert('대상 유저를 찾을 수 없습니다.');
                    else if(data === 0) alert('알람 전송에 실패하였습니다.');
                    else alert('알람을 전송하였습니다.');
                } else if(tabId === 'inquire') {
                    if(data === -1) alert('문의 처리에 실패하였습니다.');
                    else if(data === 0) alert('알람 전송에 실패하였습니다.');
                    else alert('문의를 처리하였습니다.');
                }
                $("#alarmModal").modal('hide');
                manageLoad(tabId);
            },
            error: errorContent(tabId)
        })
}

/* 알람모달 호출 */
function alarmModal(no) {
    $("input#inquire-no").val(no);
    $('#alarmModal').modal('show');
}

/* 현재시각 문자열 획득 */
function getCurrentTimestamp(date) {
    const pad = (n) => n.toString().padStart(2, '0');

    const year = date.getFullYear();
    const month = pad(date.getMonth() + 1); // 0-based
    const day = pad(date.getDate());
    const hours = pad(date.getHours());
    const minutes = pad(date.getMinutes());

    return `${year}-${month}-${day} ${hours}:${minutes}`;
}

/* 문의 */
function insertInquire() {
    const userId = $("#userId").val();
    const title = $("#title").val();
    const content = $("#content").val();

    $.ajax({
        url: getContextPath() + "/manage/insertinquire",
        type: 'POST',
        data:{
            "userId": userId,
            "title": title,
            "content": content
        },
        success: function(data) {
            if(data == 0){
                alert('문의에 실패하였습니다. 다시 시도해주세요.');
            } else {
                alert('문의를 전송하였습니다.')
            }
            location.assign(getContextPath());
        },
        error: errorContent('alarm')
    })
}

/* 문의 상태 select  */
function inquireHandler()  {
    const status = $("#inquire-status").val();
    $.ajax({
        url: getContextPath() + "/manage/inquire",
        method: 'POST',
        data: {
            "status": status
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent('inquire')
    })
}

/* 문의 페이징 처리 */
function loadInquire(cPage) {
    $.ajax({
        url: getContextPath() + "/manage/inquire",
        type: 'POST',
        data: {"cPage" : cPage},
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent('inquire')
    })
}

/* 메모리 기능 객체 */
class DequeData{
    constructor(pageData={backward:[], forward:[]}) {
        this.move=function(type,tabId){
            console.log(pageData,tabId);
            switch(type) {
                case 'shift':
                    pageData.forward.length = 0;
                    const last = pageData.backward.pop();
                    if(last !== tabId) pageData.backward.push(last);
                    pageData.backward.push(tabId);
                    if(pageData.backward.length > 10) pageData.backward.shift();
                    return tabId;
                case 'prev':
                    const p = pageData.backward.pop();
                    pageData.forward.unshift(tabId);
                    if(pageData.forward.length > 10) pageData.forward.pop();
                    return p;
                case 'next':
                    const n = pageData.forward.shift();
                    pageData.backward.push(tabId);
                    if(pageData.backward.length > 10) pageData.backward.shift();
                    return n;
                default: return tabId;
            }
        }
        this.hasBlankForward=function(){

            return pageData.forward.length === 0;
        }
        this.hasBlankBackward=function(){

            return pageData.backward.length === 0;
        }
    }
}

/* 메모리 활성 처리 */
function disableHandler(dequeData) {
    if(dequeData.hasBlankBackward()) $(".arrows[data-type=prev]").prop("disabled", true);
    else $(".arrows[data-type=prev]").prop("disabled", false);
    if(dequeData.hasBlankForward()) $(".arrows[data-type=next]").prop("disabled", true);
    else $(".arrows[data-type=next]").prop("disabled", false);
}