function courseList(category) {
    location.assign(getContextPath() + "/home/searchcourselist?category=" + category);
}

function loadCourseList() {
    const [schools, category, region, weeks, searchData] = getRestrict();

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
    return [schools, category, region, weeks, searchData];
}
function loadCourse(cPage) {
    const [schools, category, region, weeks, searchData] = getRestrict();
    $.ajax({
        url: getContextPath() + "/home/searchcoursebyrest",
        method: "GET",
        data: {
            schools: schools,
            category: category,
            region: region,
            weeks: weeks,
            searchData: searchData,
            cPage: cPage
        },
        success: function(data) {
            console.log(data);
            $("#course-container").html(data);
        }
    })
}

function getContextPath() {
    return "/" + window.location.pathname.split("/")[1];
}