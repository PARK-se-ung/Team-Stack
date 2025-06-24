<%--
  Created by IntelliJ IDEA.
  User: qkrtp
  Date: 2025-06-24
  Time: 오전 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<h2> 공지 사항</h2>
<hr>
<c:if test="${empty notices}">
    
</c:if>
<c:forEach var="notice" items="${notices}">

</c:forEach>

<%@include file="/WEB-INF/views/common/footer.jsp"%>
