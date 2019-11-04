<%@include file="../internal/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <div class="panel panel-default">
        <div class="panel-heading">捐助兑换</div>
        <div class="panel-body">
            <%--            <p style="color: #6f5499">PS: 请输入捐助后发放的CDK! 感谢您的捐助！ 由于无法自行开发全自动发放系统，只能以手动发放CDK！</p>--%>
            <%--            <p style="color: #2e6da4">PS: 如果您的捐助金额大于3RMB(拜托啦！支持一下嘛！)就可以拥有(泛滥原Ⅱ汉化完整版)！</p>--%>
            <%--            <p style="color: red;">注意: 请不要将账号租借给他人，否则会被封禁.</p>--%>
            <br>
            <div class="col-lg-10 popover-content " style="margin-left: 7%">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">账号:</span>

                    <input type="text" class="form-control" placeholder="数据加载中" disabled="value"
                           value="<%= session.getAttribute("UserName")%>" aria-describedby="basic-addon1">
                </div>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon2">CDK:</span>
                    <input type="email" id="money_key" class="form-control" value="" placeholder="请输入CDK"
                           aria-describedby="basic-addon1">
                </div>
                <br>

                <button type="button" id="money_btn" class="btn btn-default"
                        style="margin-left: 40%; color: #337AB7; width: 125px;height: 50px">兑换
                </button>
            </div>
        </div>
    </div>

<script type="text/javascript">

    window.onload = function () {

        var key = document.getElementById("money_key");
        var bton = document.getElementById("money_btn");

        bton.onclick = function () {

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
            xmlhttp.open("POST", "/Accout/CdkSend", false);
            /**
             * 设置请求头
             */
            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            /**
             * 发送请求
             */
            xmlhttp.send("username=<%= session.getAttribute("UserName")%>&key=" + key.value + "");//POST请求体

            //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var responseText = xmlhttp.responseText;
                var json = eval("(" + responseText + ")");
                var returnHttp = json.return;
                if (returnHttp == true) {
                    alert("兑换成功!");
                } else {
                    alert("兑换失败");
                }

            }

        }


    }


</script>


<%@include file="../internal/underlying.jsp"%>