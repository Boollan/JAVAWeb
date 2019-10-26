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
                <li role="presentation" class="active"><a href="#">密码更改</a></li>
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


    <div class="panel panel-default">
        <div class="panel-heading">密码更改</div>
        <div class="panel-body">
            <div class="alert alert-success" id="errorText_passowrd" role="alert" style="visibility: hidden"></div>
            <div class="col-lg-10 popover-content " style="margin-left: 7%">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">账号:</span>
                    <input type="text" id="Password_username" class="form-control" placeholder="Username"
                           disabled="value" value="<%= session.getAttribute("UserName")%>"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon2">旧密码:</span>
                    <input type="password" id="password-pwd-old" class="form-control" placeholder="请输入旧密码"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon3">新密码:</span>
                    <input type="password" id="password-pwd-new" class="form-control" placeholder="请输入新密码"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon4">确认密码:</span>
                    <input type="password" id="password-confirm" class="form-control" placeholder="请输入确认密码"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <button type="button" id="passowrd-btn" class="btn btn-default"
                        style="margin-left: 40%; color: #337AB7; width: 125px;height: 50px">确认修改密码
                </button>
            </div>
        </div>
    </div>
    <div>

        <footer class="footer">
            <p>&copy; 2019 Company, Inc.</p>
        </footer>

    </div> <!-- /container -->
</div>


<script src="../../js/ajax.js"></script>

<script type="text/javascript">


    window.onload = function () {

        //旧密码
        var password_pwd_old_onblur = document.getElementById("password-pwd-old");
        password_pwd_old_onblur.onblur = function () {
            var elementById2 = document.getElementById("errorText_passowrd");
            elementById2.innerHTML = "";
            elementById2.style.visibility = "hidden";
        }
        //新密码
        var password_pwd_new_onblur = document.getElementById("password-pwd-new");
        password_pwd_new_onblur.onblur = function () {
            var elementById2 = document.getElementById("errorText_passowrd");
            elementById2.innerHTML = "";
            elementById2.style.visibility = "hidden";
        }
        //确认密码
        var password_confirm_onblur = document.getElementById("password-confirm");
        password_confirm_onblur.onblur = function () {
            var elementById2 = document.getElementById("errorText_passowrd");
            elementById2.innerHTML = "";
            elementById2.style.visibility = "hidden";
        }


        var passowrdbtn = document.getElementById("passowrd-btn");
        passowrdbtn.onclick = function () {

            var password_pwd_old = document.getElementById("password-pwd-old");//旧密码
            var password_pwd_new = document.getElementById("password-pwd-new");//新密码
            var password_confirm = document.getElementById("password-confirm");//确认密码

            var elementById = document.getElementById("errorText_passowrd");
            if (password_pwd_old != "" || password_pwd_old != null && password_pwd_new != "" || password_pwd_new != null) {
                //确认两次密码是否一致
                if (password_pwd_new.value == password_confirm.value) {
                    //确认旧密码和新密码不同
                    if (password_pwd_old.value != password_pwd_new.value) {
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
                        xmlhttp.open("POST", "/Accout/AccoutUpdataPassowrd", true);
                        /**
                         * 设置请求头
                         */
                        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");


                        xmlhttp.send("username=<%= session.getAttribute("UserName") %>&passowrd_old=" + password_pwd_old.value.toString() + "&passowrd_new=" + password_pwd_new.value.toString() + "");//POST请求体
                        /**
                         * 给异步对象的onraedystatechange事件注册监听器
                         */
                        xmlhttp.onreadystatechange = function () {

                            //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
                            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                                var responseText = xmlhttp.responseText;
                                var json = eval("(" + responseText + ")");
                                var response = json.response;
                                if (response == true) {
                                    elementById.innerHTML = "修改密码成功";
                                    elementById.style.visibility = "visible";

                                } else {
                                    var elementById1 = document.getElementById("errorText_passowrd");
                                    elementById1.innerHTML = "密码修改失败";
                                    elementById1.style.visibility = "visible";
                                }


                            }
                        }

                    } else {
                        elementById.innerHTML = "新密码和旧密码不允许一致";
                        elementById.style.visibility = "visible";
                    }
                } else {
                    elementById.innerHTML = "新密码和确认密码不一致";
                    elementById.style.visibility = "visible";
                }
            } else {
                elementById.innerHTML = "旧密码不能为空";
                elementById.style.visibility = "visible";
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
