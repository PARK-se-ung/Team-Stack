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

  .detailImage {
    gap: 6px;
  }

  .ex-upload ,.addButton {
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

  .location {
    display: flex;
  }

  select#location {
    margin-right: 10px;
    margin-top: 10px;
    width: 100px;
    height: 40px;
  }

  .placeholder {
    background-color: rgb(85 85 85 / 0%);
  }

</style>


<form action="/submit" method="post" enctype="multipart/form-data">
  <div class="container1">
    <div class="image-upload" onclick="document.getElementById('imageInput').click();">
      <img id="preview" alt="미리보기">
      <span id="placeholder">강의 썸네일</span>
      <input type="file" name="image" id="imageInput" accept="image/*" required onchange="previewImage(event)">
    </div>
    <!-- 강좌 정보 -->
    <div class="section1 flex">
      <div style="flex: 1">
        <label>강의명</label>
        <input type="text" name="title" placeholder="강의명을 입력해주세요." required>

        <label>강사명</label>
        <input type="text" name="teacher" placeholder="강사명을 입력해주세요." required>

        <label>설명</label>
        <div class="detailImage" id="detailImageContainer" style="display: flex">
          <!-- 초기 상세 이미지 업로드 박스 -->
          <div class="ex-upload">
            <img class="preview" alt="미리보기">
            <span class="placeholder">상세 이미지</span>
            <input type="file" name="image2" accept="image/*" required onchange="previewImage2(event)">
          </div>
          <button class="addButton">+</button>
        </div>


        <label>가격</label>
        <input type="number" name="price" placeholder="가격을 입력해주세요." required>

        <label>교과목</label>
        <input type="text" name="category" placeholder="#교과목" required>
      </div>
    </div>
  </div>

  <!-- 상세 설명 -->
  <div class="section1">
    <label>일정</label>
    <input type="text" id="datePicker" placeholder="시작일 (총주차)" name="date">
    <%-- 강의 시간 몇시간 할건지 추가 분단위  --%>

    <label>장소</label>
    <div class="location">
      <select name="location" id="location" required>
        <option value="">선택하세요</option>
        <option value="서울특별시">서울특별시</option>
        <option value="부산광역시">부산광역시</option>
        <option value="대구광역시">대구광역시</option>
        <option value="인천광역시">인천광역시</option>
        <option value="광주광역시">광주광역시</option>
        <option value="대전광역시">대전광역시</option>
        <option value="울산광역시">울산광역시</option>
        <option value="세종특별자치시">세종특별자치시</option>
        <option value="경기도">경기도</option>
        <option value="강원도">강원도</option>
        <option value="충청북도">충청북도</option>
        <option value="충청남도">충청남도</option>
        <option value="전라북도">전라북도</option>
        <option value="전라남도">전라남도</option>
        <option value="경상북도">경상북도</option>
        <option value="경상남도">경상남도</option>
        <option value="제주특별자치도">제주특별자치도</option>
      </select>
      <input type="text" name="locationDetail" placeholder="상세주소를 입력해주세요.">
    </div>
  </div>




    <%--  시,도 select로 결정하게 해두고 그 이후는 텍스트로 받기  --%>


  <!-- 첨부파일 -->
  <div class="file-box">
    <span>강의 계획서</span>
    <input class="fileText" type="file" name="file" accept=".pdf">
  </div>

  <button type="submit" class="submit-btn btn btn-outline-orange">강좌 개설 신청</button>

</form>



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
    const container = input.closest('.image-upload');
    const preview = container.querySelector('img');
    const placeholder = container.querySelector('span');

    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = function(e) {
        preview.src = e.target.result;
        preview.style.display = 'block';
        if (placeholder) placeholder.style.display = 'none';
      };
      reader.readAsDataURL(input.files[0]);
    }
  }

  // 상세 이미지 미리보기
  function previewImage2(event) {
    const input = event.target;
    const container = input.closest('.ex-upload');
    const preview = container.querySelector('img');
    const placeholder = container.querySelector('span');

    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = function(e) {
        preview.src = e.target.result;
        preview.style.display = 'block';
        if (placeholder) placeholder.style.display = 'none';
      };
      reader.readAsDataURL(input.files[0]);
    }
  }

  // + 버튼 클릭 시 상세 이미지 업로드 박스 추가
  document.querySelector('.addButton').addEventListener('click', function (e) {
    e.preventDefault();

    const container = document.getElementById('detailImageContainer');

    const newBox = document.createElement('div');
    newBox.className = 'ex-upload';

    newBox.innerHTML = `
      <img class="preview" alt="미리보기">
      <span class="placeholder">상세 이미지</span>
      <input type="file" name="image2" accept="image/*" required onchange="previewImage2(event)">
    `;

    container.insertBefore(newBox, this);
  });



</script>