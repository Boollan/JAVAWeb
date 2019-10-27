<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: wyzao
  Date: 2019/8/31
  Time: 8:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-cn">
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
                <li role="presentation"><a href="/accout/index.jsp">首页</a></li>
                <li role="presentation"><a href="/accout/module/Change_password.jsp">密码更改</a></li>
                <li role="presentation"><a href="/accout/module/Change_email.jsp">邮箱更改</a></li>
                <li role="presentation"><a href="/accout/module/Change_money.jsp">捐助</a></li>
                <li role="presentation"><a href="/accout/admin/index.jsp">后台</a></li>
                <li role="presentation"><a href="javascript:;" onclick="is_exit()">退出</a></li>
            </ul>
            <form id="formid" name="formid" action="/exit" method="post"></form>
        </nav>
        <%
            Object userName = session.getAttribute("UserName");
            if (userName != null) {
                out.print("<h3 class=\"text-muted\">" + "账号:" + userName + "</h3>");
            } else {
                response.sendRedirect("/");
            }
        %>
    </div>


    <footer class="footer">
        <p>&copy; 2019 Company, Inc.</p>
    </footer>
</div> <!-- /container -->
<script src="../../js/ajax.js"></script>
<script type="text/javascript">


    window.onload = function () {
        /**
         * Ajax四步操作，得到服务器响应
         * 把响应信息显示到元素中
         */
        /**
         * 1.得到异步对象
         */
        var xmlhttp = creatXMLHttpRequest();
        /**
         * 打开服务器连接
         * 指定请求方式
         * 指定请求URL
         * 指定是否为异步请求
         */
        xmlhttp.open("POST", "/Accout/AccoutMessage", true);
        /**
         * 设置请求头
         */
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        /**
         * 发送请求
         */
        xmlhttp.send("username=<%= session.getAttribute("UserName")%>");//POST请求体
        /**
         * 给异步对象的onraedystatechange事件注册监听器
         */
        xmlhttp.onreadystatechange = function () {

            //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {


            }
        }
    }
</script>


<script type="text/javascript">function is_exit() {
    document.getElementById("formid").submit();
}</script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="/bootstrap-3.3.7-dist/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
