<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class=".main-content">
    <h2>
        <c:if var="noticeFlag" test="${notice == null}">
            공지 작성
        </c:if>
        <c:if test="${not noticeFlag}">
            공지 수정
        </c:if>
    </h2>
    <div class="d-flex align-items-center">
        <select class="form-select" id="alarm" name="alarm">
            <option selected value="none"> 알람 전송</option>
            <option value="none">미전송</option>
            <option value="I">강사 전송</option>
            <option value="T">전체 전송</option>
        </select>
        <button class="btn btn-outline-orange" onclick="${not noticeFlag? 'updateNotice()' : 'insertNotice()'}">
            <c:if  test="${noticeFlag}">
                등록
            </c:if>
            <c:if test="${not noticeFlag}">
                수정
            </c:if>
        </button>
    </div>
    <hr>
    <c:if test="${not noticeFlag}">
        <input id="no" type="hidden" value="${notice.noticeNo}">
    </c:if>
    <input class="me-3 form-control" type="text" id="title" name="noticeTitle" placeholder="제목 입력"
           value="${not noticeFlag? notice.noticeTitle:''}">
    <br>
    <textarea class="form-control" id="content" name="noticeContent" placeholder="공지 내용 입력">${not noticeFlag != null? notice.noticeContent:''}</textarea>
</section>
