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
        <div class="panel-heading">修改用户的密码</div>
        <div class="panel-body">

            <div class="col-lg-10 popover-content " style="margin-left: 7%">
                <p style="color: red;">PS;管理员请不要随意修改用户的密码！</p>
                <p>PS:除非用户需要帮助！</p>
                <br id="messbody">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">账号:</span>
                    <input type="text" id="Admin_UserName" class="form-control" placeholder="要修改的用户名"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon2">密码:</span>
                    <input type="password" id="Admin_UserPwd" class="form-control" placeholder="请输入新的密码"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <button type="button" id="admin_passowrd-btn" class="btn btn-default"
                        style="margin-left: 40%; color: #337AB7; width: 125px;height: 50px">确认强制更改
                </button>
            </div>
        </div>
    </div>

<script type="text/javascript">


    var admin_passowrd_btn = document.getElementById("admin_passowrd-btn");
    window.onload = function () {

        admin_passowrd_btn.onclick = function () {

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
            xmlhttp.open("POST", "/Accout/Admin/APWServlet", true);
            /**
             * 设置请求头
             */
            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            var UserName = document.getElementById("Admin_UserName");
            var UserPwd = document.getElementById("Admin_UserPwd");

            xmlhttp.send("admin_username=<%=session.getAttribute("UserName")%>&permissions=<%=session.getAttribute("permissions")%>&username=" + UserName.value + "&userpwd=" + UserPwd.value + "");//POST请求体
            /**
             * 给异步对象的onraedystatechange事件注册监听器
             */
            xmlhttp.onreadystatechange = function () {

                //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    var text = xmlhttp.responseText;

                    var json = eval("(" + text + ")");//将字符串转换为JSON对象

                    if (json.return) {

                        //清空Input值
                        UserName.value = "";
                        UserPwd.value = "";
                        //messbody
                        document.getElementById("messbody").insertAdjacentHTML('afterend', '<div class="alert alert-success" id="messText_email" role="alert" style="visibility: visible">密码更改成功!</div>');
                        show_good();
                    } else {
                        UserName.value = "";
                        UserPwd.value = "";
                        document.getElementById("messbody").insertAdjacentHTML('afterend', '<div class="alert alert-success" id="messText_email" role="alert" style="visibility: visible">密码更改失败!</div>');
                        show_good();

                    }


                    //用于UI界面的显示 bate
                    function show_good() {
                        setTimeout(function () {
                            var idObject = document.getElementById('messText_email');
                            idObject.parentNode.removeChild(idObject);
                        }, 3000);
                    }


                }
            }
        }
    }
</script>

<%@include file="../internal/underlying.jsp"%>
