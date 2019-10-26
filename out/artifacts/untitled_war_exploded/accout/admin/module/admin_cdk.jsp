<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
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
                <li role="presentation" class="active"><a href="/accout/admin/module/admin_cdk.jsp">CDK</a></li>
                <li role="presentation"><a href="/accout/admin/module/admin_user_login_record.jsp">记录</a></li>
                <li role="presentation"><a href="/accout/admin/module/admin_other.jsp">其他</a></li>

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
                <li role="presentation" class="active"><a href="#">生成CDK</a></li>
                <li role="presentation"><a href="/accout/admin/module/cdk_module/admin_cdk_select.jsp">查询CDK</a></li>
                <li role="presentation"><a href="/accout/admin/module/cdk_module/admin_cdk_dele.jsp">删除CDK</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="col-lg-10 popover-content " style="margin-left: 7%">
                <h1>没有实装~仅供展示之用</h1>
                <h3>卡密生成</h3>
                <p>每次生成卡密最大数量为10张</p>
                <p>关于过期时间 格式为 yyyy-mm-dd（年-月-日）</p>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">数量:</span>
                    <input type="text" id="cdk_num" class="form-control" placeholder="请输入数量"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon2">金额:</span>
                    <input type="text" id="cdk_moey" class="form-control" placeholder="请输入金额"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <% SimpleDateFormat sdf = new SimpleDateFormat();// 格式化时间
                    sdf.applyPattern("yyyy-MM-dd");// a为am/pm的标记
                    Date date = new Date(); // 获取当前时间  %>

                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon3">过期时间:</span>
                    <input type="date" id="cdk_datetime" class="form-control"
                           min="<% out.print(sdf.format(date));%>" placeholder="请输入过期时间"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <button type="button" id="cdk-btn" class="btn btn-default"
                        style="margin-left: 40%; color: #337AB7; width: 125px;height: 50px">生成卡密
                </button>
                <br>
                <br>
                <h6 style="color: red;">每行一张卡密</h6>
                <textarea class="form-control"  id="cdk_text" style="font-weight: bolder;font-size: 12px;" rows="12" ></textarea>
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
        var cdk_num = document.getElementById("cdk_num");//cdk数量
        var cdk_moey = document.getElementById("cdk_moey");//cdk金额
        var cdk_datetime = document.getElementById("cdk_datetime");//过期时间
        var cdk_btn = document.getElementById("cdk-btn");
        var cdk_text = document.getElementById("cdk_text");


        cdk_btn.onclick = function () {

            var xmlhttp = creatXMLHttpRequest();

            xmlhttp.open("POST", "/Accout/Admin/CDKServlet", false);

            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xmlhttp.send("num="+cdk_num.value+"&moey="+cdk_moey.value+"&datetime="+cdk_datetime.value+"");//POST请求体

            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                var text = xmlhttp.responseText;

                var json = eval("(" + text + ")");//将字符串转换为JSON对象

                var str =' ';

                for (var i=0 in json) {
                    // '&#xd'
                    str+=json[i].cdk+' &#xd ';
                }
                    cdk_text.innerHTML=str;
                alert("卡密成功生成！");

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
