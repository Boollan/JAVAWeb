<%--
  Created by IntelliJ IDEA.
  User: wyzao
  Date: 2019/9/16
  Time: 19:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../internal/head.jsp"%>

    <div class="panel panel-default">
        <div class="panel-heading">
            <ul class="nav nav-pills" role="tablist">
                <li role="presentation" class="active"><a href="#">网页登陆记录</a></li>
                <li role="presentation"><a
                        href="/accout/admin/module/record_module/admin_user_login_game.jsp">游戏登录记录</a></li>
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

                    wrap.insertAdjacentHTML('afterend', "<tr><th scope=\"row\">" + (result.length - i) + "</th><td>" + result[i].username + "</td><td>" + result[i].addip + "</td><td>" + result[i].datetime + "</td><td>" + result[i].client + "</td></tr>");

                }
            }


        }

        btn.onclick = function () {
            location.reload();
        }
    }
</script>

<%@include file="../internal/underlying.jsp"%>