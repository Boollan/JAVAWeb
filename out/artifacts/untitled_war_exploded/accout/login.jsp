<%--
  Created by IntelliJ IDEA.
  User: wyzao
  Date: 2019/8/31
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Object userName = session.getAttribute("UserName");
    if (userName == null) {

    } else {
        response.sendRedirect("/");
    }
%>

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

    <title>用户登录</title>

    <!-- Bootstrap core CSS -->
    <link href="../bootstrap-3.3.7-dist/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../bootstrap-3.3.7-dist/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./accout/signin.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]>
    <script src="../bootstrap-3.3.7-dist/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../bootstrap-3.3.7-dist/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body style="background-image: url(../bootstrap-3.3.7-dist/imges/bg_bg.jpg)">

<div class="container">

    <div style="margin : 0% 20% 0% 20%;">
        <h2 class="form-signin-heading" align="center">账号登录</h2>
        <label for="inputUsername" class="sr-only">Email address</label>
        <input type="text" id="inputUsername" name="username" class="form-control" placeholder="请输入账号" required
               autofocus>
        <br>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" name="password" class="form-control" placeholder="请输入密码" required>
        <div class="checkbox">
            <label>
                <div>
                    <input type="checkbox" id="keep" name="inputKeep" onclick="is_check()" value="0"> 记住账号(7天免登录)&#8195;
                    <a style="color: #0f0f0f;text-align: right;" href="/accout/Forgotpwd.jsp">
                        &#8195;<nobr>忘记密码？</nobr>
                    </a>
                </div>
            </label>
        </div>
        <div id="demo-popup"></div>
        <button class="btn btn-lg btn-primary btn-block" id="subt" type="button">登录</button>
        <p></p>
        <a href="/accout/reg.jsp">
            <button class="btn btn-lg btn-primary btn-block" type="button">注册界面</button>
        </a>
        <p></p>
        <a href="/">
            <button class="btn btn-lg btn-primary btn-block" type="button">网站首页</button>
        </a>
    </div>


</div> <!-- /container -->

<script src="../js/ajax.js"></script>

<script type="text/javascript">var chek = document.getElementById("keep");
chek.value = "0";

function is_check() {
    var statue = document.getElementById("keep");
    if (statue.checked == true) {
        statue.value = "1";
    } else {
        statue.value = "0";
    }
}

window.onload = function () {

    var inputUsername = document.getElementById("inputUsername");
    var inputEmail = document.getElementById("inputEmail");
    var inputPassword = document.getElementById("inputPassword");
    var statue = document.getElementById("keep");


    var demo_4 = _dx.Captcha(document.getElementById('demo-popup'), {
        appId: 'a693c2483e07d84df8216f513eb1fbb8',
        style: 'popup',
        success: function (token) {

            var xmlhttp = creatXMLHttpRequest();

            xmlhttp.open("POST", "/login_mysql", false);

            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xmlhttp.send("username=" + inputUsername.value + "&password=" + inputPassword.value + "&token=" + token + "&inputKeep=" + statue.value + "");//POST请求体

            //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                var textCode = xmlhttp.responseText;
                var json = eval("(" + textCode + ")");
                if (json.key == true) {
                    window.location.href = "/";
                } else {
                    alert("提示:" + json.message);
                    location.replace("/accout/login.jsp");
                }

            }

        }
    })

    document.getElementById('subt').onclick = function () {
        demo_4.show()
    }

}

</script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../bootstrap-3.3.7-dist/assets/js/ie10-viewport-bug-workaround.js"></script>
<%--无感验证JS--%>
<script src="https://cdn.dingxiang-inc.com/ctu-group/captcha-ui/index.js"></script>
</body>
</html>

