<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<section class="main-content">
    <div class="search-form d-flex justify-content-center">
        <table class="table table-bordered" style="max-width: 1200px;">
            <tr>
                <th>학교급</th>
                <td>
                    <input type="checkbox" id="school" name="school" value="E"> 초등
                    <input type="checkbox" id="school" name="school" value="M"> 중등
                    <input type="checkbox" id="school" name="school" value="H"> 고등
                </td>
                <th>교과목</th>
                <td>
                    <select>
                        <option>교과목 선택</option>
                    </select>
                </td>
                <th>지역</th>
                <td>
                    <select>
                        <option>지역 선택</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>요일</th>
                <td>
                    <input type="checkbox"> 월
                    <input type="checkbox"> 화
                    <input type="checkbox"> 수
                    <input type="checkbox"> 목
                    <input type="checkbox"> 금
                    <input type="checkbox"> 토
                    <input type="checkbox"> 일
                </td>
                <th>검색</th>
                <td colspan="3">
                    <input class="me-3" type="text" placeholder="검색어 입력">
                    <button class="btn btn-outline-orange"> 검색 </button>
                </td>
            </tr>
        </table>
    </div>
</section>
<%@include file="/WEB-INF/views/common/footer.jsp"%>
