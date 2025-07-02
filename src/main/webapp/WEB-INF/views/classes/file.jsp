<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="insert-menu" id="file-tabMenu" style="margin-top: 8vh">
    <div class="insert-select active" data-target="#form-notice">공지사항</div>
    <div class="insert-select"        data-target="#form-assign">과제등록</div>
    <div class="insert-select"        data-target="#form-material">강의자료</div>
    <span class="tab-underline" id="file-underline"></span>
</div>

<div class="dash-content" style="margin-top: 4vh">
    <div id="form-notice"    class="insert-form" style="display:none">
        <form action="${path}/class/noticeInsert" method="post">
            <input type="hidden" name="courseNo" value="${courseNo}" />
            <div class="mb-3">
                <label for="boardTitle" class="form-label">제목</label>
                <input type="text" class="form-control" id="boardTitle" name="boardTitle" required>
            </div>
            <div class="mb-3">
                <label for="boardContent" class="form-label">내용</label>
                <textarea class="form-control" id="boardContent" name="boardContent" rows="5" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">등록</button>
        </form>
    </div>
    <div id="form-assign"    class="insert-form" style="display:none">
        <form action="${path}/class/assignInsert" method="post" enctype="multipart/form-data">
            <input type="hidden" name="courseNo" value="${courseNo}" />
            <div class="mb-3">
                <label for="assignScheduleNo" class="form-label">주차 선택</label>
                <select id="assignScheduleNo" name="scheduleWeek" class="form-select" required>
                    <option value="">주차를 선택해주세요</option>
                    <c:forEach var="i" begin="1" end="${scheduleWeek}">
                        <option value="${i}">${i}주차</option>
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
    <div id="form-material"  class="insert-form" style="display:none">
        <form action="${path}/class/materialInsert" method="post" enctype="multipart/form-data">
            <input type="hidden" name="courseNo" value="${courseNo}" />
            <div class="mb-3">
                <label for="materialScheduleNo" class="form-label">주차 선택</label>
                <select id="materialScheduleNo" name="scheduleWeek" class="form-select" required>
                    <option value="">주차를 선택해주세요</option>
                    <c:forEach var="i" begin="1" end="${scheduleWeek}">
                        <option value="${i}">${i}주차</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label for="materialFile" class="form-label">파일 업로드</label>
                <input type="file" class="form-control" id="materialFile" name="file" required>
            </div>
            <button type="submit" class="btn btn-success">등록</button>
        </form>
    </div>
</div>
<style>
    .insert-menu {
        position: relative;
        display: flex;
        gap: 40px;
        font-size: 20px;
        font-weight: bold;
        cursor: pointer;
    }

    .insert-select {
        position: relative;
        padding-bottom: 6px;
        color: #333;
        transition: color 0.3s;
    }
    .insert-select.active {
        color: #ff944d;
    }

    .tab-underline {
        height: 4px;
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        background-color: #ff944d;
        border-radius: 2px;
        transition: left 0.3s, width 0.3s;
    }
</style>