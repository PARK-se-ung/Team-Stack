<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
111111111111111111111
<div>
    <table>
    <c:forEach var="c" items="${chattingHistory}">
        <p>
            ${c.userId}
        </p>
    </c:forEach>
    </table>
</div>
