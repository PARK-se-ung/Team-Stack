<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 25. 6. 20.
  Time: 오후 2:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>
<!-- 상단 탭이 존재하는 경우 -->
<div class="navs">
  <div class="nav-item active" data-nav="open">강의 개설</div>
  <div class="nav-item" data-nav="courseapply">강의 개설 승인</div>
  <div class="nav-item" data-nav="studentapply">신청 학생 승인</div>
  <div class="nav-item" data-nav="coursetake">진행중인 강의</div>
  <div class="nav-item" data-nav="coursecomplete">만료한 강의</div>
</div>
<!-- 아래 div안에서 필요한 html 코드 작성 -->
<style>
  .image-upload {
    width: 100%;
    height: 120px;
    border: 2px dashed #aaa;
    border-radius: 8px;
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }

  .image-upload img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: none;
  }

  .image-upload span {
    color: #555;
    font-size: 14px;
  }

  .image-upload input[type="file"] {
    display: none;
  }

  .ex-upload {
    width: 100px;
    height: 100px;
    border: 2px dashed #aaa;
    border-radius: 8px;
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }

  .ex-upload img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: none;
  }

  .ex-upload span {
    color: #555;
    font-size: 14px;
  }

  .ex-upload input[type="file"] {
    display: none;
  }


  .flex {
    display: flex;
    gap: 20px;
  }

  .section1 input[type="text"],
  input[type="number"],
  textarea {
    width: 100%;
    padding: 10px;
    margin-top: 8px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    box-sizing: border-box;
  }

  .fileText {
    color: white;
  }

  .fileText input[type="file"] {
    display: none;
  }

  label {
    font-weight: bold;
    display: block;
    margin-top: 12px;
  }

  .file-box {
    background: #ff7d4d;
    padding: 10px 20px;
    border-radius: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 20px;
  }

  .file-box span {
    color : white;
  }

  .submit-btn {
    display: block;
    margin: 20px auto 0;
    padding: 10px 30px;
    font-size: 16px;
    cursor: pointer;
  }

  .submit-btn:hover {
    background: #ff7d4d;
  }
</style>


<form action="/submit" method="post" enctype="multipart/form-data">
  <div class="container1">
    <div class="image-upload" onclick="document.getElementById('imageInput').click();">
      <img id="preview" alt="미리보기">
      <span id="placeholder">강의 썸네일</span>
      <input type="file" name="image" id="imageInput" accept="image/*" onchange="previewImage(event)">
    </div>
    <!-- 강좌 정보 -->
    <div class="section1 flex">
      <div style="flex: 1">
        <label>강의명</label>
        <input type="text" name="title" placeholder="강의명을 입력해주세요.">

        <label>강사명</label>
        <input type="text" name="teacher" placeholder="강사명을 입력해주세요.">

        <label>설명</label>
        <div class="ex-upload" onclick="document.getElementById('ex-imageInput').click();">
          <img id="preview" alt="미리보기">
          <span id="placeholder">상세 이미지</span>
          <input type="file" name="image" id="ex-imageInput" accept="image/*" onchange="previewImage(event)">
        </div>

        <label>가격</label>
        <input type="number" name="price" placeholder="가격을 입력해주세요.">

        <label>교과목</label>
        <input type="text" name="category" placeholder="#교과목">
      </div>
    </div>
  </div>

  <!-- 상세 설명 -->
  <div class="section1">
    <label>일정</label>
    <input type="text" name="date" placeholder="시작일 (총주차)">
    <%-- 강의 시간 몇시간 할건지 추가 분단위  --%>

    <label>장소</label>

    <input type="text" name="location" placeholder="서울시 금천구 00빌딩">
    <%--  시,도 select로 결정하게 해두고 그 이후는 텍스트로 받기  --%>
  </div>

  <!-- 첨부파일 -->
  <div class="file-box">
    <span>강의 계획서</span>
    <input class="fileText" type="file" name="file" accept=".pdf">
  </div>

  <button type="submit" class="submit-btn btn btn-outline-orange">강좌 개설 신청</button>
</form>


</div>

<!-- nav 전환 로직 -->
<script>
  $(".nav-item").on('click', function() {
    let $current = $(this);
    let tabId = $current.data('nav');
    $(".nav-item").removeClass("active");
    $current.addClass("active");
    tabLoad(tabId);
  });

  function previewImage(event) {
    const input = event.target;
    const preview = document.getElementById('preview');
    const placeholder = document.getElementById('placeholder');

    if (input.files && input.files[0]) {

      const reader = new FileReader();
      reader.onload = function(e) {
        preview.src = e.target.result;
        preview.style.display = 'block';
        placeholder.style.display = 'none';
      };
      reader.readAsDataURL(input.files[0]);
    }
  }





</script>