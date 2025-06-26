<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
  <jsp:param name="title" value="비밀번호 찾기"/>
</jsp:include>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap');

  body {
    font-family: 'Noto Sans KR', sans-serif;
    background: linear-gradient(135deg, #ff6b35 0%, #f7931e 50%, #ffb347 100%);
    min-height: 100vh;
    margin: 0;
    padding: 0;
  }

  .main-content {
    min-height: calc(100vh - 200px);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
    padding: 40px 20px;
  }

  .main-content::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.15"/><circle cx="20" cy="80" r="0.5" fill="white" opacity="0.15"/><circle cx="90" cy="30" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
    pointer-events: none;
  }

  .find-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 24px;
    padding: 48px 40px;
    width: 100%;
    max-width: 420px;
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15), 0 0 0 1px rgba(255, 255, 255, 0.1);
    position: relative;
    animation: slideUp 0.8s ease-out;
  }

  @keyframes slideUp {
    from {
      opacity: 0;
      transform: translateY(30px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .logo {
    text-align: center;
    margin-bottom: 40px;
  }

  .logo h1 {
    font-size: 32px;
    font-weight: 700;
    background: linear-gradient(135deg, #ff6b35, #f7931e);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    margin-bottom: 8px;
  }

  .logo p {
    color: #6b7280;
    font-size: 14px;
    font-weight: 400;
  }

  .page-title {
    text-align: center;
    margin-bottom: 32px;
  }

  .page-title h2 {
    font-size: 24px;
    font-weight: 600;
    color: #374151;
    margin-bottom: 8px;
  }

  .page-title p {
    color: #6b7280;
    font-size: 14px;
    line-height: 1.5;
  }

  .find-form {
    margin-bottom: 32px;
  }

  .form-group {
    position: relative;
    margin-bottom: 24px;
  }

  .form-group label {
    display: block;
    margin-bottom: 8px;
    color: #374151;
    font-weight: 500;
    font-size: 14px;
  }

  .form-group input {
    width: 100%;
    padding: 16px 20px;
    border: 2px solid #e5e7eb;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 400;
    background: #ffffff;
    transition: all 0.3s ease;
    outline: none;
  }

  .form-group input:focus {
    border-color: #ff6b35;
    box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1);
    transform: translateY(-1px);
  }

  .form-group input::placeholder {
    color: #9ca3af;
    font-weight: 400;
  }

  .find-method {
    margin-bottom: 24px;
  }

  .method-tabs {
    display: flex;
    border-radius: 12px;
    background: #f3f4f6;
    padding: 4px;
    margin-bottom: 24px;
  }

  .method-tab {
    flex: 1;
    padding: 12px;
    text-align: center;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-weight: 500;
    font-size: 14px;
    color: #6b7280;
  }

  .method-tab.active {
    background: white;
    color: #ff6b35;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  .method-content {
    display: none;
  }

  .method-content.active {
    display: block;
  }

  .verification-group {
    display: flex;
    gap: 12px;
    align-items: flex-end;
  }

  .verification-group .form-group {
    flex: 1;
    margin-bottom: 0;
  }

  .verify-btn {
    padding: 16px 20px;
    background: #f3f4f6;
    border: 2px solid #e5e7eb;
    border-radius: 12px;
    color: #374151;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    white-space: nowrap;
  }

  .verify-btn:hover {
    background: #e5e7eb;
    border-color: #d1d5db;
  }

  .verification-code {
    margin-top: 12px;
  }

  .find-btn {
    width: 100%;
    padding: 16px;
    background: linear-gradient(135deg, #ff6b35, #f7931e);
    border: none;
    border-radius: 12px;
    color: white;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
  }

  .find-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 30px rgba(255, 107, 53, 0.4);
  }

  .find-btn:active {
    transform: translateY(0);
  }

  .back-links {
    display: flex;
    justify-content: center;
    gap: 20px;
    padding-top: 16px;
    border-top: 1px solid #e5e7eb;
  }

  .back-links a {
    color: #6b7280;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    transition: color 0.3s ease;
  }

  .back-links a:hover {
    color: #ff6b35;
  }

  .floating-elements {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    pointer-events: none;
    overflow: hidden;
  }

  .floating-circle {
    position: absolute;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.1);
    animation: float 6s ease-in-out infinite;
  }

  .floating-circle:nth-child(1) {
    width: 60px;
    height: 60px;
    top: 20%;
    left: 10%;
    animation-delay: 0s;
  }

  .floating-circle:nth-child(2) {
    width: 40px;
    height: 40px;
    top: 60%;
    right: 15%;
    animation-delay: 2s;
  }

  .floating-circle:nth-child(3) {
    width: 80px;
    height: 80px;
    bottom: 20%;
    left: 15%;
    animation-delay: 4s;
  }

  @keyframes float {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    50% { transform: translateY(-20px) rotate(180deg); }
  }

  @media (max-width: 480px) {
    .find-container {
      margin: 20px;
      padding: 32px 24px;
    }

    .verification-group {
      flex-direction: column;
      gap: 16px;
    }

    .verification-group .form-group {
      margin-bottom: 0;
    }
  }
</style>

<div class="main-content">
  <div class="floating-elements">
    <div class="floating-circle"></div>
    <div class="floating-circle"></div>
    <div class="floating-circle"></div>
  </div>

  <div class="find-container">
    <div class="logo">
      <h1>사이트 이름</h1>
      <p>오프라인으로 만나는 생생한 강의</p>
    </div>

    <div class="page-title">
      <h2>비밀번호 찾기</h2>
      <p>가입 시 등록한 정보로 비밀번호를 재설정할 수 있습니다.</p>
    </div>

    <div class="find-method">
      <div class="method-tabs">
        <div class="method-tab active" onclick="switchMethod('email')">이메일</div>
        <div class="method-tab" onclick="switchMethod('phone')">휴대폰</div>
      </div>

      <form class="find-form" action="${pageContext.request.contextPath}/findPwdEnd.do" method="post">
        <input type="hidden" name="method" id="findMethod" value="email">

        <div class="method-content active" id="email-method">
          <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" name="userId" placeholder="가입한 아이디를 입력하세요" required>
          </div>
          <div class="form-group">
            <label for="userName">이름</label>
            <input type="text" name="userName" placeholder="가입 시 등록한 이름을 입력하세요" required>
          </div>
          <div class="verification-group">
            <div class="form-group">
              <label for="userEmail">이메일</label>
              <input type="email" name="userEmail" placeholder="가입 시 등록한 이메일을 입력하세요" required>
            </div>
            <button type="button" class="verify-btn" onclick="sendVerificationCode('email')">인증번호 발송</button>
          </div>
          <div class="form-group verification-code">
            <label for="emailVerifyCode">인증번호</label>
            <input type="text" name="emailVerifyCode" placeholder="이메일로 받은 인증번호를 입력하세요">
          </div>
        </div>

        <div class="method-content" id="phone-method">
          <div class="form-group">
            <label for="userId2">아이디</label>
            <input type="text" name="userId2" placeholder="가입한 아이디를 입력하세요">
          </div>
          <div class="form-group">
            <label for="userName2">이름</label>
            <input type="text" name="userName2" placeholder="가입 시 등록한 이름을 입력하세요">
          </div>
          <div class="verification-group">
            <div class="form-group">
              <label for="userPhone">휴대폰 번호</label>
              <input type="tel" name="userPhone" placeholder="가입 시 등록한 휴대폰 번호를 입력하세요">
            </div>
            <button type="button" class="verify-btn" onclick="sendVerificationCode('phone')">인증번호 발송</button>
          </div>
          <div class="form-group verification-code">
            <label for="phoneVerifyCode">인증번호</label>
            <input type="text" name="phoneVerifyCode" placeholder="SMS로 받은 인증번호를 입력하세요">
          </div>
        </div>

        <button type="submit" class="find-btn">비밀번호 재설정</button>
      </form>
    </div>

    <div class="back-links">
      <a href="${pageContext.request.contextPath}/user/login.do">로그인</a>
      <a href="${pageContext.request.contextPath}/user/searchIdByEmail.do">아이디 찾기</a>
      <a href="${pageContext.request.contextPath}/user/enrolluser.do">회원가입</a>
    </div>
  </div>
</div>

<script>
  function switchMethod(method) {
    // 탭 활성화 상태 변경
    document.querySelectorAll('.method-tab').forEach(tab => {
      tab.classList.remove('active');
    });
    event.target.classList.add('active');

    // 컨텐츠 표시/숨김
    document.querySelectorAll('.method-content').forEach(content => {
      content.classList.remove('active');
    });
    document.getElementById(method + '-method').classList.add('active');

    // hidden input 값 변경
    document.getElementById('findMethod').value = method;

    // 필수 입력 필드 설정
    const allInputs = document.querySelectorAll('.method-content input');
    allInputs.forEach(input => {
      input.removeAttribute('required');
    });

    const activeInputs = document.querySelectorAll('.method-content.active input');
    activeInputs.forEach(input => {
      if (input.name !== 'emailVerifyCode' && input.name !== 'phoneVerifyCode') {
        input.setAttribute('required', '');
      }
    });
  }

  function sendVerificationCode(type) {
    const button = event.target;
    const originalText = button.textContent;

    // 버튼 비활성화 및 텍스트 변경
    button.disabled = true;
    button.textContent = '발송 중...';
    button.style.background = '#e5e7eb';

    // 실제 구현에서는 여기서 AJAX 요청을 보내야 합니다
    setTimeout(() => {
      button.textContent = '재발송';
      button.disabled = false;
      button.style.background = '#f3f4f6';

      // 성공 메시지 표시 (실제 구현에서는 서버 응답에 따라 처리)
      alert(type === 'email' ? '이메일로 인증번호가 발송되었습니다.' : 'SMS로 인증번호가 발송되었습니다.');
    }, 2000);
  }
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>