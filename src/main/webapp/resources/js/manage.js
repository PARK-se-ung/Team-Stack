/* 관리자 페이지 */
function manageLoad(tabId) {
    $('.main-content').html(loading());

    $.ajax({
        url: getContextPath() + "/manage/" + tabId,
        type: 'POST',
        success: function(data) {
            $(".main-content").html(data);
        },
        error: errorContent(tabId)
    })
}


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
            $(".main-content").html(data);
            manageLoad('notice');
        },
        error: errorContent('notice')
    })
}
