<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<div id="file-upload">
    <label for="file-input">PDF 파일 선택:</label>
    <input type="file" id="file-input" accept="application/pdf">
</div>
<div id="pdf-controls">
    ${강의명} 강의계획서
</div>
<canvas id="pdf-render" style="border:1px solid #ccc; width:100%;"></canvas>
<script>
    console.log(coursePlan())
</script>
