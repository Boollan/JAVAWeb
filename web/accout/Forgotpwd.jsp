<%--
  Created by IntelliJ IDEA.
  User: wyzao
  Date: 2019/9/1
  Time: 11:19
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

    <title>忘记密码</title>

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
        <h2 class="form-signin-heading" align="center" style="color: white;">重置密码</h2>
        <br>
        <label for="inputEmail" class="sr-only">邮箱:</label>
        <input type="email" id="inputEmail" name="email" class="form-control" placeholder="请输入邮箱" required autofocus>
        <br>
        <div>
            <div>
                <label for="inputViavb" class="sr-only">验证码:</label>
                <input style="width: 49%;float:left;" type="password" id="inputViavb" name="password"
                       class="form-control" placeholder="请输入验证码" required>
            </div>
            <div>
                <button style="width: 49%;float:right;height: 36px;font-size: 14px"
                        class="btn btn-lg btn-primary btn-block" id="newViavb" type="button">发送验证码
                </button>
            </div>
        </div>
        <br>
        <br>
        <br>
        <label for="inputNewPwd" class="sr-only">密码:</label>
        <input type="password" id="inputNewPwd" name="password" class="form-control" placeholder="请输入新的密码" required>
        <div id="demo-popup"></div>
        <p></p>
        <button class="btn btn-lg btn-primary btn-block" id="resetpwd" type="button">重置密码</button>
        <p></p>
        <a href="/accout/login.jsp">
            <button class="btn btn-lg btn-primary btn-block" type="button">登录界面</button>
        </a>
    </div>


</div> <!-- /container -->

<script src="../js/ajax.js"></script>

<script type="text/javascript">

    window.onload = function () {

        /**
         * 内容接收
         */
        var inputEmail = document.getElementById("inputEmail");
        var inputViavb = document.getElementById("inputViavb");
        var inputNewPwd = document.getElementById("inputNewPwd");
        /**
         * 按键接收
         */
        var newViavb = document.getElementById("newViavb");
        var resetpwd = document.getElementById("resetpwd");


        /**
         * 机器人过滤
         */
        var demo_4 = _dx.Captcha(document.getElementById('demo-popup'), {
            appId: 'a693c2483e07d84df8216f513eb1fbb8',
            style: 'popup',
            success: function (token) {
                var xmlhttp = creatXMLHttpRequest();
                xmlhttp.open("POST", "/ResePwd", false);
                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp.send("newpwd=" + inputNewPwd.value + "&mail=" + inputEmail.value + "&token=" + token + "&verify="+inputViavb.value);//POST请求体

                //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    var textCode = xmlhttp.responseText;

                    var json = eval("(" + textCode + ")");
                    if (json.key == true) {
                        window.location.href = "/";
                    } else {
                        alert("提示:" + json.message);
                        location.replace("/accout/Forgotpwd.jsp");
                    }

                }

            }
        })

        //提交数据
        document.getElementById('resetpwd').onclick = function () {
            demo_4.show()
        }

        /**
         *获取验证码
         */
        newViavb.onclick=function () {

            var xmlhttp = creatXMLHttpRequest();

            xmlhttp.open("POST", "/SendEmail", true);

            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp.send("email=" + inputEmail.value.toString().trim() + "");//POST请求体

            xmlhttp.onreadystatechange = function () {

                //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    var text = xmlhttp.responseText;

                    var json = eval("(" + text + ")");//将字符串转换为JSON对象
                    if (json.return == true) {
                       alert("提示:发送成功！请注意查收！");
                    } else {
                        alert("提示:发送失败！请仔细检查！");
                    }

                }
            }

        }




    }


</script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../bootstrap-3.3.7-dist/assets/js/ie10-viewport-bug-workaround.js"></script>
<%--无感验证JS--%>
<script src="https://cdn.dingxiang-inc.com/ctu-group/captcha-ui/index.js"></script>
</body>
</html>

