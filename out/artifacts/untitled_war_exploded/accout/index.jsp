<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="internal/head.jsp" %>
<div class="panel panel-default" onload="">
        <div class="panel-heading"><h5>账号信息</h5></div>
        <div class="panel-body text-center">
            <div class="col-lg-11 ">
                <ul class=" col-lg-pull-5">
                    <li class="list-group-item" style="text-align:center;background-color: #337AB7; color: white;">用户名
                    </li>
                    <li class="list-group-item" id="accout_username" style="font-size: 18px">...</li>
                    <li class="list-group-item" style="text-align:center;background-color: #337AB7; color: white;">邮箱
                    </li>
                    <li class="list-group-item" id="accout_email" style="font-size: 18px">...</li>
                    <li class="list-group-item" style="text-align:center;background-color: #337AB7; color: white;">
                        捐助金额
                    </li>
                    <li class="list-group-item" id="accout_money" style="font-size: 18px">...</li>
                </ul>
            </div>

        </div>
    </div>
<script type="text/javascript">


    window.onload = function () {

        var xmlhttp = creatXMLHttpRequest();

        xmlhttp.open("POST", "/Accout/AccoutMessage", true);

        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xmlhttp.send("username=<%=session.getAttribute("UserName") %>");//POST请求体

        xmlhttp.onreadystatechange = function () {

            //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                var text = xmlhttp.responseText;

                var json = eval("(" + text + ")");//将字符串转换为JSON对象

                var accout_username = document.getElementById("accout_username");
                accout_username.innerHTML = json.json_username;

                var accout_email = document.getElementById("accout_email");
                accout_email.innerHTML = json.json_email;

                var accout_money = document.getElementById("accout_money");
                accout_money.innerHTML = json.json_donations + " RMB";


            }
        }
    }
</script>
    <%@ include file="internal/underlying.jsp" %>

