<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<section>
  <div class="container">
    <div class="row">
      <c:if var="courseFlag" test="${not empty courses}">
        <c:forEach var="course" items="${courses}">
          <div class="col-6 col-md-4 col-lg-2 m-3">
            <div class="card h-100">
              <a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${course.courseNo}">
                <img src="${pageContext.request.contextPath}/resources/upload/${course.thumbnail}" class="card-img-top" alt="썸네일">
                <div class="card-body">
                    ${course.courseTitle}
                </div>
              </a>
            </div>
          </div>
        </c:forEach>
      </c:if>
      <c:if test="${not courseFlag}">
        <div class="col-12">조회된 결과가 없습니다.</div>
      </c:if>
    </div>

    <div class="d-flex justify-content-center">
      ${pageBar}
    </div>
  </div>
</section>
