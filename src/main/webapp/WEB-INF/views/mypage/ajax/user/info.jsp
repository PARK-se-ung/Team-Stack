<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- Font Awesome 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* 기존 스타일에 추가 */
    .alert {
        padding: 0.75rem 1rem;
        margin-bottom: 1rem;
        border: 1px solid transparent;
        border-radius: 0.375rem;
    }

    .alert-info {
        color: #0c5460;
        background-color: #d1ecf1;
        border-color: #bee5eb;
    }

    .alert-success {
        color: #0f5132;
        background-color: #d1e7dd;
        border-color: #badbcc;
    }

    .alert-warning {
        color: #664d03;
        background-color: #fff3cd;
        border-color: #ffecb5;
    }

    #saveButtonStatus {
        min-height: 20px;
    }
    .profile-container {
        background: transparent;
        min-height: 100vh;
        padding: 2rem 0;
    }

    .profile-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        border: 1px solid rgba(255,255,255,0.2);
    }

    .form-floating {
        position: relative;
        margin-bottom: 1.5rem;
    }

    .form-floating .form-control {
        border: 2px solid #e9ecef;
        border-radius: 12px;
        transition: all 0.3s ease;
        padding: 1rem 0.75rem 0.25rem;
    }

    .form-floating .form-control:focus {
        border-color: #ff6b35;
        box-shadow: 0 0 0 0.2rem rgba(255, 107, 53, 0.25);
        transform: translateY(-2px);
    }

    .input-group-custom {
        position: relative;
        display: flex;
        align-items: stretch;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .btn-custom {
        background: linear-gradient(45deg, #ff6b35, #f7931e);
        border: none;
        color: white;
        font-weight: 500;
        transition: all 0.3s ease;
        border-radius: 10px;
    }

    .btn-custom:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
        color: white;
    }

    .btn-outline-custom {
        border: 2px solid #ff6b35;
        color: #ff6b35;
        background: transparent;
        font-weight: 500;
        transition: all 0.3s ease;
        border-radius: 10px;
    }

    .btn-outline-custom:hover {
        background: #ff6b35;
        color: white;
        transform: translateY(-2px);
    }

    .readonly-field {
        background: linear-gradient(45deg, #f8f9fa, #e9ecef) !important;
        border: 2px dashed #dee2e6 !important;
    }

    .section-title {
        color: #495057;
        font-weight: 600;
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .section-title .text-primary {
        color: #ff6b35 !important;
    }

    .section-title .text-info {
        color: #f7931e !important;
    }

    .section-title .text-warning {
        color: #ff8c42 !important;
    }

    .password-section {
        background: linear-gradient(45deg, #fff5f0, #ffffff);
        border-radius: 15px;
        padding: 1.5rem;
        border: 2px solid #ffe4d6;
        margin: 2rem 0;
    }

    .save-btn {
        background: linear-gradient(45deg, #ff6b35, #f7931e);
        border: none;
        color: white;
        font-weight: 600;
        padding: 1rem 2rem;
        border-radius: 50px;
        font-size: 1.1rem;
        transition: all 0.3s ease;
        box-shadow: 0 5px 15px rgba(255, 107, 53, 0.3);
    }

    .save-btn:hover:not(:disabled) {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(255, 107, 53, 0.4);
        color: white;
    }

    .save-btn:disabled {
        background: #6c757d;
        cursor: not-allowed;
        box-shadow: none;
    }

    .modal-content {
        border-radius: 20px;
        border: none;
        box-shadow: 0 20px 40px rgba(0,0,0,0.2);
    }

    .modal-header {
        background: linear-gradient(45deg, #ff6b35, #f7931e);
        color: white;
        border-radius: 20px 20px 0 0;
        border: none;
    }

    .verification-success {
        background: linear-gradient(45deg, #ff6b35, #f7931e);
        color: white;
        padding: 0.5rem 1rem;
        border-radius: 10px;
        font-size: 0.9rem;
        margin-top: 0.5rem;
    }
</style>

<div class="navs">
    <div class="nav-item active" data-nav="info">개인 정보 수정</div>
    <div class="nav-item" data-nav="approval">강의 개설 자격 승인</div>
</div>

<div class="profile-container">
    <div class="container">
        <div class="profile-card p-4">
            <!-- 🔴 추가: 알림 메시지 영역 -->
            <div id="emailAuthNotice" class="alert alert-warning" style="display: none;">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <strong>이메일 인증 필요:</strong> 개인정보를 수정하려면 먼저 이메일 인증을 완료해주세요.
            </div>

            <form:form method="post" modelAttribute="loginUser" id="userUpdateForm" action="${pageContext.request.contextPath}/user/userUpdate">

                <h4 class="section-title">
                    <i class="fas fa-id-card text-primary"></i>
                    기본 정보
                </h4>

                <!-- 아이디 (수정 불가) -->
                <div class="form-floating">
                    <form:input path="userId" id="userId" readonly="true" cssClass="form-control readonly-field"/>
                    <label for="userId"><i class="fas fa-user me-2"></i>아이디</label>
                </div>

                <!-- 이름 -->
                <div class="form-floating">
                    <form:input path="name" id="name" required="required" cssClass="form-control"/>
                    <label for="name"><i class="fas fa-signature me-2"></i>이름</label>
                </div>

                <h4 class="section-title mt-4">
                    <i class="fas fa-envelope text-info"></i>
                    연락처 정보
                </h4>

                <!-- 이메일 (읽기 전용으로 표시) -->
                <div class="form-floating">
                    <form:input path="userEmail" type="email" id="userEmail" readonly="true" cssClass="form-control readonly-field"/>
                    <label for="userEmail"><i class="fas fa-at me-2"></i>이메일</label>
                </div>

                <!-- 🔴 수정: 이메일 인증 상태 표시 -->
                <div id="emailAuthStatus" class="mb-3">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        개인정보 수정을 위해 이메일 인증이 필요합니다.
                    </div>
                </div>

                <!-- 이메일 변경 버튼 -->
                <button type="button" class="btn btn-outline-custom mb-3" id="changeEmailBtn">
                    <i class="fas fa-edit me-2"></i>이메일 변경
                </button>

                <!-- 🔴 추가: 이메일 인증만 하기 버튼 -->
                <button type="button" class="btn btn-custom mb-3" id="authOnlyBtn">
                    <i class="fas fa-shield-check me-2"></i>이메일 인증하기
                </button>

                <!-- 이메일 인증 섹션 -->
                <div id="emailAuthSection" style="display: none;">
                    <div class="form-floating">
                        <input type="email" id="newUserEmail" placeholder="새 이메일 주소" class="form-control"/>
                        <label for="newUserEmail"><i class="fas fa-at me-2"></i>인증번호 전송 이메일</label>
                    </div>
                    <button type="button" class="btn btn-outline-custom mb-3" id="sendMailCheckNumber">
                        <i class="fas fa-paper-plane me-2"></i>인증번호 전송
                    </button>

                    <div class="form-floating" id="emailCodeSection" style="display: none;">
                        <input type="text" id="emailCode" placeholder="인증번호 입력" class="form-control"/>
                        <label for="emailCode"><i class="fas fa-key me-2"></i>인증번호</label>
                    </div>
                    <button type="button" class="btn btn-outline-custom mb-3" id="verifyAuthCode" style="display: none;">
                        <i class="fas fa-check-circle me-2"></i>인증 확인
                    </button>

                    <button type="button" class="btn btn-secondary mb-3" id="cancelEmailChange">
                        <i class="fas fa-times me-2"></i>취소
                    </button>
                </div>

                <!-- 전화번호 -->
                <div class="form-floating">
                    <form:input path="userPhone" id="userPhone" placeholder="010-0000-0000" required="required" cssClass="form-control"/>
                    <label for="userPhone"><i class="fas fa-phone me-2"></i>전화번호</label>
                </div>

                <!-- 거주지 -->
                <div class="form-floating">
                    <form:input path="userAddress" id="userAddress" placeholder="거주지 입력" cssClass="form-control"/>
                    <label for="userAddress"><i class="fas fa-map-marker-alt me-2"></i>거주지</label>
                </div>

                <!-- 저장 버튼 -->
                <div class="text-center mt-4">
                    <button type="submit" class="save-btn" id="saveInfo" disabled>
                        <i class="fas fa-save me-2"></i>변경사항 저장
                    </button>
                    <!-- 🔴 추가: 저장 버튼 상태 설명 -->
                    <div id="saveButtonStatus" class="mt-2 text-muted">
                        <small><i class="fas fa-lock me-1"></i>이메일 인증 후 저장 가능</small>
                    </div>
                </div>
            </form:form>

            <!-- 비밀번호 변경 섹션 -->
            <div class="password-section">
                <h5 class="section-title">
                    <i class="fas fa-lock text-warning"></i>
                    보안 설정
                </h5>
                <p class="text-muted mb-3">비밀번호 변경은 이메일 인증이 필요합니다.</p>
                <button type="button" class="btn btn-custom" id="openPwdModal">
                    <i class="fas fa-key me-2"></i>비밀번호 변경
                </button>
            </div>


        </div>
    </div>
</div>

<!-- 비밀번호 변경 모달 -->
<div class="modal fade" id="pwdModal" tabindex="-1" aria-labelledby="pwdModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form id="changePwdForm">
                <div class="modal-header">
                    <h5 class="modal-title" id="pwdModalLabel">
                        <i class="fas fa-shield-alt me-2"></i>비밀번호 변경
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control readonly-field" id="modalUserEmail" readonly>
                        <label for="modalUserEmail"><i class="fas fa-envelope me-2"></i>이메일</label>
                    </div>
                    <button type="button" class="btn btn-outline-custom mb-3" id="sendPwdMailCode">
                        <i class="fas fa-paper-plane me-2"></i>인증번호 전송
                    </button>

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="modalEmailCode" placeholder="인증번호">
                        <label for="modalEmailCode"><i class="fas fa-key me-2"></i>인증번호</label>
                    </div>
                    <button type="button" class="btn btn-outline-custom mb-3" id="verifyPwdMailCode">
                        <i class="fas fa-check-circle me-2"></i>인증 확인
                    </button>

                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="newPwd" placeholder="새 비밀번호" disabled>
                        <label for="newPwd"><i class="fas fa-lock me-2"></i>새 비밀번호</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="confirmPwd" placeholder="비밀번호 확인" disabled>
                        <label for="confirmPwd"><i class="fas fa-lock me-2"></i>비밀번호 확인</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-custom" id="submitPwdChange" disabled>
                        <i class="fas fa-save me-2"></i>변경
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        let emailAuthenticated = false; // 이메일 인증 상태
        let isEmailChangeMode = false;  // 이메일 변경 모드인지 확인
        let originalEmail = $('#userEmail').val(); // 원본 이메일 저장

        function passwordPattern(pwd) {
            const regex = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}\[\]:;"'<>,.?/~`\\|-]).{8,}$/;
            return regex.test(pwd);
        }

        function checkPasswordMatch() {
            const newPwd = $('#newPwd').val();
            const confirmPwd = $('#confirmPwd').val();

            if (confirmPwd.length === 0) {
                return false;
            }

            return newPwd === confirmPwd;
        }


        // 저장 버튼 상태 업데이트 함수
        function updateSaveButtonStatus() {
            const saveBtn = $('#saveInfo');
            const statusDiv = $('#saveButtonStatus');

            if (emailAuthenticated) {
                saveBtn.prop('disabled', false);
                statusDiv.html('<small class="text-success"><i class="fas fa-check-circle me-1"></i>저장 가능</small>');
            } else {
                saveBtn.prop('disabled', true);
                statusDiv.html('<small class="text-muted"><i class="fas fa-lock me-1"></i>이메일 인증 후 저장 가능</small>');
            }
        }

        //이메일 인증 상태 표시 업데이트
        function updateEmailAuthStatus() {
            const statusDiv = $('#emailAuthStatus');

            if (emailAuthenticated) {
                statusDiv.html(`
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>
                    이메일 인증이 완료되었습니다. 개인정보를 수정할 수 있습니다.
                </div>
            `);
            } else {
                statusDiv.html(`
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>
                    개인정보 수정을 위해 이메일 인증이 필요합니다.
                </div>
            `);
            }
        }

        // 이메일 인증만 하기 버튼
        $('#authOnlyBtn').click(function() {
            isEmailChangeMode = false;
            $('#emailAuthSection').show();
            $('#changeEmailBtn').hide();
            $('#authOnlyBtn').hide();
            $('#newUserEmail').val($('#userEmail').val()).prop('readonly', true);
        });

        // 이메일 변경 버튼 클릭
        $('#changeEmailBtn').click(function() {
            isEmailChangeMode = true;
            $('#emailAuthSection').show();
            $('#changeEmailBtn').hide();
            $('#authOnlyBtn').hide();
            $('#newUserEmail').val($('#userEmail').val()).prop('readonly', false);
        });

        //이메일 변경 취소 - 인증 상태 유지
        $('#cancelEmailChange').click(function() {
            $('#emailAuthSection').hide();
            $('#emailCodeSection').hide();
            $('#verifyAuthCode').hide();
            $('#newUserEmail').val('').prop('readonly', false);
            $('#emailCode').val('');

            //인증 상태에 따라 버튼 표시
            if (emailAuthenticated) {
                $('#changeEmailBtn').show();
                $('#authOnlyBtn').hide();
            } else {
                $('#changeEmailBtn').show();
                $('#authOnlyBtn').show();
            }

            isEmailChangeMode = false;

            //이메일을 원본으로 복원 (변경 모드였을 경우)
            if ($('#userEmail').val() !== originalEmail) {
                $('#userEmail').val(originalEmail);
                $('#userEmail').prop('readonly', true).addClass('readonly-field');
            }

            //인증 상태는 유지 (취소해도 이전 인증은 유효)
            updateSaveButtonStatus();
        });

        // 인증번호 전송
        $('#sendMailCheckNumber').click(function(){
            const email = $("#newUserEmail").val();

            if (!email || email.trim() === '') {
                alert('이메일 주소를 입력해주세요.');
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/sendEmail',
                type: 'post',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({email: email}),
                success: function(response) {
                    if(response.sendmailresult){
                        alert('인증번호가 ' + email + '로 발송되었습니다.');
                        $('#emailCodeSection').show();
                        $('#verifyAuthCode').show();
                    } else {
                        alert('이메일 전송에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error){
                    alert('서버오류발생: ' + error);
                }
            });
        });

        //이메일 인증 확인
        $('#verifyAuthCode').click(function(){
            const inputCode = $('#emailCode').val();

            if (!inputCode || inputCode.trim() === '') {
                alert('인증번호를 입력해주세요.');
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/verifyAuthCode',
                type: 'post',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({inputCode: inputCode}),
                success: function(response){
                    if (response.checkAuthCode) {
                        //인증 성공 처리
                        emailAuthenticated = true;

                        if (isEmailChangeMode) {
                            // 이메일 변경 모드인 경우
                            $('#userEmail').val($('#newUserEmail').val());
                            $('#userEmail').prop('readonly', false);
                            alert("✅ 이메일이 변경되고 인증이 완료되었습니다.");
                        } else {
                            // 인증만 하는 경우
                            alert("✅ 이메일 인증이 완료되었습니다.");
                        }

                        // UI 업데이트
                        $('#emailAuthSection').hide();
                        $('#changeEmailBtn').show();
                        $('#authOnlyBtn').hide();

                        updateSaveButtonStatus();
                        updateEmailAuthStatus();

                    } else {
                        alert("❌ 인증번호가 일치하지 않습니다.");
                    }
                },
                error: function(xhr, status, error){
                    alert('인증 확인 중 오류가 발생했습니다: ' + error);
                }
            });
        });

        //저장 버튼 클릭 시 인증 확인
        $('#saveInfo').click(function(e) {
            if (!emailAuthenticated) {
                e.preventDefault();
                alert('개인정보 수정을 위해 먼저 이메일 인증을 완료해주세요.');
                $('#emailAuthNotice').show().delay(5000).fadeOut();
                return false;
            }
        });

        // 폼 제출 시 처리
        $('#userUpdateForm').submit(function(e) {
            if (!emailAuthenticated) {
                e.preventDefault();
                alert('이메일 인증을 완료해주세요.');
                return false;
            }

            // 이메일 readonly 해제
            $('#userEmail').prop('readonly', false);
        });

        // 전화번호 자동 하이픈
        $('#userPhone').on('input', function() {
            let number = this.value.replace(/\D/g, '');
            if (number.length < 4) {
                this.value = number;
            } else if (number.length < 8) {
                this.value = number.replace(/(\d{3})(\d{1,4})/, '$1-$2');
            } else {
                this.value = number.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
            }
        });
// 비밀번호 변경 모달 열기
        $('#openPwdModal').click(function(){
            // 현재 사용자의 이메일을 모달 이메일 필드에 자동 입력
            $('#modalUserEmail').val($('#userEmail').val());

            var modal = new bootstrap.Modal(document.getElementById('pwdModal'));
            modal.show();
        });

        // 비밀번호 변경 모달 내 인증번호 전송
        $('#sendPwdMailCode').click(function(){
            const email = $('#modalUserEmail').val();
            console.log('비밀번호 변경용 이메일:', email);

            $.ajax({
                url: '${pageContext.request.contextPath}/sendEmail',
                type: 'post',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({email: email}),
                success: function(response){
                    if(response.sendmailresult){
                        alert('인증번호가 발송되었습니다.');
                    } else {
                        alert('이메일 전송 실패');
                    }
                },
                error: function(){
                    alert('서버 오류 발생');
                }
            });
        });

        // 비밀번호 변경  내모달 인증번호 확인
        $('#verifyPwdMailCode').click(function(){
            const code = $('#modalEmailCode').val();

            if (!code || code.trim() === '') {
                alert('인증번호를 입력해주세요.');
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/verifyAuthCode',
                type: 'post',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({inputCode: code}),
                success: function(response){
                    if(response.checkAuthCode){
                        alert('✅ 이메일 인증이 완료되었습니다.');
                        // 비밀번호 입력 필드 활성화
                        $('#newPwd, #confirmPwd, #submitPwdChange').prop('disabled', false);
                        // 인증 관련 필드 비활성화
                        $('#modalUserEmail, #modalEmailCode, #sendPwdMailCode, #verifyPwdMailCode').prop('disabled', true);
                    } else {
                        alert('❌ 인증번호가 일치하지 않습니다.');
                    }
                },
                error: function(){
                    alert('인증 확인 중 오류가 발생했습니다.');
                }
            });
        });
        // 비밀번호 변경 폼 제출
        $('#changePwdForm').submit(function(e){
            e.preventDefault();
            const newPwd = $('#newPwd').val();
            const confirmPwd = $('#confirmPwd').val();

            if (!passwordPattern(newPwd)) {
                alert('비밀번호는 특수문자, 대문자, 숫자를 포함한 8자 이상이어야 합니다.');
                return;
            }

            if(newPwd !== confirmPwd){
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }

        // 비밀번호 변경 요청
            $.ajax({
                url: '${pageContext.request.contextPath}/user/updatePassword',
                type: 'post',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    newPassword: newPwd
                }),
                success: function(response){
                    if(response.success){
                        alert('비밀번호가 변경되었습니다.');
                        var modal = bootstrap.Modal.getInstance(document.getElementById('pwdModal'));
                        modal.hide();
                        if(response.logout) {
                            window.location.href = '${pageContext.request.contextPath}/';
                        }
                    } else {
                        alert(response.message || '비밀번호 변경에 실패했습니다.');
                    }
                }
            });
        });

        $('#pwdModal').on('hidden.bs.modal', function() {
            pwdEmailVerified = false;
            $('#changePwdForm')[0].reset();
            $('#newPwd, #confirmPwd, #submitPwdChange').prop('disabled', true);
            $('#modalUserEmail, #modalEmailCode, #sendPwdMailCode, #verifyPwdMailCode').prop('disabled', false);
            $('#newPwd, #confirmPwd').removeClass('is-valid is-invalid');
        });

    });
    <!-- nav 전환 로직 -->
    $(".nav-item").on('click', function(e) {
        let $current = $(this);
        let tabId = $current.data('nav');
        $(".nav-item").removeClass("active");
        $current.addClass("active");
        tabLoad(tabId);
        e.stopPropagation();
    });
</script>
