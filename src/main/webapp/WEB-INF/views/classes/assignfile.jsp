<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="form-assign"    class="insert-form">
  <form action="${pageContext.request.contextPath}/class/assignsubmit" method="post" enctype="multipart/form-data">
    <input type="hidden" name="courseNo" value="${courseNo}" />
    <div class="mb-3">
      <label for="assignScheduleNo" class="form-label">주차 선택</label>
      <select id="assignScheduleNo" name="scheduleWeek" class="form-select" required>
        <option value="">주차를 선택해주세요</option>
        <c:forEach var="w" items="${assignWeek}">
          <option value="${w.scheduleWeek}">${w.scheduleWeek}주차</option>
        </c:forEach>
      </select>
    </div>
    <div class="mb-3">
      <label for="assignFile" class="form-label">파일 업로드</label>
      <input type="file" class="form-control" id="assignFile" name="file" required>
    </div>
    <button type="submit" class="btn btn-success">등록</button>
  </form>
</div>