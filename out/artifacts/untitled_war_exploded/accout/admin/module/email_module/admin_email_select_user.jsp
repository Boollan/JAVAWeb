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
    <!--[if lt IE 9]><script src="/bootstrap-3.3.7-dist/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
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
                <li role="presentation"><a href="/accout/admin/index.jsp">首页</a></li>
                <li role="presentation"><a href="/accout/admin/module/admin_passowrd.jsp">密码</a></li>
                <li role="presentation" class="active"><a href="/accout/admin/module/admin_email.jsp">邮箱</a></li>
                <li role="presentation"><a href="/accout/admin/module/admin_cdk.jsp">CDK</a></li>
                <li role="presentation"><a href="/accout/admin/module/admin_user_login_record.jsp">记录</a></li>
                <li role="presentation"><a href="/accout/admin/module/admin_other.jsp">其他</a></li>

                <li role="presentation"><a href="/accout/index.jsp">用户</a></li>
                <li role="presentation"><a href="javascript:;" onclick="is_exit()">退出</a></li></ul>
            <form id="formid" name="formid" action="/exit" method="post"></form>
        </nav>
        <%
            Object userName = session.getAttribute("UserName");
            if(userName!=null){
                out.print("<h3 class=\"text-muted\">"+"管理员:"+userName+"</h3>");
            }else {
                response.sendRedirect("/");
            }
        %>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <ul class="nav nav-pills" role="tablist">
                <li role="presentation"><a href="/accout/admin/module/admin_email.jsp">修改功能</a></li>
                <li role="presentation"><a href="/accout/admin/module/email_module/admin_email_select.jsp">邮箱查询</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="panel-body">

                <p style="color: red;">此功能已关闭！</p>

                <div class="col-lg-10 popover-content " style="margin-left: 7%">

                    <br>
                    <div class="input-group"  >
                        <span class="input-group-addon" id="basic-addon1">账号:</span>
                        <input type="text" id="email_accout" class="form-control" placeholder="要查找的用户名"   aria-describedby="basic-addon1" >
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon2">邮箱:</span>
                        <input type="password" id="email-mail" class="form-control" placeholder="..." aria-describedby="basic-addon1" >
                    </div>
                    <br>
                    <button type="button" id="email-btn" class="btn btn-default" style="margin-left: 40%; color: #337AB7; width: 125px;height: 50px">确认强制更改</button>
                </div>
            </div>
        </div>
    </div>



    <footer class="footer">
        <p>&copy; 2019 Company, Inc.</p>
    </footer>
</div> <!-- /container -->
    <script src="../../../../js/ajax.js"></script>
<script type="text/javascript">



    window.onload = function () {

        var email_btn = document.getElementById("");

        email_btn.onclick=function () {

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
            xmlhttp.open("POST","/Accout/Admin/EmailData",true);
            /**
             * 设置请求头
             */
            xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            /**
             * 发送请求
             */
            xmlhttp.send("username=<%=session.getAttribute("UserName") %>");//POST请求体
            /**
             * 给异步对象的onraedystatechange事件注册监听器
             */
            xmlhttp.onreadystatechange = function () {

                //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200 ){

                    var text = xmlhttp.responseText;

                    var json = eval("("+text+")");//将字符串转换为JSON对象



                    if (json.json_permissions > 0 && json.json_permissions <4){}else{top.location='/index.jsp';}

                }
            }
        }


    }
</script>


<script type="text/javascript">function is_exit(){document.getElementById("formid").submit(); }</script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="/bootstrap-3.3.7-dist/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
