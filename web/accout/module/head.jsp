<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: wyzao
  Date: 2019/8/31
  Time: 8:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/bootstrap-3.3.7-dist/imges/loginico.ico">
    <title>账号管理</title>
    <!-- Bootstrap core CSS -->
    <link href="/bootstrap-3.3.7-dist/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="/bootstrap-3.3.7-dist/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/bootstrap-3.3.7-dist/css/jumbotron-narrow.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]>
    <script src="/bootstrap-3.3.7-dist/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/bootstrap-3.3.7-dist/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="container">
    <div class="header clearfix">
        <nav>
            <ul class="nav nav-pills pull-right">
                <li role="presentation" class="active"><a href="/index.jsp">首页</a></li>
                <li role="presentation"><a href="#">密码更改</a></li>
                <li role="presentation"><a href="#">邮箱更改</a></li>
                <li role="presentation"><a href="#">捐助金额</a></li>
                <li role="presentation"><a href="#">名称更改</a></li>
                <li role="presentation"><a href="javascript:;" onclick="is_exit()">退出</a></li>
            </ul>
            <form id="formid" name="formid" action="/exit" method="post"></form>
        </nav>
        <%
            Cookie[] cookies = request.getCookies();
            String getName = null;
            String getvale = null;
            if (cookies != null) {
                for (int i = 0; i < cookies.length; i++) {
                    Cookie c = cookies[i];
                    if ("UserName".equals(c.getName()) == true) {
                        getName = c.getName();
                        getvale = c.getValue();
                    }
                }

                if ("UserName".equals(getName)) {
                    out.print("<h3 class=\"text-muted\">" + "账号:" + getvale + "</h3>");

                } else {

                    response.sendRedirect("/");
                }
            }
        %>
    </div>

    <%--    <%@ include file="" %>--%>


    <footer class="footer">
        <p>&copy; 2019 Company, Inc.</p>
    </footer>
</div> <!-- /container -->

<script type="text/javascript">function is_exit() {
    document.getElementById("formid").submit();
}</script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="/bootstrap-3.3.7-dist/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
