<%@include file="../internal/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


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


<%@include file="../internal/underlying.jsp"%>