<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
  .include-container {
    max-width: 900px;
    margin: 3rem auto;
    padding: 2rem;
    background-color: #f9fafb;
    border-radius: 1rem;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    font-family: 'Segoe UI', sans-serif;
  }

  .notice-box {
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 1rem;
    padding: 2rem;
  }

  .notice-header h2 {
    margin-bottom: 0.5rem;
    font-size: 1.75rem;
    font-weight: bold;
    color: #343a40;
  }

  .notice-title {
    font-size: 1.4rem;
    font-weight: 600;
    color: #212529;
    margin-top: 1.2rem;
    margin-bottom: 1rem;
    border-left: 4px solid #0d6efd;
    padding-left: 1rem;
  }

  .notice-meta {
    font-size: 0.9rem;
    color: #6c757d;
    margin-bottom: 1.5rem;
  }

  .notice-content {
    font-size: 1.05rem;
    line-height: 1.7;
    color: #333;
    padding: 1rem 1.5rem;
    background-color: #f8f9fa;
    border-radius: 0.5rem;
    white-space: pre-wrap; /* 줄바꿈 유지 */
    border: 1px solid #e9ecef;
  }
</style>
<article class="include-container">
  <div class="notice-box">
    <div class="notice-header">
      <h2>공지 내역</h2>
      <hr>
    </div>

    <div class="notice-title">${notice.noticeTitle}</div>

    <div class="notice-meta">
      <p>🕒 공지일: <fmt:formatDate value="${notice.noticeDate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
    </div>

    <div class="notice-content">
      ${notice.noticeContent}
    </div>
  </div>

</article>