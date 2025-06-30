<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<section class="main-content">
    <!-- attach slide -->
    <div id="imageCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <c:if var="filesFlag" test="${not empty course.files}">
                <c:forEach var="file" items="${course.files}">
                    <div class="carousel-item ${ file.courseAttachLevel == 1?'active':''}">
                        <img alt="${file.courseAttachName}" src="${pageContext.request.contextPath}/resources/upload/course/${file.courseAttachName}" class="d-block w-100">
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${not filesFlag}">
                <div class="carousel-item active">
                    <img alt="img" src="${pageContext.request.contextPath}/resources/upload/course/${course.thumbnail}" class="d-block w-100">
                </div>
            </c:if>
        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#imageCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
            <span class="visually-hidden">Prev</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#imageCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
            <span class="visually-hidden">Next</span>
        </button>

        <div class="carousel-indicators">
            <c:if test="${filesFlag}">
                <c:forEach var="file" items="${course.files}">
                    <button type="button" data-bs-target="#imageCarousel" data-bs-slide-to="${file.courseAttachLevel - 1}" class="${file.courseAttachLevel == 1?'active':''}" aria-current="true"></button>
                </c:forEach>
            </c:if>
        </div>
    </div>
</section>
<%@include file="/WEB-INF/views/common/footer.jsp"%>
