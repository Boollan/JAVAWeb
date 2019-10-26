<%--
  Created by IntelliJ IDEA.
  User: wyzao
  Date: 2019/9/16
  Time: 19:17
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
    <script src="/classic/ckeditor/ckeditor.js"></script>
    <script src="/classic/ckeditor/lang/zh-cn.js"></script>


</head>

<body>

<div class="container">
    <div class="header clearfix">
        <nav>
            <ul class="nav nav-pills pull-right">
                <li role="presentation"><a href="/accout/admin/index.jsp">首页</a></li>
                <li role="presentation"><a href="/accout/admin/module/admin_passowrd.jsp">密码</a></li>
                <li role="presentation"><a href="/accout/admin/module/admin_email.jsp">邮箱</a></li>
                <li role="presentation"><a href="/accout/admin/module/admin_cdk.jsp">CDK</a></li>
                <li role="presentation"><a href="/accout/admin/module/admin_user_login_record.jsp">记录</a>
                <li role="presentation" class="active"><a href="/accout/admin/module/admin_other.jsp">其他</a></li>
                </li>
                <li role="presentation"><a href="/accout/index.jsp">用户</a></li>
                <li role="presentation"><a href="javascript:;" onclick="is_exit()">退出</a></li>
            </ul>
            <form id="formid" name="formid" action="/exit" method="post"></form>
        </nav>
        <%
            Object userName = session.getAttribute("UserName");
            if (userName != null) {
                out.print("<h3 class=\"text-muted\">" + "管理员:" + userName + "</h3>");
            } else {
                response.sendRedirect("/");
            }
        %>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <ul class="nav nav-pills" role="tablist">
                <li role="presentation" class="active"><a href="#">首页内容</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <h3 align="center">首页内容编辑器</h3>

            <div class="col-lg-10 popover-content ">

                <textarea name="editor1" id="editorText" rows="10" cols="80"></textarea>

                <button type="button" id="btn" value="提交"></button>


            </div>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2019 Company, Inc.</p>
    </footer>
</div> <!-- /container -->


<script>
    // Replace the <textarea id="editor1"> with a CKEditor
    // instance, using default configuration.
    CKEDITOR.replace('editorText');


    var btn = document.getElementById("btn");

    btn.onclick = function () {
        CKEDITOR.appendTo('editorText');
        // CKEDITOR.instances.editorText.updateElement();
        var data1 = CKEDITOR.instances.editorText.getData();

        alert(data1);

    }


</script>


<script src="../../../js/ajax.js"></script>
<script type="text/javascript">function is_exit() {
    document.getElementById("formid").submit();
}</script>

<script src="https://code.jquery.com/jquery-3.0.0.min.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="/bootstrap-3.3.7-dist/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
