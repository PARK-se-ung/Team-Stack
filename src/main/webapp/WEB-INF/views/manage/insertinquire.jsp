<%--
  Created by IntelliJ IDEA.
  User: qkrtp
  Date: 2025-06-25
  Time: 오후 4:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/manage.js"></script>
<section>
    <article class="main-content m-3">
        <h2>문의 작성</h2>
        <hr>
        <div class="row justify-content-between align-items-center">
            <div class="col-lg-11">
                <input id="userId" type="text" disabled class="form-control" value="user_0001">
                <input id="title" type="text" class="form-control" placeholder="제목 입력">
            </div>
            <div class="col-lg-1 d-flex justify-content-end align-items-center">
                <button class="btn btn-outline-orange" onclick="insertInquire()"> 작성 </button>
            </div>
        </div>
        <br>
        <div>
            <textarea id="content" class="form-control" placeholder="문의 내역을 작성해주세요" style="width: 100%; min-height: 600px"></textarea>
        </div>
    </article>
</section>
<%@include file="/WEB-INF/views/common/footer.jsp"%>
