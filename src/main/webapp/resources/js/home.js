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

$('.btn-apply').on('click',async function(e){
    IMP.init("imp02858447");
    const courseNo = $(e.target).data('no');
    const courseTitle = $(e.target).data('title');
    const coursePrice = $(e.target).data('price');
    const applyType = $(e.target).data('type');
    const mail = $(e.target).data("mail");
    const name = $(e.target).data("name");
    const tel = $(e.target).data("tel");
    const id = $(e.target).data("id");

    const merchantUidResponse = await fetch( getContextPath() + '/payment/generatePaymentPk?courseNo='+courseNo);

    const merchantUid = await merchantUidResponse.text();

    IMP.request_pay(
        {
            channelKey: "channel-key-1ea045b8-ac8b-4afe-8b5f-f247bda2e199",
            pg:"uplus",
            pay_method: "card",
            merchant_uid: merchantUid,
            name: courseTitle,
            amount: coursePrice,
            buyer_email: mail,
            buyer_name: name,
            buyer_tel: tel
        },
        async function (rsp) {
            if (rsp.success) {
                const response=await fetch(getContextPath() + '/payment/insertPayment',
                    {
                        method:"POST",
                        headers:{
                            'Content-type':'application/json'
                        },
                        body:JSON.stringify({
                            paymentId: rsp.merchant_uid,
                            userId: id,
                            paymentPrice: rsp.paid_amount,
                            portoneId: rsp.imp_uid,
                            paymentDate:rsp.paid_at,
                            courseNo: courseNo, // 실제 강의 번호 사용
                            applyType:applyType
                        })
                    });
                const result=await response.text();

                if (result === "success") {
                    alert('결제가 완료되었습니다.');
                    location.assign(getContextPath() + "/home/searchcoursebyno?courseNo=" + courseNo);
                } else {
                    alert('결제에 실패하였습니다.');
                    location.assign(getContextPath() + "/home/searchcoursebyno?courseNo=" + courseNo);
                }
                execute=false;
            }else {
                var msg = rsp.error_msg;
                alert(msg);
                execute=false;
            }
        });
});

$(document).on('click','.btn-applyRefund', async function(e){
     if(!confirm('환불 요청 하시겠습니까?')) return;
        const paymentId = $(e.target).data('payment-id');
        console.log(paymentId);
        $.ajax({
            url: getContextPath() + "/payment/requestrefund",
            type: "POST",
            data: {
                paymentId: paymentId
            },
            dataType: "text",
            success: function(result) {
                if(result === "success") {
                    alert("환불 요청이 접수되었습니다.");
                    tabLoad('requestrefund');
                } else {
                    alert("환불 요청에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버 오류로 환불 요청에 실패했습니다.");
            }
        });
});

$(document).on('click', '.btn-refund', async function(e){
    if(!confirm('예약 취소 하시겠습니까?')) return;
    const courseNo = $(e.target).data('no');
    const userId = $(e.target).data('id');
    const impUidResponse = await fetch(getContextPath() + '/payment/getImpUid?courseNo='+courseNo+'&userId='+userId);
    const impUid = await impUidResponse.text();
    $.ajax({
        url: getContextPath() + "/payment/cancelPayment2",
        type:"POST",
        contentType:"application/json",
        data:JSON.stringify({
            "imp_uid": impUid,
            "reason": "사용자 요청 환불",
            "userId":userId,
            "courseNo":courseNo
        }),
        dataType:"text",
        success: function(result) {
            if(result === "success") {
                alert("환불이 정상적으로 처리되었습니다.");
                location.assign(getContextPath() + "/home/searchcoursebyno?courseNo=" + courseNo);
            } else {
                alert("환불 처리에 실패했습니다.");
                location.assign(getContextPath() + "/home/searchcoursebyno?courseNo=" + courseNo);
            }
        },
        error: function() {
            alert("서버 오류로 환불 요청에 실패했습니다.");
            location.assign(getContextPath() + "/home/searchcoursebyno?courseNo=" + courseNo);
        }
    });
});
