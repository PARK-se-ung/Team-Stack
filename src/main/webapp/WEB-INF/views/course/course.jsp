<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<section class="main-content">
    <div class="search-form d-flex justify-content-center">
        <table class="table table-bordered" style="max-width: 1200px;">
            <tr>
                <th>학교급</th>
                <td>
                    <input type="checkbox" class="school" name="school" value="E"> 초등
                    <input type="checkbox" class="school" name="school" value="M"> 중등
                    <input type="checkbox" class="school" name="school" value="H"> 고등
                </td>
                <th>교과목</th>
                <td>
                    <select id="category">
                        <option value="전체"> 전체</option>
                        <option value="국어"> 국어 </option>
                        <option value="영어"> 영어 </option>
                        <option value="수학"> 수학 </option>
                        <option value="과학"> 과학 </option>
                        <option value="코딩"> 코딩 </option>
                        <option value="정보"> 정보 </option>
                        <option value="기타"> 기타 </option>
                    </select>
                </td>
                <th>지역</th>
                <td>
                    <select id="region">
                        <option value="전체">전국</option>
                        <option value="서울">서울</option>
                        <option value="부산">부산</option>
                        <option value="대구">대구</option>
                        <option value="인천">인천</option>
                        <option value="광주">광주</option>
                        <option value="대전">대전</option>
                        <option value="울산">울산</option>
                        <option value="세종">세종</option>
                        <option value="경기">경기</option>
                        <option value="강원">강원</option>
                        <option value="충청북도">충북</option>
                        <option value="충청남도">충남</option>
                        <option value="전라북도">전북</option>
                        <option value="전라남도">전남</option>
                        <option value="경상북도">경북</option>
                        <option value="경상남도">경남</option>
                        <option value="제주">제주</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>요일</th>
                <td>
                    <input name="week" value="2" type="checkbox"> 월
                    <input name="week" value="3" type="checkbox"> 화
                    <input name="week" value="4" type="checkbox"> 수
                    <input name="week" value="5" type="checkbox"> 목
                    <input name="week" value="6" type="checkbox"> 금
                    <input name="week" value="7" type="checkbox"> 토
                    <input name="week" value="1" type="checkbox"> 일
                </td>
                <th>검색</th>
                <td colspan="3">
                    <input id="searchData" class="me-3" type="text" placeholder="검색어 입력">
                    <button class="btn btn-outline-orange" onclick="loadCourseList()"> 검색 </button>
                </td>
            </tr>
        </table>
    </div>
    <div class="d-flex justify-content-end align-items-center">
        <button data-form="img" class="form-convertor btn btn-orange me-4">이미지</button>
        <button data-form="list" class="form-convertor btn btn-outline-orange">리스트</button>
    </div>
    <div id="course-container" class="main-content">
        <div class="container">
            <div class="row">
                <c:if var="courseFlag" test="${not empty courses}">
                    <c:forEach var="course" items="${courses}">
                        <div class="col-6 col-md-4 col-lg-2 m-3">
                            <div class="card h-100">
                                <a href="${pageContext.request.contextPath}/home/searchcoursebyno?courseNo=${course.courseNo}">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${course.thumbnail}"
                                         class="card-img-top"
                                         alt="썸네일"
                                         onerror="this.src='${pageContext.request.contextPath}/resources/images/default-thumbnail.png'">
                                    <div class="card-body">
                                            ${course.courseTitle}
                                    </div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${not courseFlag}">
                    <div class="col-12">조회된 결과가 없습니다.</div>
                </c:if>
            </div>

            <div class="d-flex justify-content-center">
                ${pageBar}
            </div>
        </div>
    </div>
</section>

<script>
    $(document).ready(function() {
        const categoryValue = '${category}';

        $("#category option").each(function() {
            if ($(this).val().trim() === categoryValue.trim()) {
                $(this).prop('selected', true);
            }
        });
    });
</script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>
