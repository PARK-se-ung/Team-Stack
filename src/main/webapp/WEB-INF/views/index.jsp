<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <!-- section -->
    <section class="main-container">
        <div class="category">
            <button class="btn btn-outline-orange me-3">국어</button>
            <button class="btn btn-outline-orange me-3">수학</button>
            <button class="btn btn-outline-orange me-3">영어</button>
            <button class="btn btn-outline-orange me-3">사회</button>
            <button class="btn btn-outline-orange me-3">과학</button>
            <button class="btn btn-outline-orange me-3">체육</button>
            <button class="btn btn-outline-orange me-3">음악</button>
            <button class="btn btn-outline-orange me-3">미술</button>
        </div>
        <div class="list">
            <h3>최근 본 강의 </h3>
            <div class="image-container">
                <div class="blank">
                    <p>조회된 결과가 없습니다.</p>
                </div>
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
                    조회된 결과가 없습니다.
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
                    조회된 결과가 없습니다.
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
                    조회된 결과가 없습니다.
                </c:if>
            </div>
        </div>
    </section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>