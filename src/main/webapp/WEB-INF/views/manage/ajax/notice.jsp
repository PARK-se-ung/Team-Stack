<%--
  Created by IntelliJ IDEA.
  User: qkrtp
  Date: 2025-06-24
  Time: 오전 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="current-container">
    <h2> 공지 사항</h2>
    <button class="btn btn-outline-orange" onclick="manageLoad('writenotice')"> 작성 </button>
    <hr>
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
        <c:if test="${empty notices}">
            <td colspan="5" class="text-center"> 조회된 결과가 없습니다.</td>
        </c:if>
        <c:if test="${noticeFlag}">
            <c:forEach var="notice" items="${notices}">
                <td>notice.noticeNo</td>
                <td>notice.noticeTitle</td>
                <td>notice.noticeDate</td>
                <td><button>수정</button></td>
                <td><button>삭제</button></td>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
    <div>
        ${pageBar}
    </div>
</div>
