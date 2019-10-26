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
                <li role="presentation" class="active"><a href="/accout/admin/module/admin_user_login_record.jsp">记录</a>
                <li role="presentation"><a href="/accout/admin/module/admin_other.jsp">其他</a></li>

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
                <li role="presentation" class="active"><a href="#">网页登陆记录</a></li>
                <li role="presentation"><a href="/accout/admin/module/record_module/admin_user_login_game.jsp">游戏登录记录</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <h3 align="center">网页登录记录查询</h3>
            <div class="col-lg-10 popover-content " style="margin-left: 7%">


                <div class="input-group" style="width: 80%;">
                    <span class="input-group-addon" id="sizing-addon12">用户名:</span>
                    <input type="text" class="form-control" id="record_username" placeholder="请输入用户名"
                           aria-describedby="sizing-addon12">
                </div>
                <br>
                <div class="input-group" style="width: 80%;">
                    <span class="input-group-addon" id="sizing-addon13">最早时间:</span>
                    <input type="date" id="record_starttime" class="form-control" placeholder="Username"
                           aria-describedby="sizing-addon13">
                </div>
                <br>
                <div class="input-group" style="width: 80%;">
                    <span class="input-group-addon" id="sizing-addon14">最晚时间:</span>
                    <input type="date" class="form-control" id="end_starttime" placeholder="Username"
                           aria-describedby="sizing-addon14">
                </div>
                <br>
                <button style="width: 20%" type="button" class="btn btn-primary" data-toggle="button"
                        aria-pressed="false" id="record_btn" autocomplete="off">检索
                </button>

                <button style="width: 30%" type="button" class="btn btn-primary" data-toggle="button"
                        aria-pressed="false" id="btn" autocomplete="off">刷新(解决异常)
                </button>
                <br>
                <br>


                <!-- Table -->
                <table class="table" id="table_list">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>用户名</th>
                        <th>IP地址</th>
                        <th>登录时间</th>
                        <th>平台</th>
                    </tr>
                    </thead>

                    <tbody class="append" id="wrap">
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <footer class="footer">
        <p>&copy; 2019 Company, Inc.</p>
    </footer>
</div> <!-- /container -->

    <script src="../../../js/ajax.js"></script>

<script type="text/javascript">
    window.onload = function () {

        var record_btn = document.getElementById("record_btn");//搜索按钮
        var record_username = document.getElementById("record_username");//用户名
        var record_starttime = document.getElementById("record_starttime");//最早时间
        var end_starttime = document.getElementById("end_starttime");//最晚时间

        var btn = document.getElementById("btn");
        record_btn.onclick = function () {

            if (record_starttime.value == "" || record_starttime.value == null) {
                record_starttime.value = null;
            }
            if (end_starttime.value == "" | end_starttime.value == null) {
                end_starttime.value = null;
            }

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
            xmlhttp.open("POST", "/Accout/Admin/Record", false);
            /**
             * 设置请求头
             */
            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            /**
             * 发送请求
             */
            xmlhttp.send("Record_UserName=" + record_username.value.trim() + "&Record_StartTime=" + record_starttime.value + "&Record_EndTime=" + end_starttime.value + "&Record_platform=Web");//POST请求体


            //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                var text = xmlhttp.responseText;
                var result = eval("(" + text + ")");

                var wrap = document.getElementById("wrap");//获取表

                for (var i in result) {

                    wrap.insertAdjacentHTML('afterend', "<tr><th scope=\"row\">"+(result.length-i)+"</th><td>"+result[i].username+"</td><td>"+result[i].addip+"</td><td>"+result[i].datetime+"</td><td>"+result[i].client+"</td></tr>");

                }
            }


        }

        btn.onclick = function () {
            location.reload();
        }
    }
</script>


<script type="text/javascript">function is_exit() {
    document.getElementById("formid").submit();
}</script>

<script src="https://code.jquery.com/jquery-3.0.0.min.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="/bootstrap-3.3.7-dist/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
