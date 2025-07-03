<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Font Awesome 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    .approval-container {
        background: transparent;
        min-height: 100vh;
        padding: 2rem 0;
    }

    .approval-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        border: 1px solid rgba(255,255,255,0.2);
        padding: 2.5rem;
        max-width: 800px;
        margin: 0 auto;
    }

    .section-title {
        color: #495057;
        font-weight: 600;
        margin-bottom: 2rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 1.5rem;
    }

    .section-title .text-primary {
        color: #ff6b35 !important;
    }

    .upload-section {
        background: linear-gradient(45deg, #fff5f0, #ffffff);
        border-radius: 15px;
        padding: 2rem;
        border: 2px solid #ffe4d6;
        margin-bottom: 2rem;
        transition: all 0.3s ease;
    }

    .upload-section:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(255, 107, 53, 0.1);
    }

    .form-label {
        font-weight: 600;
        color: #495057;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .file-input-wrapper {
        position: relative;
        display: inline-block;
        overflow: hidden;
        background: linear-gradient(45deg, #ff6b35, #f7931e);
        color: white;
        border-radius: 12px;
        padding: 0.75rem 1.5rem;
        cursor: pointer;
        transition: all 0.3s ease;
        border: none;
        font-weight: 500;
    }

    .file-input-wrapper:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
    }

    .file-input-wrapper input[type=file] {
        position: absolute;
        left: -9999px;
    }

    .file-name-display {
        background: #f8f9fa;
        border: 2px solid #e9ecef;
        border-radius: 12px;
        padding: 0.75rem 1rem;
        margin: 1rem 0;
        font-style: italic;
        color: #6c757d;
    }

    .btn-custom {
        background: linear-gradient(45deg, #ff6b35, #f7931e);
        border: none;
        color: white;
        font-weight: 500;
        padding: 0.75rem 1.5rem;
        border-radius: 12px;
        transition: all 0.3s ease;
        margin: 0 0.5rem;
    }

    .btn-custom:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
        color: white;
    }

    .btn-danger-custom {
        background: linear-gradient(45deg, #dc3545, #c82333);
        border: none;
        color: white;
        font-weight: 500;
        padding: 0.75rem 1.5rem;
        border-radius: 12px;
        transition: all 0.3s ease;
        margin: 0 0.5rem;
    }

    .btn-danger-custom:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
        color: white;
    }

    .status-section {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 15px;
        padding: 2rem;
        border: 2px solid #e9ecef;
        text-align: center;
    }

    .status-title {
        font-weight: 600;
        color: #495057;
        margin-bottom: 1rem;
        font-size: 1.2rem;
    }

    .status-stay {
        background: linear-gradient(45deg, #ffc107, #ffb300);
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 25px;
        font-weight: 600;
        display: inline-block;
        box-shadow: 0 5px 15px rgba(255, 193, 7, 0.3);
    }

    .status-approve {
        background: linear-gradient(45deg, #28a745, #20c997);
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 25px;
        font-weight: 600;
        display: inline-block;
        box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
    }

    .status-deny {
        background: linear-gradient(45deg, #dc3545, #c82333);
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 25px;
        font-weight: 600;
        display: inline-block;
        box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
    }

    .disabled-form {
        pointer-events: none;
        opacity: 0.6;
        filter: grayscale(50%);
    }

    .button-group {
        display: flex;
        align-items: center;
        gap: 1rem;
        margin-top: 1.5rem;
        flex-wrap: wrap;
    }

    .info-box {
        background: linear-gradient(45deg, #e3f2fd, #ffffff);
        border: 2px solid #bbdefb;
        border-radius: 12px;
        padding: 1.5rem;
        margin-bottom: 2rem;
    }

    .info-box .info-title {
        color: #1976d2;
        font-weight: 600;
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .info-box .info-text {
        color: #424242;
        margin: 0;
        line-height: 1.6;
    }
</style>

<div class="navs">
    <div class="nav-item" data-nav="info">개인 정보 수정</div>
    <div class="nav-item active" data-nav="approval">강의 개설 자격 승인</div>
</div>

<div class="approval-container">
    <div class="container">
        <div class="approval-card">
            <h4 class="section-title">
                <i class="fas fa-certificate text-primary"></i>
                강의 개설 자격 승인
            </h4>

            <!-- 안내 정보 -->
            <div class="info-box">
                <div class="info-title">
                    <i class="fas fa-info-circle"></i>
                    승인 절차 안내
                </div>
                <p class="info-text">
                    강의 개설을 위해서는 관련 자격증명서나 경력증명서를 PDF 파일로 제출해주세요.
                    제출된 서류는 관리자 검토 후 승인 여부가 결정됩니다.
                </p>
            </div>

            <!-- 파일 업로드 섹션 -->
            <div class="upload-section <c:if test='${approveStatus != "D" && not empty approveStatus}'>disabled-form</c:if>">
                <form id="approveForm" enctype="multipart/form-data" method="post">
                    <label class="form-label">
                        <i class="fas fa-file-upload"></i>
                        제출 서류 첨부
                    </label>

                    <div class="file-input-wrapper">
                        <i class="fas fa-cloud-upload-alt me-2"></i>
                        PDF 파일 선택
                        <input type="file" id="approveFile" name="approveFile" accept=".pdf" required
                               <c:if test="${approveStatus != 'D' && not empty approveStatus}">disabled</c:if>>
                    </div>

                    <div id="fileNameDisplay" class="file-name-display" style="display: none;">
                        <i class="fas fa-file-pdf me-2"></i>
                        <span id="fileName"></span>
                    </div>

                    <div class="button-group">
                        <button type="button" id="delBtn" class="btn-danger-custom" style="display:none;"
                                <c:if test="${approveStatus != 'D' && not empty approveStatus}">disabled</c:if>>
                            <i class="fas fa-trash me-2"></i>삭제
                        </button>

                        <c:if test="${approveStatus == 'D' || empty approveStatus}">
                            <button type="submit" class="btn-custom">
                                <i class="fas fa-paper-plane me-2"></i>승인 요청
                            </button>
                        </c:if>
                    </div>
                </form>
            </div>

            <!-- 승인 상태 표시 -->
            <c:if test="${not empty approveStatus}">
                <div class="status-section">
                    <div class="status-title">
                        <i class="fas fa-clipboard-check me-2"></i>
                        승인 상태
                    </div>
                    <c:choose>
                        <c:when test="${approveStatus eq 'S'}">
                            <span class="status-stay">
                                <i class="fas fa-clock me-2"></i>검토 대기중
                            </span>
                        </c:when>
                        <c:when test="${approveStatus eq 'A'}">
                            <span class="status-approve">
                                <i class="fas fa-check-circle me-2"></i>승인 완료
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-deny">
                                <i class="fas fa-times-circle me-2"></i>승인 반려
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
    $(".nav-item").on('click', function () {
        let $current = $(this);
        let tabId = $current.data('nav');
        $(".nav-item").removeClass("active");
        $current.addClass("active");
        tabLoad(tabId);
    });

    // 파일 선택 시 파일명 표시
    $("#approveFile").on('change', function() {
        const fileName = this.files[0]?.name;
        if (fileName) {
            $("#fileName").text(fileName);
            $("#fileNameDisplay").show();
            $("#delBtn").show();
        }
    });

    $("#delBtn").on("click", function() {
        $("#approveFile").val('');
        $("#fileNameDisplay").hide();
        $(this).hide();
    });

    $("#approveForm").off('submit').on('submit', async function (e) {
        e.preventDefault();

        const formData = new FormData(this);

        try {
            const response = await fetch('${pageContext.request.contextPath}/mypage/requestapprove', {
                method: 'POST',
                body: formData
            });
            const result = await response.text();
            if (result === "success") {
                alert("승인 요청이 접수되었습니다.");
                tabLoad("approval");
            } else {
                alert("승인 요청에 실패했습니다.");
            }
        } catch (err) {
            alert("오류가 발생했습니다: " + err.message);
        }
    });
</script>
