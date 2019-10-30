<%@include file="../internal/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
        xmlhttp.send("username=<%= session.getAttribute("UserName")%>");//POST请求体
        /**
         * 给异步对象的onraedystatechange事件注册监听器
         */
        xmlhttp.onreadystatechange = function () {

            //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {


            }
        }
    }
</script>
<%@include file="../internal/underlying.jsp"%>
