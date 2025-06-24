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

}
