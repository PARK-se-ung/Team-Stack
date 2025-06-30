<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="${pageContext.request.contextPath}/resources/js/home.js"></script>
    <!-- section -->
    <section class="main-container">
        <div class="category" id="category-selector">
            <button class="btn btn-outline-orange me-3" onclick="courseList('전체')">전체</button>
            <button class="btn btn-outline-orange me-3" onclick="courseList('국어')">국어</button>
            <button class="btn btn-outline-orange me-3" onclick="courseList('수학')">수학</button>
            <button class="btn btn-outline-orange me-3" onclick="courseList('영어')">영어</button>
            <button class="btn btn-outline-orange me-3" onclick="courseList('과학')">과학</button>
            <button class="btn btn-outline-orange me-3" onclick="courseList('코딩')">코딩</button>
            <button class="btn btn-outline-orange me-3" onclick="courseList('정보')">정보</button>
            <button class="btn btn-outline-orange me-3" onclick="courseList('기타')">기타</button>
        </div>
        <div class="list">
            <h3>최근 본 강의 </h3>
            <div class="image-container">
                <c:if var="cookieFlag" test="${not empty recentCourses}">
                    <c:forEach var="course" items="${recentCourses}">
                        <div class="card" style="width: 18rem;">
                            <a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${course.courseNo}">
                                <img src="${pageContext.request.contextPath}/resources/upload/${course.thumbnail}" class="card-img-top" alt="썸네일">
                                <div class="card-body">
                                        ${course.courseTitle}
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${not cookieFlag}">
                    <div class="blank">
                        <p>조회된 결과가 없습니다.</p>
                    </div>
                </c:if>
            </div>
        </div>
        <div class="list">
            <h3>초등학교</h3>
            <div class="image-container">
                <c:if var="elemFlag" test="${not empty course.get('elem')}">
                    <c:forEach var="course" items="${course.get('elem')}">
                        <div class="card" style="width: 18rem;">
                            <a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${course.courseNo}">
                                <img src="${pageContext.request.contextPath}/resources/upload/${course.thumbnail}" class="card-img-top" alt="썸네일">
                                <div class="card-body">
                                        ${course.courseTitle}
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${not elemFlag}">
                    <div class="blank">
                        <p>조회된 결과가 없습니다.</p>
                    </div>
                </c:if>
            </div>
        </div>
        <div class="list">
            <h3>중학교</h3>
            <div class="image-container">
                <c:if var="elemFlag" test="${not empty course.get('midd')}">
                    <c:forEach var="course" items="${course.get('midd')}">
                        <div class="card" style="width: 18rem;">
                            <a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${course.courseNo}">
                                <img src="${pageContext.request.contextPath}/resources/upload/${course.thumbnail}" class="card-img-top" alt="썸네일">
                                <div class="card-body">
                                        ${course.courseTitle}
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${not elemFlag}">
                    <div class="blank">
                        <p>조회된 결과가 없습니다.</p>
                    </div>
                </c:if>
            </div>
        </div>
        <div class="list">
            <h3>고등학교</h3>
            <div class="image-container">
                <c:if var="elemFlag" test="${not empty course.get('high')}">
                    <c:forEach var="course" items="${course.get('high')}">
                        <div class="card" style="width: 18rem;">
                            <a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${course.courseNo}">
                                <img src="${pageContext.request.contextPath}/resources/upload/${course.thumbnail}" class="card-img-top" alt="썸네일">
                                <div class="card-body">
                                        ${course.courseTitle}
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${not elemFlag}">
                    <div class="blank">
                        <p>조회된 결과가 없습니다.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>