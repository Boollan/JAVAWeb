<%@include file="../internal/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <div class="panel panel-default">
        <div class="panel-heading">邮箱更改</div>
        <div class="panel-body">
            <div class="col-lg-10 popover-content " style="margin-left: 7%">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">账号:</span>

                    <input type="text" id="email_username" class="form-control" placeholder="数据加载中" disabled="value"
                           value="<%= session.getAttribute("UserName")%>" aria-describedby="basic-addon1">
                </div>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon2">原邮箱:</span>
                    <input type="email" id="email-mail-old" class="form-control" value="" disabled="value"
                           placeholder="数据加载中" aria-describedby="basic-addon1">
                </div>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon3">验证码:</span>
                    <div>
                        <input type="text" id="email-mail-code" style="width: 25%" class="form-control"
                               placeholder="请输入验证码" aria-describedby="basic-addon1">
                        <button type="button" id="ema-code" class="btn btn-default"
                                style="margin-left: 4%; color: #337AB7; width: 100px;height: 35px">获取验证码
                        </button>
                    </div>
                </div>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon4">新邮箱:</span>
                    <input type="email" id="email-mail-new" class="form-control" placeholder="请输入新邮箱"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <button type="button" id="email-btn" class="btn btn-default"
                        style="margin-left: 40%; color: #337AB7; width: 125px;height: 50px">确认修改邮箱
                </button>
                <br>
                <br>
                <div class="alert alert-success" id="errorText_email_true" role="alert" style="visibility: hidden">
                    邮箱修改成功！
                </div>
                <div class="alert alert-success" id="errorText_email" role="alert" style="visibility: hidden">
                    验证码已发送至您的邮箱 请注意查收
                </div>
            </div>
        </div>
    </div>
    <div>

        <script type="text/javascript">

            //加载数据
            window.onload = function () {
                GetEmail();
            }

            function GetEmail() {
                var xmlhttp = creatXMLHttpRequest();

                xmlhttp.open("POST", "/Accout/AccoutMessage", true);

                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                xmlhttp.send("username=<%= session.getAttribute("UserName")  %> ");//POST请求体

                xmlhttp.onreadystatechange = function () {

                    //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                        var text = xmlhttp.responseText;

                        var json = eval("(" + text + ")");//将字符串转换为JSON对象

                        var email_mail_old = document.getElementById("email-mail-old");
                        email_mail_old.value = json.json_email;

                    }
                }
            }

            var ema_code = document.getElementById("ema-code");
            //获取验证码
            ema_code.onclick = function () {

                var xmlhttp = creatXMLHttpRequest();

                xmlhttp.open("POST", "/SendEmail", true);

                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                var email_mail_old = document.getElementById("email-mail-old");
                xmlhttp.send("email=" + email_mail_old.value.toString().trim() + "");//POST请求体

                xmlhttp.onreadystatechange = function () {

                    //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                        var text = xmlhttp.responseText;

                        var json = eval("(" + text + ")");//将字符串转换为JSON对象
                        var errorText_email = document.getElementById("errorText_email");
                        if (json.return == true) {
                            errorText_email.style.visibility = "visible";
                        } else {
                            errorText_email.style.visibility = "hidden";
                        }

                    }
                }

            }


            var email_username = document.getElementById("email_username"); //用户名称
            var email_mail_old = document.getElementById("email-mail-old"); //原邮箱
            var email_mail_code = document.getElementById("email-mail-code"); //邮箱验证码
            var email_mail_new = document.getElementById("email-mail-new"); //新邮箱
            var email_btn = document.getElementById("email-btn"); //提交按钮

            email_mail_code.onblur = function () {
                var elementById2 = document.getElementById("errorText_email");
                elementById2.style.visibility = "hidden";
            }
            email_btn.onclick = function () {
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
                xmlhttp.open("POST", "/EmailCode", true);
                /**
                 * 设置请求头
                 */
                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                xmlhttp.send("username=" + email_username.value.trim() + "&maillod=" + email_mail_old.value.trim() + "&mailnew=" + email_mail_new.value.trim() + "&code=" + email_mail_code.value.trim() + "");//POST请求体
                /**
                 * 给异步对象的onraedystatechange事件注册监听器
                 */
                xmlhttp.onreadystatechange = function () {

                    //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                        var text = xmlhttp.responseText;

                        var json = eval("(" + text + ")");//将字符串转换为JSON对象
                        var errorText_email = document.getElementById("errorText_email_true");
                        if (json.return == true) {
                            email_mail_code.value = "";
                            email_mail_new.value = "";
                            errorText_email.style.visibility = "visible";
                            GetEmail();
                        } else {
                            email_mail_code.value = "";
                            email_mail_new.value = "";
                            alert("提示:邮箱修改失败！");
                            location.replace("/accout/module/Change_email.jsp");
                        }


                    }
                }
            }




        </script>



 <%@include file="../internal/underlying.jsp"%>
