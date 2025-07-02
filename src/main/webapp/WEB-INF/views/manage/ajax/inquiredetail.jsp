<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
  .inquire-box {
    border: 1px solid #dee2e6;
    border-radius: 1rem;
    padding: 2rem;
    background-color: #f8f9fa;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  }

  .inquire-header h2 {
    font-weight: bold;
    margin-bottom: 1rem;
  }

  .inquire-meta {
    font-size: 0.9rem;
    color: #6c757d;
    margin-bottom: 1rem;
  }

  .inquire-title {
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 0.5rem;
  }

  .inquire-content {
    padding: 1.5rem;
    background-color: #ffffff;
    border-radius: 0.5rem;
    border: 1px solid #e9ecef;
    white-space: pre-wrap;
  }
</style>
<article class="include-container">
  <div class="inquire-box">
    <div class="inquire-header">
      <h2>문의 내역</h2>
      <hr>
    </div>

    <div class="inquire-title">${inquire.inquireTitle}</div>

    <div class="inquire-meta">
      <p>📨 발신인: <strong>${inquire.userId}</strong></p>
      <p>🕒 발신일: <fmt:formatDate value="${inquire.inquireDate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
    </div>

    <div class="inquire-content">
      ${inquire.inquireContent}
    </div>
  </div>

</article>