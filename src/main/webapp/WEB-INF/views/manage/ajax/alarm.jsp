<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<article class="include-container">
  <h2>알람</h2>
  <hr>
  <div class="d-flex justify-content-between mb-3">
    <div class="d-flex flex-row">
      <select class="form-select me-3" id="alarmTarget">
        <option value="T">전체</option>
        <option value="I">강사</option>
        <option value="G">일반</option>
        <option value="custom">직접 입력</option>
      </select>
      <input id="targetId" type="text" class="form-controll d-none me-3" placeholder="유저 id 입력">
      <select id="alarmTime" class="me-3 form-select">
        <option value="0"> 바로 전송</option>
        <option value="custom">직접 입력</option>
      </select>
      <input id="timeId" type="date" class="d-none form-controll">
    </div>
    <div>
      <button onclick="insertAlarm('alarm')" class="btn btn-outline-orange"> 전송 </button>
    </div>
  </div>
  <textarea id="alarm-content" class="form-control" style="width: 100%;min-height: 400px;" placeholder="200자 이하의 알람 메세지 작성"></textarea>
</article>
<script>
/* 알람 대상*/
$("#alarmTarget").on('change', () => {
  if($("#alarmTarget").val() === 'custom'){
    $("#targetId").removeClass('d-none');
  } else {
    $("#targetId").addClass('d-none');
  }
});

/* 알람 시간 */
$("#alarmTime").on('change', () => {
  if($("#alarmTime").val() === 'custom'){
    $("#timeId").removeClass('d-none');
  } else {
    $("#timeId").addClass('d-none');
  }})
</script>