<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="로그인페이지"/>
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

    .login-container {
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

    .login-form {
        margin-bottom: 32px;
    }

    .form-group {
        position: relative;
        margin-bottom: 24px;
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

    .login-btn {
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

    .login-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 15px 30px rgba(255, 107, 53, 0.4);
    }

    .login-btn:active {
        transform: translateY(0);
    }

    .login-links {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-bottom: 32px;
        padding-top: 16px;
        border-top: 1px solid #e5e7eb;
    }

    .login-links a {
        color: #6b7280;
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
        transition: color 0.3s ease;
    }

    .login-links a:hover {
        color: #ff6b35;
    }

    .divider {
        position: relative;
        text-align: center;
        margin: 32px 0;
    }

    .divider::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 0;
        right: 0;
        height: 1px;
        background: #e5e7eb;
    }

    .divider span {
        background: rgba(255, 255, 255, 0.95);
        padding: 0 20px;
        color: #9ca3af;
        font-size: 14px;
        font-weight: 500;
    }

    .social-login {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 12px;
    }

    .social-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 12px;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        background: white;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        color: #374151;
        font-weight: 500;
        font-size: 14px;
    }

    .social-btn:hover {
        border-color: #d1d5db;
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .social-btn img {
        width: 20px;
        height: 20px;
        margin-right: 8px;
    }

    .kakao { background: #fee500; border-color: #fee500; color: #000; }
    .google { background: white; }
    .github { background: #181717; color: white; border-color: #181717; }
    .apple { background: #000; color: white; border-color: #000; }

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
        .login-container {
            margin: 20px;
            padding: 32px 24px;
        }

        .social-login {
            grid-template-columns: 1fr;
        }
    }
</style>
<div class="main-content">
    <div class="floating-elements">
        <div class="floating-circle"></div>
        <div class="floating-circle"></div>
        <div class="floating-circle"></div>
    </div>

    <div class="login-container">
        <div class="logo">
            <h1>사이트 이름</h1>
            <p>오프라인으로 만나는 생생한 강의</p>
        </div>

        <form class="login-form" action="${pageContext.request.contextPath}/logincheck.do" method="post">
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" name="userId" placeholder="아이디를 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="userPwd">비밀번호</label>
                <input type="password" name="userPwd" placeholder="비밀번호를 입력하세요" required>
            </div>
            <button type="submit" class="login-btn">로그인</button>
        </form>

        <div class="login-links">
            <a href="#">아이디 찾기</a>
            <a href="#">비밀번호 찾기</a>
            <a href="${pageContext.request.contextPath}/user/enrolluser.do">회원가입</a>
        </div>

        <div class="divider">
            <span>또는</span>
        </div>

        <div class="social-login">
            <a href="#" class="social-btn kakao">
                <img src="${pageContext.request.contextPath}/resources/images/kakao_icon.jpeg" alt="카카오" onerror="this.style.display='none'">
                카카오
            </a>
            <a href="#" class="social-btn google">
                <img src="${pageContext.request.contextPath}/resources/images/google_icon.jpeg" alt="구글" onerror="this.style.display='none'">
                구글
            </a>
            <a href="#" class="social-btn github">
                <img src="${pageContext.request.contextPath}/resources/images/github_icon.jpeg" alt="깃허브" onerror="this.style.display='none'">
                깃허브
            </a>
            <a href="#" class="social-btn apple">
                <img src="${pageContext.request.contextPath}/resources/images/apple_icon.jpeg" alt="애플" onerror="this.style.display='none'">
                애플
            </a>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>