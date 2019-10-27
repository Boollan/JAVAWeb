<%--
  Created by IntelliJ IDEA.
  User: wyzao
  Date: 2019/9/2
  Time: 12:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>错误</title>
</head>
<body>

<div>
    <%
        out.print("消息:" + request.getAttribute("errorMessage"));
        response.setHeader("Refresh", "1;url=/index.jsp");
    %>
</div>

</body>
</html>
