<%--
  Created by IntelliJ IDEA.
  User: qkrtp
  Date: 2025-06-24
  Time: 오후 2:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class=".main-content">
    <h2>공지 작성</h2>
    <button class="btn btn-outline-orange" onclick="insertNotice()"> 등록 </button>
    <select id="alarm" name="alarm">
        <option selected value="none"> 알람 전송</option>
        <option value="none">미전송</option>
        <option value="I">강사 전송</option>
        <option value="T">전체 전송</option>
    </select>
    <hr>
    <input type="text" id="title" name="noticeTitle" placeholder="제목 입력">
    <textarea id="content" name="noticeContent" placeholder="공지 내용 입력">

    </textarea>

</section>
