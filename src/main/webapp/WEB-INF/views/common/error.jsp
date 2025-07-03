<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>오류 발생</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- ✅ Bootstrap CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background-color: #f8f9fa;
    }
    .error-container {
      max-width: 600px;
      margin: 100px auto;
      padding: 40px;
      background-color: white;
      border-radius: 16px;
      box-shadow: 0 0 30px rgba(0,0,0,0.1);
      text-align: center;
    }
    .error-code {
      font-size: 72px;
      font-weight: bold;
      color: #dc3545;
    }
    .error-message {
      font-size: 24px;
      margin-top: 20px;
      color: #333;
    }
    .error-hint {
      margin-top: 10px;
      color: #888;
    }
  </style>
</head>
<body>

<%
  Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
  String message = "예기치 못한 오류가 발생했습니다.";

  switch (statusCode) {
    case 400: message = "잘못된 요청입니다."; break;
    case 403: message = "접근 권한이 없습니다."; break;
    case 404: message = "페이지를 찾을 수 없습니다."; break;
    case 405: message = "허용되지 않은 메서드입니다."; break;
    case 500: message = "서버 내부 오류가 발생했습니다."; break;
  }
%>

<div class="error-container">
  <div class="error-code"><%= statusCode %></div>
  <div class="error-message"><%= message %></div>
  <div class="error-hint">요청한 페이지 처리 중 문제가 발생했습니다.</div>
  <a href="${pageContext.request.contextPath}" class="btn btn-outline-primary mt-4">홈으로 이동</a>
</div>

</body>
</html>
