<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<article>
  <div>
    <h2>문의 내역</h2>
    <hr>
    <div>
      <select id="inquire-status" class="form-select">
        <option value="T" ${status == "T"? "selected" : ""}>전체</option>
        <option value="N" ${status == "N"? "selected" : ""}>미처리</option>
      </select>
    </div>
    <br>
    <table>
      <thead>
        <tr>
          <th>문의 번호</th>
          <th>제목</th>
          <th>유저</th>
          <th>문의일</th>
          <th>처리 상태</th>
        </tr>
      </thead>
      <tbody>
      <c:if var="emptyFlag" test="${not empty inquires}">
        <c:forEach var="inquire" items="${inquires}">
          <tr>
            <td>${inquire.inquireNo}</td>
            <td>
              <a class="text-decoration-none inquire-title" href="#" data-no="${inquire.inquireNo}">
                ${inquire.inquireTitle}
              </a>
            </td>
            <td>${inquire.userId}</td>
            <td>
              <fmt:formatDate value="${inquire.inquireDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
              <c:if var="statusFlag" test="${inquire.inquireStatus.equals('N')}">
                <button class="btn btn-outline-orange" onclick="alarmModal(${inquire.inquireNo})">문의 처리</button>
              </c:if>
              <c:if test="${not statusFlag}">
                처리 완료
              </c:if>
            </td>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${!emptyFlag}">
        <td colspan="5"> 조회된 결과가 없습니다.</td>
      </c:if>
      </tbody>

    </table>
  </div>
  <br>
  <div>
    ${pageBar}
  </div>

  <!-- 모달 -->
  <div class="modal fade" id="alarmModal" tabindex="-1" aria-labelledby="writeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title" id="writeModalLabel">알람 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>

      <div class="modal-body">
        <form id="writeForm">
          <div class="mb-3">
            <label for="alarm-content" class="form-label">알람 내역</label>
            <textarea class="form-control" id="alarm-content" rows="4" required></textarea>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-outline-orange" onclick="insertAlarm('inquire')">전송</button>
        <input type="hidden" id="inquire-no">
      </div>

      </div>
    </div>
  </div>
<script>
  $(document).ready(() => {
            $("#inquire-status").on('change', inquireHandler);
          })
</script>
</article>