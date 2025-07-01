<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="current-container">
    <h2> 공지 사항</h2>
    <button class="btn btn-outline-orange" onclick="manageLoad('writenotice')"> 작성 </button>
    <hr>
    <div id="notice-container" class="me-3">
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
            <c:if var="noticeFlag" test="${empty notices}">
                <td colspan="5" class="text-center"> 조회된 결과가 없습니다.</td>
            </c:if>
            <c:if test="${!noticeFlag}">
                <c:forEach var="notice" items="${notices}">
                    <tr>
                        <td>${notice.noticeNo}</td>
                        <td>${notice.noticeTitle}</td>
                        <td><fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <button class="btn btn-outline-orange" data-no="${notice.noticeNo}" id="notice-convertor">수정</button>
                        </td>
                        <td>
                            <button class="btn btn-outline-orange" data-no="${notice.noticeNo}" id="notice-delete">삭제</button>
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
</div>
