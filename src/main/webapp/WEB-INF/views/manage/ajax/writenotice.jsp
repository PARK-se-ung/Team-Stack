<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class=".main-content">
    <h2>공지 작성</h2>
    <div class="d-flex align-items-center">
        <select class="form-select" id="alarm" name="alarm">
            <option selected value="none"> 알람 전송</option>
            <option value="none">미전송</option>
            <option value="I">강사 전송</option>
            <option value="T">전체 전송</option>
        </select>
        <button class="btn btn-outline-orange" onclick="insertNotice()"> 등록 </button>
    </div>
    <hr>
    <input class="me-3 form-control" type="text" id="title" name="noticeTitle" placeholder="제목 입력">
    <textarea class="form-control" id="content" name="noticeContent" placeholder="공지 내용 입력"></textarea>

</section>
