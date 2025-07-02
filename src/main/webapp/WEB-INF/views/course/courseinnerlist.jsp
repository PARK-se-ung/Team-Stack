<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/manage.css">
<section>
  <table>
    <thead>
    <tr>
      <th>번호</th>
      <th>강좌명</th>
      <th>지역</th>
      <th>과목</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${not empty courses}" var="courseFlag">
      <c:forEach var="course" items="${courses}">
        <tr>
          <td>${course.courseNo}</td>
          <td><a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${course.courseNo}">${course.courseTitle}</a></td>
          <td>${course.region}</td>
          <td>${course.subject}</td>
        </tr>
      </c:forEach>
    </c:if>
    <c:if test="${not courseFlag}">
      <tr>
        <td colspan="4" class="text-center">조회된 결과가 없습니다.</td>
      </tr>
    </c:if>
    </tbody>
  </table>
  <div class="d-flex justify-content-center">
    ${pageBar}
  </div>
</section>
