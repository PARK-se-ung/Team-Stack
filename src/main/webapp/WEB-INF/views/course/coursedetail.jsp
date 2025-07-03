<%@ page import="org.ts.teamstack.course.model.dto.Course" %>
<%@ page import="java.sql.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<%
    Date recruitDate = ((Course) request.getAttribute("course")).getRecruitDate();
    Date courseStartDate = ((Course) request.getAttribute("course")).getCourseStartDate();
    Date current = new Date(System.currentTimeMillis());
    boolean isReserve = current.before(recruitDate);
    boolean isApply = recruitDate.before(current) && current.before(courseStartDate);
    boolean isDone = courseStartDate.before(current);
    request.setAttribute("isReserve", isReserve);
    request.setAttribute("isApply", isApply);
    request.setAttribute("isDone", isDone);
%>
<section class="main-content" style="margin: 3%">
    <!-- attach slide -->
    <div class="slide-img">
        <div id="imageCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <c:if var="filesFlag" test="${not empty course.files}">
                    <c:forEach var="file" items="${course.files}">
                        <div class="carousel-item ${file.courseAttachLevel == 1 ? 'active' : ''}">
                            <img
                                    src="${pageContext.request.contextPath}/resources/upload/course/${file.courseAttachName}"
                                    alt="${file.courseAttachName}"
                                    class="d-block w-100 h-100">
                        </div>
                    </c:forEach>
                </c:if>

                <c:if test="${not filesFlag}">
                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/resources/upload/course/${course.thumbnail}"
                            alt="thumbnail"
                            class="d-block w-100 h-100">
                    </div>
                </c:if>
            </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#imageCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#imageCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
                <span class="visually-hidden">Next</span>
            </button>

            <div class="carousel-indicators">
                <c:if test="${filesFlag}">
                    <c:forEach var="file" items="${course.files}">
                        <button type="button"
                                data-bs-target="#imageCarousel"
                                data-bs-slide-to="${file.courseAttachLevel - 1}"
                                class="${file.courseAttachLevel == 1 ? 'active' : ''}"
                                aria-current="true">
                        </button>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>

    <!-- info container -->
    <div class="row mt-5">
        <!-- plan -->
        <div class="col-lg-4">
            <h3>강의 계획서</h3>
            <hr>
            <div style="display: flex; justify-content: center;">
                <canvas id="pdf-render" style="border: 1px solid #ccc; max-height: 60vh;"></canvas>
            </div>
            <div class="pdf-pagination text-center mt-3">
            <button id="prevpage" class="btn btn-outline-orange">이전</button>
            <span id="pageInfo" class="pdf-page-info">1 / ?</span>
            <button id="nextpage" class="btn btn-outline-orange">다음</button>
        </div>
        </div>
        <!-- course list -->
        <div class="col-lg-8">
            <h3>최근 내가 본 강의 확인하기</h3>
            <hr>
            <div class="container">
                <div class="row">
                    <c:if var="recentFlag" test="${not empty recentCourses}">
                        <c:forEach var="course" items="${recentCourses}">
                            <div class="col-6 col-md-4 col-lg-2 m-3">
                                <div class="card h-100">
                                    <a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${course.courseNo}">
                                        <img src="${pageContext.request.contextPath}/resources/upload/${course.thumbnail}"
                                             class="card-img-top"
                                             alt="썸네일"
                                             onerror="this.src='${pageContext.request.contextPath}/resources/images/default-thumbnail.png'">
                                        <div class="card-body">
                                                ${course.courseTitle}
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not recentFlag}">
                        <div class="col-12 text-center">조회된 결과가 없습니다.</div>
                    </c:if>
                </div>
            </div>
            <br>
            <h3>이 강사의 다른 강의 확인하기</h3>
            <hr>
            <div class="container">
                <div class="row">
                    <c:if var="courseFlag" test="${not empty courses}">
                        <c:forEach var="course" items="${courses}">
                            <div class="col-6 col-md-4 col-lg-2 m-3">
                                <div class="card h-100">
                                    <a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${course.courseNo}">
                                        <img src="${pageContext.request.contextPath}/resources/upload/${course.thumbnail}"
                                             class="card-img-top"
                                             alt="썸네일"
                                             onerror="this.src='${pageContext.request.contextPath}/resources/images/default-thumbnail.png'">
                                        <div class="card-body">
                                                ${course.courseTitle}
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not courseFlag}">
                        <div class="col-12 text-center">조회된 결과가 없습니다.</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <hr>
    <div class="row">
        <!-- detail-container -->
        <div class="text-center col-lg-8">
            <img src="${pageContext.request.contextPath}/resources/upload/course/${course.courseContent}" alt="${course.courseContent}">
        </div>
        <!-- button-container -->
        <div class="text-center col-lg-4">
            <div class="sticky-sidebar">
                <h3> ${course.courseTitle} </h3>
                <hr>
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        강사: ${course.userId}
                    </div>
                    <div class="d-flex justify-content-center align-items-center">
                        <button class="me-3 btn btn-outline-primary bookmark" data-no="${course.courseNo}">
                            <i class="bi ${bookmark == null?'bi-bookmark':'bi-bookmark-fill'}"></i>
                        </button>
                        <c:if var="applyTest" test="${apply == null}">
                            <c:if test="${isReserve}">
                                <button class="btn btn-outline-orange btn-apply"
                                        data-no="${course.courseNo}"
                                        data-title="${course.courseTitle}"
                                        data-price="${course.coursePrice}"
                                        data-type="RESERVE",
                                        data-id="${sessionScope.loginUser.userId}",
                                        data-mail="${sessionScope.loginUser.userEmail}"
                                        data-name="${sessionScope.loginUser.name}"
                                        data-tel="${sessionScope.loginUser.userPhone}">
                                    예약
                                </button>
                            </c:if>
                            <c:if test="${isApply}">
                                <button class="btn btn-outline-orange btn-apply"
                                        data-no="${course.courseNo}"
                                        data-title="${course.courseTitle}"
                                        data-price="${course.coursePrice}"
                                        data-type="APPLY",
                                        data-id="${sessionScope.loginUser.userId}",
                                        data-mail="${sessionScope.loginUser.userEmail}"
                                        data-name="${sessionScope.loginUser.name}"
                                        data-tel="${sessionScope.loginUser.userPhone}">
                                    신청
                                </button>
                            </c:if>
                            <c:if test="${isDone}">
                                <button class="btn btn-outline-secondary" disabled>
                                    모집 종료
                                </button>
                            </c:if>
                        </c:if>
                        <c:if test="${not applyTest}">
                            <c:if test="${isReserve}">
                                <button class="btn btn-outline-danger btn-refund" data-no="${course.courseNo}" data-id="${sessionScope.loginUser.userId}">
                                    예약 취소
                                </button>
                            </c:if>
                            <c:if test="${not isReserve}">
                                <button class="btn btn-outline-danger btn-applyRefund" data-no="${course.courseNo}" data-id="${sessionScope.loginUser.userId}">
                                    신청 취소
                                </button>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/pdf/build/pdf.mjs" type="module"></script>
<script src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<script type="module">
    pdfjsLib.GlobalWorkerOptions.workerSrc = '${pageContext.request.contextPath}/resources/js/pdf/build/pdf.worker.mjs';
    import { initPdfViewer } from '${pageContext.request.contextPath}/resources/js/pdf-viewer.js';

    // 서버에서 받아온 파일명을 기반으로 PDF 경로 설정
    const pdfUrl = '${pageContext.request.contextPath}/resources/upload/course/${course.renamePlanName}';

    // Viewer 실행
    initPdfViewer({
        url: pdfUrl,
        canvasId: 'pdf-render',
        prevBtnId: 'prevpage',
        nextBtnId: 'nextpage',
        pageInfoId: 'pageInfo',
        scale: 1.5
    });
</script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>
