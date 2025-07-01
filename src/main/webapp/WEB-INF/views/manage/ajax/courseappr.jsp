<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.ts.teamstack.course.common.CourseParser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2> 강의 승인</h2>
<hr>
<div id="approve-container">
    <table>
        <thead>
        <tr>
            <th>번호</th>
            <th>강의정보</th>
            <th>신청일</th>
            <th>신청자</th>
            <th>승인</th>
            <th>반려</th>
        </tr>
        </thead>
        <tbody>
        <c:if var="approveFlag" test="${empty courses}">
            <td colspan="6" class="text-center"> 조회된 결과가 없습니다.</td>
        </c:if>
        <c:if test="${!approveFlag}">
            <c:forEach var="course" items="${courses}">
                <tr>
                    <td>${course.courseNo}</td>
                    <td>[${course.gradeType == "H"?"고등": course.gradeType == "M"?"중등":"초등"}/
                        ${course.subject}/${course.courseTitle}]
                            <a href="${pageContext.request.contextPath}/manage/download?oriname=${course.originalPlanName}&rename=${course.renamePlanName}">
                                ${course.originalPlanName}
                            </a>
                    </td>
                    <td>
                        ${course.courseStartDate} ~ ${CourseParser.getEndDate(course.courseStartDate, course.totalWeek)} (${course.totalWeek}주)
                    </td>
                    <td>
                        ${course.userId}
                    </td>
                    <td>
                        <button class="btn btn-outline-orange courseAppr" data-no="${course.courseNo}" data-status="APPROVE">승인</button>
                    </td>
                    <td>
                        <button class="btn btn-outline-orange courseAppr" data-no="${course.courseNo}" data-status="DENY">반려</button>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
</div>
<br>
<div class="pageBar-container">
    ${pageBar}
</div>


