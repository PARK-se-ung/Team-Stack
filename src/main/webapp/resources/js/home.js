function courseList(category) {
    location.assign(getContextPath() + "/home/searchcourselist?category=" + category);
}

function loadCourseList() {
    const schools = $(".school:checked").map(function() {
        return this.value;
    }).get().join(",");

    const category = $("#category").val();
    const region = $("#region").val();

    const weeks = $("input[name='week']:checked").map(function() {
        return this.value;
    }).get().join(",");

    const searchData = $("#searchData").val();

    $.ajax({
        url: getContextPath() + "/home/searchcoursebyrest",
        method: "GET",
        data: {
            schools: schools,
            category: category,
            region: region,
            weeks: weeks,
            searchData: searchData
        },
        success: function(data) {
            $("#courselist-container").html(data);
        }
    })
}


function getContextPath() {
    return "/" + window.location.pathname.split("/")[1];
}