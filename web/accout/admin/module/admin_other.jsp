<%--
  Created by IntelliJ IDEA.
  User: wyzao
  Date: 2019/9/16
  Time: 19:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../internal/head.jsp" %>
<div class="panel panel-default">
    <div class="panel-heading">
        <ul class="nav nav-pills" role="tablist">
            <li role="presentation" class="active"><a href="#">首页内容</a></li>
        </ul>
    </div>
    <div class="panel-body">
        <h3 align="center">首页内容编辑器</h3>

        <div class="col-lg-12 popover-content ">
            <input type="text" id="titletext" class="form-control" placeholder="请输入标题">
            <textarea name="editor1" id="editorText" rows="10" cols="80"></textarea>
            <button type="button" id="submu" class="btn btn-success">提交</button>

        </div>
    </div>
</div>

<script>
    var myEditor = null;
    ClassicEditor
        .create(document.querySelector('#editorText'), {
            language: {
                // The UI will be in English.
                ui: 'zh-cn',
            }
        })
        .then(editor => {
            myEditor = editor;
        })
        .catch(error => {
            console.error(error);
        });
</script>

<script>

    //写入内容到数据库
    var title = document.getElementById("titletext");//标题
    var hometext = myEditor.getData();//内容;
    var submu = document.getElementById("submu");
    submu.onclick = function () {
        alert(myEditor.getData());


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
        xmlhttp.open("POST", "/Accout/Admin/SetHomeShow", false);
        /**
         * 设置请求头
         */
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        /**
         * 发送请求
         */
        xmlhttp.send("titletext=" + title.value + "&hometxt=" + myEditor.getData() + "");//POST请求体
        /**
         * 给异步对象的onraedystatechange事件注册监听器
         */

        //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

            var text = xmlhttp.responseText;

            var json = eval("(" + text + ")");//将字符串转换为JSON对象
            if (json.key == true) {
                alert("修改成功")
            } else {
                alert("修改失败");
            }
        }
    }

    //用于加载数据库数据
    window.onload = function () {

        var title = document.getElementById("titletext");//标题
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
        xmlhttp.open("GET", "/HomeShowText", false);
        /**
         * 设置请求头
         */
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        /**
         * 发送请求
         */
        xmlhttp.send(null);//POST请求体
        /**
         * 给异步对象的onraedystatechange事件注册监听器
         */

        //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

            var text = xmlhttp.responseText;
            var json = eval("(" + text + ")");//将字符串转换为JSON对象
            title.value = json.homeTite;
            myEditor.setData(json.HomeText);
        }
    }
</script>
<%@include file="../internal/underlying.jsp" %>
