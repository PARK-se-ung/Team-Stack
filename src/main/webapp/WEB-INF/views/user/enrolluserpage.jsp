<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="회원가입페이지"/>
</jsp:include>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
        #main{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: antiquewhite;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .signup-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .signup-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .signup-header h1 {
            color: #ff6b35;
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .signup-header p {
            color: #666;
            font-size: 1rem;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .form-group input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-group input:focus {
            outline: none;
            border-color: #ff6b35;
            box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1);
            transform: translateY(-2px);
        }

        .form-group input::placeholder {
            color: #999;
        }

        .btn-signup {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #ff6b35, #f7931e);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
        }

        .btn-signup:hover {
            background: linear-gradient(135deg, #e55a2b, #e8841a);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
        }

        .btn-signup:active {
            transform: translateY(0);
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .success-message {
            display: none;
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            margin-top: 20px;
            font-weight: 600;
        }

        @media (max-width: 480px) {
            .signup-container {
                padding: 30px 20px;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .signup-header h1 {
                font-size: 1.8rem;
            }
        }

        /* 입력 필드 애니메이션 */
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-group {
            animation: slideIn 0.6s ease forwards;
        }
        .form-row {
            display: flex;
            gap: 10px;
        }

        .form-row input {
            flex: 1;
        }

        .btn-auth {
            padding: 12px 18px;
            background: linear-gradient(135deg, #ff6b35, #f7931e);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .btn-auth:hover {
            background: linear-gradient(135deg, #e55a2b, #e8841a);
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(255, 107, 53, 0.25);
        }

        .btn-auth:active {
            transform: translateY(0);
        }

        .email-auth-group {
            margin-bottom: 20px;
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }
        .form-group:nth-child(5) { animation-delay: 0.5s; }
    </style>
</head>
<section id="main">
<div class="signup-container">
    <div class="signup-header">
        <h1>회원가입</h1>
        <p>새로운 계정을 만들어보세요</p>
    </div>

    <form id="signupForm" method="post" action="${pageContext.request.contextPath}/user/enrolluserend.do">
        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" id="userId" name="userId" minlength="6" placeholder="6글자이상 사용할 아이디를 입력해주세요" required>
        </div>

        <div class="form-group">
            <label for="userPwd">비밀번호</label>
            <input type="password" id="userPwd" name="userPwd" placeholder="특수문자,대문자,숫자를 포함해주세요" required>
        </div>

        <div class="form-group">
            <label for="passwordcheck">비밀번호 확인</label>
            <input type="password" id="passwordcheck" name="password" placeholder="비밀번호를 확인합니다." required><br>
            <span id="msg">비밀번호가 일치하지 않습니다.</span>
        </div>

        <div class="form-group">
            <label for="userName">이름</label>
            <input type="text" id="userName" name="userName" placeholder="안전한 비밀번호를 입력하세요" required>
        </div>


        <div class="form-group email-auth-group">
            <label for="userEmail">이메일</label>
            <div class="form-row">
                <input type="email" id="userEmail" name="userEmail" placeholder="example@email.com" required>
                <button type="button" class="btn-auth" id="sendMailCheckNumber">인증번호 전송</button>
            </div>
        </div>

        <div class="form-group email-auth-group">
            <label for="emailCode">인증번호 입력</label>
            <div class="form-row" id="mail check input box false">
                <input type="text" id="emailCode" placeholder="이메일로 받은 인증번호 입력" required>
                <button type="button" class="btn-auth" id="verifyAuthCode">인증 확인</button>
            </div>
        </div>

        <div class="form-group">
            <label for="userAddress">거주지</label>
            <input type="text" id="userAddress" name="userAddress" placeholder="거주지를 입력하세요" required>
        </div>

        <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="tel" id="phone" name="phone" placeholder="010-1234-5678" required>
        </div>

        <button type="submit" class="btn-signup">가입하기</button>
    </form>

    <div class="success-message" id="successMessage">
        🎉 회원가입이 완료되었습니다!
    </div>
</div>

</section>
<script>
    // 요소 참조
    const userIdInput = document.getElementById('userId');
    const userPwdInput = document.getElementById('userPwd');
    const passwordCheckInput = document.getElementById('passwordcheck');
    const emailInput = document.getElementById('userEmail');
    const msg = document.getElementById('msg');



    // 아이디 길이 검증 (포커스를 벗어나면 나타나는 blur)
    userIdInput.addEventListener('blur', () => {
        if (userIdInput.value.length < 6) {
            alert("아이디는 6자 이상이어야 합니다.");
        }
    });

    // 비밀번호 복잡도 정규식
    function passwordPattern(pwd) {
        const regex = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}\[\]:;"'<>,.?/~`\\|-]).{8,}$/;
        // 정규식 패턴을 넣어줌
        return regex.test(pwd);
        // 정규식. test를 하게 되면 매개변수로 들어온 값이 패턴에 맞는 지 확인
    }

    userPwdInput.addEventListener('blur', () => {
        if (!passwordPattern(userPwdInput.value)) {
            alert("비밀번호는 특수문자, 대문자, 숫자를 포함한 8자 이상이어야 합니다.");
        }
    });

    // 비밀번호 일치 확인
    passwordCheckInput.addEventListener('input', () => {
        if (passwordCheckInput.value === userPwdInput.value) {
            msg.textContent = "✅ 비밀번호가 일치합니다.";
            msg.style.color = "green";
        } else {
            msg.textContent = "❌ 비밀번호가 일치하지 않습니다.";
            msg.style.color = "red";
        }
    });


    // 이메일 인증 전송 버튼 클릭 시
   $('#sendMailCheckNumber').click(function(){
       const email = $("#userEmail").val();
       console.log('이메일 : ' + email);
       $.ajax({
           url : '${pageContext.request.contextPath}/sendEmail',
           type:'post',
           contentType : 'application/json; charset=utf-8',
           data : JSON.stringify({email:email}),
           success: function(response) {
               if(response.sendmailresult){
                   alert('인증번호 발송되었습니다.');
               } else {
                   alert('이메일 전송에 실패했습니다.');
               }
           },
           error: function(){
               alert('서버오류발생');
       }
       });
   })

    // 인증번호 확인
    $('#verifyAuthCode').click(function(){
        const inputCode = document.getElementById('emailCode').value;
        console.log(inputCode);
        $.ajax({
            url: '${pageContext.request.contextPath}/verifyAuthCode',
            type : 'post',
            contentType : 'application/json; charset=utf-8',
            data : JSON.stringify({inputCode:inputCode}),
            success: function (response){
                if (response.checkAuthCode) {
                    alert("✅ 이메일 인증 완료");
                } else {
                    alert("❌ 인증번호가 일치하지 않습니다.");
                }
            }
        }
        )
    })

</script>


