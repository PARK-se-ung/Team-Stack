<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: qkrtp
  Date: 2025-06-25
  Time: 오후 5:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<article>
  <div>
    <h2>문의 내역</h2>
    <hr>
    <div>
      <select id="status" class="form-select">
        <option value="T">전체</option>
        <option value="N">미처리</option>
      </select>
    </div>
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
      <if var="emptyFlag" test="${not empty inquires}">
        <c:forEach var="inquire" items="${inquires}">
          <tr>
            <td>${inquire.inquireNo}</td>
            <td>${inquire.inquireTitle}</td>
            <td>${inquire.userId}</td>
            <td>${inquire.inquireDate}</td>
            <td>
              <c:if var="statusFlag" test="${inquire.inquireStatus.equals('N')}">
                <button class="btn btn-outline-orange" onclick="">문의 처리</button>
              </c:if>
              <c:if test="${not statusFlag}">
                처리 완료
              </c:if>
            </td>
          </tr>
        </c:forEach>
      </if>
      <if test="${not emptyFlag}">
        <td colspan="5"> 조회된 결과가 없습니다.</td>
      </if>
      </tbody>

    </table>
  </div>
  <div>
    ${pageBar}
  </div>
</article>