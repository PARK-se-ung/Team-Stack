<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<section>
  <div class="d-flex justify-content-between align-items-center">
    <c:if var="courseFlag" test="${not empty courses}">
      <c:forEach var="course" items="${courses}">
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
    <c:if test="${not courseFlag}">
      조회된 결과가 없습니다.
    </c:if>
  </div>
  <div>
    ${pageBar}
  </div>
</section>
