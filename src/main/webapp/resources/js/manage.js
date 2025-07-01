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

/* 강사 승인 */
function loadAuthorAppr(cPage) {
    $.ajax({
        url: getContextPath() + "/manage/authorAppr",
        method: "POST",
        data: {
            cPage:cPage
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent('authorAppr')
    })
}

/* 강의 승인 */
function loadCourseAppr(cPage) {
    $.ajax({
        url: getContextPath() + "/manage/courseAppr",
        method: "POST",
        data: {
            cPage:cPage
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent('courseAppr')
    })
}

$(document).on('click', '.courseAppr', function() {
    const courseNo = $(this).data("no");
    const status = $(this).data("status");
    $.ajax({
        url: getContextPath() + "/manage/updateCourse",
        method: "POST",
        data: {
            status: status,
            courseNo: courseNo
        },
        success: function(data) {
            if(data > 0) {
                if(status === 'APPROVE') alert('승인을 완료하였습니다.');
                else if(status === 'DENY') alert('승인을 반려하였습니다.');
            } else {
                alert('승인 처리에 실패하였습니다.');
            }
            manageLoad('courseAppr');
        },
        error: errorContent('courseAppr')
    })
})

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
            if(data > 0) {
                alert('공지를 등록하였습니다.');
            } else {
                alert('공지 등록에 실패하였습니다.');
            }
            manageLoad('notice');
        },
        error: errorContent('notice')
    })
}

/* 공지 수정 */
$(document).on('click', '#notice-convertor', function() {
    const noticeNo = $(this).data("no");
    $('.main-content').html(loading());
    $.ajax({
        url: getContextPath() + "/manage/convertNotice",
        method: "GET",
        data: {
            noticeNo: noticeNo
        },
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent('notice')
    })
})

function updateNotice() {
    const alarm = $("#alarm").val();
    const title = $("#title").val();
    const content = $("#content").val();
    const noticeNo = $("#no").val();
    $('.main-content').html(loading());

    $.ajax({
        url: getContextPath() + "/manage/updatenotice",
        type: 'POST',
        data:{
            "noticeNo": noticeNo,
            "alarm": alarm,
            "title": title,
            "content": content
        },
        success: function(data) {
            if(data > 0) {
                alert('공지를 수정하였습니다.');
            } else {
                alert('공지 수정에 실패하였습니다.');
            }
            manageLoad('notice');
        },
        error: errorContent('notice')
    })
}


/* 공지 삭제 */
$(document).on('click', '#notice-delete', function() {
    const noticeNo = $(this).data("no");
    if(confirm("삭제시 복구가 불가능합니다. 정말로 삭제하시겠습니까?")) {
        $('.main-content').html(loading());
        $.ajax({
            url: getContextPath() + "/manage/deleteNotice",
            method: "POST",
            data: {
                noticeNo: noticeNo
            },
            success: function(data) {
                if(data > 0){
                    alert('공지를 삭제하였습니다.')
                } else {
                    alert('공지 삭제에 실패하였습니다.')
                }
                manageLoad('notice');
            },
            error: errorContent('notice')
        })
    }
})
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

/* deque */
class Deque {
    constructor() {
        this._storage = {};
        this._head = 0;
        this._tail = 0;
    }

    unshift(value) {
        this._head--;
        this._storage[this._head] = value;
    }

    push(value) {
        this._storage[this._tail] = value;
        this._tail++;
    }

    shift() {
        if (this.isEmpty()) return undefined;
        const value = this._storage[this._head];
        delete this._storage[this._head];
        this._head++;
        return value;
    }

    pop() {
        if (this.isEmpty()) return undefined;
        this._tail--;
        const value = this._storage[this._tail];
        delete this._storage[this._tail];
        return value;
    }

    front() {
        return this.isEmpty() ? undefined : this._storage[this._head];
    }

    back() {
        return this.isEmpty() ? undefined : this._storage[this._tail - 1];
    }

    isEmpty() {
        return this.length === 0;
    }

    clear() {
        this._storage = {};
        this._head = 0;
        this._tail = 0;
    }


    get length() {
        return this._tail - this._head;
    }
}

/* 메모리 기능 객체 */
class DequeData{
    constructor(pageData={backward:[], forward:[]}) {
        this.move=function(type,tabId){
            console.log(pageData,tabId);
            switch(type) {
                case 'shift':
                    pageData.forward.length = 0;
                    if(pageData.backward.length > 0) {
                        const last = pageData.backward.pop();
                        if(last !== tabId) pageData.backward.push(last);
                    }
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