<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
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
                <li role="presentation" class="active"><a href="#">查询CDK</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="col-lg-10 popover-content " style="margin-left: 7%">
                <h3>卡密查询</h3>
                <p>输入卡密即可</p>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">CDK:</span>
                    <input type="text" id="cdk_content" class="form-control" placeholder="请输入CDK"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <button type="button" id="cdk_btn" class="btn btn-default"
                        style="margin-left: 40%; color: #337AB7; width: 125px;height: 50px">查询
                </button>
                <br>
                <br>
                <h6 style="color: red;"></h6>
                <ul class=" col-lg-pull-5 text-center">
                    <li class="list-group-item" style="text-align:center;background-color: #337AB7; color: white;">CDK</li>
                    <li class="list-group-item" id="cdk_key_show" style="font-size: 18px"></li>
                    <li class="list-group-item" style="text-align:center;background-color: #337AB7; color: white;font-size: 10px;">金额</li>
                    <li class="list-group-item" id="cdk_moey_show" style="font-size: 18px"></li>
                    <li class="list-group-item" style="text-align:center;background-color: #337AB7; color: white;">是否使用</li>
                    <li class="list-group-item" id="cdk_use_show" style="font-size: 18px"></li>
                    <li class="list-group-item" style="text-align:center;background-color: #337AB7; color: white;">过期时间</li>
                    <li class="list-group-item" id="cdk_datetiem_show" style="font-size: 18px"></li>
                </ul>
            </div>
        </div>
    </div>
<script type="text/javascript">


    window.onload = function () {

        /**
         *输入的内容接收
         */
        var cdk_content = document.getElementById("cdk_content");//CDK

        /**
         * 显示的内容接收
         */
        var cdk_key_show = document.getElementById("cdk_key_show");//CDK
        var cdk_moey_show = document.getElementById("cdk_moey_show");//金额
        var cdk_use_show = document.getElementById("cdk_use_show");//是否使用
        var cdk_datetiem_show = document.getElementById("cdk_datetiem_show");//过期时间


        var cdk_btn = document.getElementById("cdk_btn");

        cdk_btn.onclick = function () {
            /**
             * Ajax四步操作，得到服务器响应
             * 把响应信息显示到元素中
             */
            var xmlhttp = creatXMLHttpRequest();
            xmlhttp.open("POST", "/Accout/Admin/SendCdkServlet", false);
            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp.send("sele_name="+cdk_content.value+"&model_int=2");//POST请求体
            //双重判断: xmlhttp的状态为4(服务器响应结束) 以及 服务器返回的状态码为200(响应成功)
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                var text = xmlhttp.responseText;

                var json = eval("(" + text + ")");//将字符串转换为JSON对象
                cdk_key_show.innerText     =json[0].cdk;
                cdk_moey_show.innerText    =json[0].money+" RMB";
                if (json[0].effective==0){
                    cdk_use_show.innerText ="未使用";
                }else {
                    cdk_use_show.innerText ="已使用";
                }
                cdk_datetiem_show.innerText=json[0].overduetime;



            }
        }
    }
</script>

<%@include file="../../internal/underlying.jsp"%>