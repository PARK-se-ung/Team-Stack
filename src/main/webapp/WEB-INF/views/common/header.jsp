<%@ page import="org.ts.teamstack.user.model.dto.Users" %>
<%@ page import="static org.ts.teamstack.user.model.dto.UserType.G" %>
<%@ page import="static org.ts.teamstack.user.model.dto.UserType.I" %>
<%@ page import="static org.ts.teamstack.user.model.dto.UserType.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    Users loginUser = (Users)session.getAttribute("loginUser");
%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>teamstack</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <link rel="stylesheet" href="${path}/resources/css/common.css">
    <link rel="stylesheet" href="${path}/resources/css/header.css">
    <link rel="stylesheet" href="${path}/resources/css/footer.css">
    <link rel="stylesheet" href="${path}/resources/css/page.css">
    <script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<!-- header -->
<header class="header">
    <div class="row flex-row justify-content-between">
        <!-- logo -->
        <div class="ms-3 col-lg-3 logo-container">
            <a href="${path}" class="brand">
                <i class="bi bi-person-circle fs-4"></i>
                <span class="h4 mb-0">Team Stack</span>
            </a>
        </div>
        <!-- search -->
        <div class="col-lg-6 search">
            <i class="bi bi-search search-icon"></i>
            <input type="text" class="form-control" id="search" placeholder="Team Stack">
        </div>
        <!-- nav -->
        <div class="col-lg-2 top-nav">
            <div class="align-items-center">
                <% if(loginUser==null) { %>
                <a class="me-3" href="${pageContext.request.contextPath}/user/login.do">
                    로그인
                </a>
                <% } else { %>
                    <p><strong><%= loginUser.getName() %></strong> 님 환영합니다!</p>
                <% if((loginUser.getUserType().equals(G) || loginUser.getUserType().equals(I))){ %>
                    <a class="me-3" href="${pageContext.request.contextPath}/mypage">마이페이지</a>
                <% } else { %>
                    <a class="me-3" href="${pageContext.request.contextPath}/manage">관리자페이지</a>
                <% } %>
                    <a class="me-3" href="${pageContext.request.contextPath}/logout.do">로그아웃</a>
                    <button id="alarmMessages" class="btn btn-orange" type="button">
                        알람
                    </button>
                    <!-- Alarm List -->
                    <div id="alarmDropdown" style="display: none; position: absolute; z-index: 1000; background: white; border: 1px solid #ccc; width: 200px;">
                        <ul id="alarmList" style="list-style: none; padding: 0; margin: 0;">
                            <li style="padding: 10px;">알림 1</li>
                        </ul>
                    </div>
                    <!-- Alarm Modal -->
                    <div class="modal fade" id="alarmModal" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">알림 내용</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body" id="alarmModalBody">

                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</header>
<script>
    /* 알람 */
    $(document).ready(function() {
        $('#alarmMessages').on('click', function(e) {
            e.stopPropagation();
            loadAlarms();
            $('#alarmDropdown').slideToggle(200);
        });

        $(document).on('click', function() {
            $('#alarmDropdown').slideUp(200);
        });

        $('#alarmDropdown').on('click', function(e) {
            e.stopPropagation();
        });
    });

    let toRemoveAlarmId = null;
    function alarmOpener(){

        const alarmId = $(this).data('id');
        const content = $(this).data('content');

        $('#alarmModalBody').text(content);
        $('#alarmModal').modal('show');

        toRemoveAlarmId = alarmId;
    }

    $('#alarmModal').on('hidden.bs.modal', function () {
        if (toRemoveAlarmId !== null) {
            $.ajax({
                url:'${pageContext.request.contextPath}/home/updateAlarm',
                method: "POST",
                data: {"no":toRemoveAlarmId},
                success: function(data) {

                    loadAlarms();
                }
            });
            toRemoveAlarmId = null;
        }
    });

    /* 헤더 알람 로드 */
    function loadAlarms() {
        $.ajax({
            url: '${pageContext.request.contextPath}/home/alarmslist',
            method: 'GET',
            success: function(data) {
                const $list = $('#alarmList');
                $list.empty();
                if(data.length > 0){
                    data.forEach(function(alarm) {
                        let li = $("<li>").addClass("alarm-item").attr({
                            'data-id':alarm.alarmNo,
                            'data-content':alarm.alarmContent
                        }).append($("<div>").addClass("alarm-content").text(alarm.alarmContent))

                        li.click(alarmOpener);

                        $list.append(li);
                    });
                } else {
                    let li = $("<li>").text("조회된 알람이 없습니다.").addClass("text-center");
                    $list.append(li);
                }
            }
        })
    }

    /* 헤더 검색창 */
    $(document).on('keyup', '#search', function(event) {
        if (event.key === 'Enter') {
            const keyword = $(this).val().trim();
            if (keyword.length > 0) {
                location.href = "${pageContext.request.contextPath}/?keyword=" + encodeURIComponent(keyword);
            }
        }
    });
</script>