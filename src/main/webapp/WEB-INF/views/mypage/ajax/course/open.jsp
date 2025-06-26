<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.ts.teamstack.user.model.dto.Users" %>
<%
  Users loginUser = (Users)session.getAttribute("loginUser");
%>

<script src="${pageContext.request.contextPath}/resources/js/page.js"></script>

<div class="navs">
  <div class="nav-item active" data-nav="open">강의 개설</div>
  <div class="nav-item" data-nav="courseapply">강의 개설 승인</div>
  <div class="nav-item" data-nav="studentapply">신청 학생 승인</div>
  <div class="nav-item" data-nav="coursetake">진행중인 강의</div>
  <div class="nav-item" data-nav="coursecomplete">만료한 강의</div>
</div>

<style>
  .image-upload {
    width: 100%;
    height: 300px;
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

  .detail-upload {
    width: 100%;
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

  .image-upload img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain; /* 이미지가 안 잘리도록 수정 */
    display: none;
  }

  .image-upload span {
    color: #555;
    font-size: 24px;
  }

  .image-upload input[type="file"] {
    display: none;
  }

  .slide-image {
    gap: 6px;
  }

  .ex-upload, .addButton {
    width: 200px;
    height: 200px;
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
    color: white;
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
    background-color: transparent;
  }

  .custom-file-button {
    background-color: #fff;
    color: #ff7d4d;
    padding: 6px 16px;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    border: 2px solid #ff7d4d;
    margin-left: auto;
    transition: background 0.3s ease;
    margin-bottom: 12px;
  }

  .custom-file-button:hover {
    background-color: #ff7d4d;
    color: #fff;
  }
</style>

<form action="${pageContext.request.contextPath}/course/insert" method="post" enctype="multipart/form-data" id="courseForm">
  <div class="container1">
    <div class="image-upload" onclick="document.getElementById('imageInput').click();">
      <img id="preview" alt="미리보기">
      <span id="placeholder">강의 썸네일</span>
      <input type="file" name="thumbnail" id="imageInput" accept="image/*" required onchange="previewImage(event)">
    </div>

    <div class="section1 flex">
      <div style="flex: 1">
        <label>강의명</label>
        <input type="text" name="courseTitle" id="title" placeholder="강의명을 입력해주세요." required>

        <label>강사명</label>
        <input type="text" name="userId" placeholder="강사명을 입력해주세요."  value="<%= loginUser.getName() %>" >

        <label>슬라이드 이미지</label>
        <div class="slide-image" id="slideImageContainer" style="display: flex">
          <div class="ex-upload">
            <img class="preview" alt="미리보기">
            <span class="placeholder">슬라이드 이미지</span>
            <input type="file" name="slideImage" accept="image/*" required onchange="previewImage2(event)">
          </div>
          <button type="button" class="addButton">+</button>
        </div>

        <label>상세 이미지</label>
        <div class="detailImage" id="detailImageContainer" style="display: flex">
          <div class="detail-upload"
               onclick="document.getElementById('detailInput').click();">
            <img id="preview" alt="미리보기">
            <span id="detailPlaceholder">상세 이미지</span>
            <input type="file" id="detailInput" name="courseContent" accept="image/*" style="display:none" required onchange="previewImage3(event)">
          </div>
        </div>


        <label>가격</label>
        <input type="number" name="coursePrice" id="price" placeholder="가격을 입력해주세요." required>

        <label>교과목</label>
        <input type="text" name="subject" placeholder="#교과목" id="catagory" required>
      </div>
    </div>
  </div>

  <div class="section1">
    <label>일정</label>
    <input type="text" id="datePicker" placeholder="시작일 (총주차)" name="courseStartTime">

    <label>장소</label>
    <div class="location">
      <select name="region" id="location" required>
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
      <input type="text" name="courseAddress" id="locationDetail" placeholder="상세주소를 입력해주세요.">
    </div>
  </div>

  <div class="file-box">
    <span>강의 계획서</span>
    <label for="planFile" class="custom-file-button">파일 선택</label>
    <input type="file" name="originalPlanName" id="planFile" accept=".pdf" style="display: none;">
    <span id="fileName" style="color:white; margin-left: 10px;"></span>
  </div>

  <button type="button" class="submit-btn btn btn-outline-orange" data-bs-toggle="modal" data-bs-target="#confirmModal">강의 개설 신청</button>
</form>

<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmModalLabel">강의 개설 확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        입력하신 내용으로 강의 개설을 신청하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" formmethod="post" id="modalConfirmBtn">확인</button>
      </div>
    </div>
  </div>
</div>

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

  function previewImage3(event) {
    const input = event.target;
    const container = input.closest('.detail-upload');
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

  document.querySelector('.addButton').addEventListener('click', function (e) {
    e.preventDefault();

    const container = document.getElementById('slideImageContainer');
    const currentBoxes = container.querySelectorAll('.ex-upload').length;

    if (currentBoxes >= 3) {
      alert("슬라이드 이미지는 최대 3개까지만 업로드할 수 있습니다.");
      return;
    }

    const newBox = document.createElement('div');
    newBox.className = 'ex-upload';

    newBox.innerHTML = `
      <img class="preview" alt="미리보기">
      <span class="placeholder">슬라이드 이미지</span>
      <input type="file" name="silideImage" accept="image/*" required onchange="previewImage2(event)">
    `;

    container.insertBefore(newBox, this);
  });

  document.addEventListener('DOMContentLoaded', () => {
    document.querySelector('.detail-upload')
            .addEventListener('click', () => {
              document.querySelector('.detail-upload input[type="file"]').click();
            });
  });

  document.addEventListener('click', function (e) {
    if (e.target.closest('.ex-upload')) {
      const uploadBox = e.target.closest('.ex-upload');
      const fileInput = uploadBox.querySelector('input[type="file"]');
      fileInput.click();
    }
  });

  document.getElementById('planFile').addEventListener('change', function () {
    const fileName = this.files[0] ? this.files[0].name : '';
    document.getElementById('fileName').textContent = fileName;
  });

  document.getElementById('modalConfirmBtn').addEventListener('click', function () {
    const form = document.getElementById('courseForm');

    const fd = new FormData(form);
    for (let [key, val] of fd.entries()) {
      console.log(`📤 ${key} →`, val);
    }

    if (form.reportValidity()) {
      form.submit(); // 유효하면 전송
      alert("신청 완료")
    } else {
      const modal = bootstrap.Modal.getInstance(document.getElementById('confirmModal'));
      if (modal) {
        modal.hide();
      }
    }
  });









</script>
