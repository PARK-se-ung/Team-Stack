<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <script>
        alert('${msg}');
        location.assign("${pageContext.request.contextPath}${loc}");
    </script>
</body>
</html>
