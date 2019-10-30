<%--
  Created by IntelliJ IDEA.
  User: wyzao
  Date: 2019/9/16
  Time: 19:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../internal/head.jsp"%>

    <div class="panel panel-default">
        <div class="panel-heading">
            <ul class="nav nav-pills" role="tablist">
                <li role="presentation"><a href="/accout/admin/module/admin_cdk.jsp">生成CDK</a></li>
                <li role="presentation"><a href="/accout/admin/module/cdk_module/admin_cdk_select.jsp">查询CDK</a></li>
                <li role="presentation" class="active"><a href="#">删除CDK</a></li>
            </ul>
        </div>
        <div class="panel-body">

        </div>
    </div>

<script type="text/javascript">


    window.onload = function () {

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
        xmlhttp.open("POST", "/Accout/AccoutMessage", true);
        /**
         * 设置请求头
         */
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        /**
         * 发送请求
         */
        xmlhttp.send("username=<%=session.getAttribute("UserName") %>");//POST请求体
        /**
         * 给异步对象的onraedystatechange事件注册监听器
         */
        xmlhttp.onreadystatechange = function () {

            //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                var text = xmlhttp.responseText;

                var json = eval("(" + text + ")");//将字符串转换为JSON对象


                if (json.json_permissions > 0 && json.json_permissions < 4) {
                } else {
                    top.location = '/index.jsp';
                }

            }
        }
    }
</script>


<%@include file="../../internal/underlying.jsp"%>