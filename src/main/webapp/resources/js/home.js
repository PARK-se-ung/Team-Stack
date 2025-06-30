$("#category-selector>button").on("click", () => {
    const category = $(this).val();
    location.assign(getContextPath() + "/home/searchcourselist?category=" + category);
})