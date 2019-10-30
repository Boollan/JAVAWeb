
<%@include file="../internal/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

    <div class="panel panel-default">
        <div class="panel-heading">
            <ul class="nav nav-pills" role="tablist">
                <li role="presentation" class="active"><a href="#">生成CDK</a></li>
                <li role="presentation"><a href="/accout/admin/module/cdk_module/admin_cdk_select.jsp">查询CDK</a></li>
                <li role="presentation"><a href="/accout/admin/module/cdk_module/admin_cdk_dele.jsp">删除CDK</a></li>
            </ul>
        </div>
        <div class="panel-body">
            <div class="col-lg-10 popover-content " style="margin-left: 7%">
                <h1>没有实装~仅供展示之用</h1>
                <h3>卡密生成</h3>
                <p>每次生成卡密最大数量为10张</p>
                <p>关于过期时间 格式为 yyyy-mm-dd（年-月-日）</p>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">数量:</span>
                    <input type="text" id="cdk_num" class="form-control" placeholder="请输入数量"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon2">金额:</span>
                    <input type="text" id="cdk_moey" class="form-control" placeholder="请输入金额"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <% SimpleDateFormat sdf = new SimpleDateFormat();// 格式化时间
                    sdf.applyPattern("yyyy-MM-dd");// a为am/pm的标记
                    Date date = new Date(); // 获取当前时间  %>

                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon3">过期时间:</span>
                    <input type="date" id="cdk_datetime" class="form-control"
                           min="<% out.print(sdf.format(date));%>" placeholder="请输入过期时间"
                           aria-describedby="basic-addon1">
                </div>
                <br>
                <button type="button" id="cdk-btn" class="btn btn-default"
                        style="margin-left: 40%; color: #337AB7; width: 125px;height: 50px">生成卡密
                </button>
                <br>
                <br>
                <h6 style="color: red;">每行一张卡密</h6>
                <textarea class="form-control" id="cdk_text" style="font-weight: bolder;font-size: 12px;"
                          rows="12"></textarea>
            </div>
        </div>
    </div>

<script type="text/javascript">


    window.onload = function () {
        var cdk_num = document.getElementById("cdk_num");//cdk数量
        var cdk_moey = document.getElementById("cdk_moey");//cdk金额
        var cdk_datetime = document.getElementById("cdk_datetime");//过期时间
        var cdk_btn = document.getElementById("cdk-btn");
        var cdk_text = document.getElementById("cdk_text");


        cdk_btn.onclick = function () {

            var xmlhttp = creatXMLHttpRequest();

            xmlhttp.open("POST", "/Accout/Admin/CDKServlet", false);

            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xmlhttp.send("num=" + cdk_num.value + "&moey=" + cdk_moey.value + "&datetime=" + cdk_datetime.value + "");//POST请求体

            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                var text = xmlhttp.responseText;

                var json = eval("(" + text + ")");//将字符串转换为JSON对象

                var str = ' ';

                for (var i = 0 in json) {
                    // '&#xd'
                    str += json[i].cdk + ' &#xd ';
                }
                cdk_text.innerHTML = str;
                alert("卡密成功生成！");

            }

        }

    }
</script>
<%@include file="../internal/underlying.jsp"%>



