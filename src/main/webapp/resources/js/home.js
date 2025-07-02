function courseList(category) {
    location.assign(getContextPath() + "/home/searchcourselist?category=" + category);
}

function loadCourseList() {
    const filter = getRestrict();
    filter.type = $('.form-convertor.btn-orange').data('form');
    $.ajax({
        url: getContextPath() + "/home/searchcoursebyrest",
        method: "GET",
        data: filter,
        success: function(data) {
            console.log(data);
            $("#course-container").html(data);
        }
    })
}
function getRestrict() {
    const schools = $(".school:checked").map(function() {
        return this.value;
    }).get().join(",");

    const category = $("#category").val();
    const region = $("#region").val();

    const weeks = $("input[name='week']:checked").map(function() {
        return this.value;
    }).get().join(",");

    const searchData = $("#searchData").val();
    return {
        schools: schools,
        category: category,
        region: region,
        weeks: weeks,
        searchData: searchData
    };
}
function loadCourse(cPage) {
    const filter = getRestrict();
    filter.cPage = cPage;
    filter.type = $('.form-convertor.btn-orange').data('form');
    $.ajax({
        url: getContextPath() + "/home/searchcoursebyrest",
        method: "GET",
        data: filter,
        success: function(data) {
            console.log(data);
            $("#course-container").html(data);
        }
    })
}

$(document).on('click', '.form-convertor', function () {
    /* btn 디자인 */
    $('.form-convertor').each(function () {
        $(this).removeClass('btn-orange').addClass('btn-outline-orange');
    });

    $(this).removeClass('btn-outline-orange').addClass('btn-orange');

    /* 전환 */
    const filter = getRestrict();
    filter.cPage = Number($('.selected-page').data('no') || 1);
    filter.type = $('.form-convertor.btn-orange').data('form');

    $.ajax({
        url: getContextPath() + "/home/searchcoursebyrest",
        method: "POST",
        data: filter,
        success: function (data) {
            $("#course-container").html(data);
        }
    })

})


$(document).on('click', '.bookmark', function() {
    const $icon = $(this).find('i');
    const status = $icon.hasClass('bi-bookmark')?'I':'D';
    const courseNo = $(this).data("no");
    $.ajax({
        url: getContextPath() + "/home/convertbookmark",
        method: "POST",
        data: {
            status : status,
            courseNo : courseNo
        },
        success: function (data) {
            if(data > 0) {
                if ($icon.hasClass('bi-bookmark')) {
                    $icon.removeClass('bi-bookmark').addClass('bi-bookmark-fill');
                } else {
                    $icon.removeClass('bi-bookmark-fill').addClass('bi-bookmark');
                }
            } else if(data === -1) {
                alert('로그인 후 이용하실 수 있습니다.');
            } else {
                alert('다시 시도해주세요.');
            }
        }
    })
})
function getContextPath() {
    return "/" + window.location.pathname.split("/")[1];
}