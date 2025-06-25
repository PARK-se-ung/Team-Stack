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
function insertAlarm() {
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

    $.ajax({
            url: getContextPath() + "/manage/insertalarm",
            type: 'POST',
            data:{
                "type": type,
                "time": time,
                "content": content
            },
            success: function(data) {
                if(data == -1){
                    alert('대상 유저를 찾을 수 없습니다.');
                } else if(data == 0){
                    alert('알람 전송에 실패하였습니다.');
                } else {
                    alert('알람을 전송하였습니다.')
                }
                manageLoad('alarm');
            },
            error: errorContent('alarm')
        })
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