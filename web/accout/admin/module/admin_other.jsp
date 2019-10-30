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
                <li role="presentation" class="active"><a href="#">首页内容</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <h3 align="center">首页内容编辑器</h3>

            <div class="col-lg-10 popover-content ">

                <textarea name="editor1" id="editorText" rows="10" cols="80"></textarea>

                <button type="button" id="btn" value="提交"></button>


            </div>
        </div>
    </div>

    <script>
        // Replace the <textarea id="editor1"> with a CKEditor
        // instance, using default configuration.
        CKEDITOR.replace('editorText');


        var btn = document.getElementById("btn");

        btn.onclick = function () {
            CKEDITOR.appendTo('editorText');
            // CKEDITOR.instances.editorText.updateElement();
            var data1 = CKEDITOR.instances.editorText.getData();

            alert(data1);

        }


    </script>

<%@include file="../internal/underlying.jsp"%>
