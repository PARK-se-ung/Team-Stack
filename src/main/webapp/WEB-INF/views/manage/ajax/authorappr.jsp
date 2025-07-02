<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<h2> 강사 권한 승인</h2>
<hr>
<div id="approve-container">
    <table>
        <thead>
        <tr>
            <th>번호</th>
            <th>강의정보</th>
            <th>신청일</th>
            <th>신청자</th>
            <th>승인</th>
            <th>반려</th>
        </tr>
        </thead>
        <tbody>
        <c:if var="approveFlag" test="${empty approves}">
            <td colspan="6" class="text-center"> 조회된 결과가 없습니다.</td>
        </c:if>
        <c:if test="${!approveFlag}">
            <c:forEach var="approve" items="${approves}">
                <tr>
                    <td>${approve.approveNo}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/manage/download?oriname=${approve.approveOrigin}&rename=${approve.approveRename}">
                                ${approve.approveOrigin}
                        </a>
                    </td>
                    <td>
                        <fmt:formatDate value="${approve.approveDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>
                        ${approve.userId}
                    </td>
                    <td>
                        <button class="btn btn-outline-orange authorAppr" data-user="${approve.userId}" data-no="${approve.approveNo}" data-status="A">승인</button>
                    </td>
                    <td>
                        <button class="btn btn-outline-orange authorAppr" data-user="${approve.userId}" data-no="${approve.approveNo}" data-status="D">반려</button>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
</div>
<br>
<div class="pageBar-container">
    ${pageBar}
</div>
