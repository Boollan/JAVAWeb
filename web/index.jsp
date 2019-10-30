<%@ page import="com.sun.org.apache.xpath.internal.operations.Or" %><%--
  Created by IntelliJ IDEA.
  User: wyzao
  Date: 2019/8/31
  Time: 10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.module.traverse" %>
<%@ page import="org.json.simple.JSONObject" %>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/bootstrap-3.3.7-dist/imges/loginico.ico">

    <title>依梦汉化组 氾滥原2014 Ⅱ</title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.3.7-dist/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.3.7-dist/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="bootstrap-3.3.7-dist/css/cover.css" rel="stylesheet">


</head>

<body style="background-image: url(/bootstrap-3.3.7-dist/imges/bg_bg.jpg);" ondragstart="return false">

<div class="site-wrapper">

    <div class="site-wrapper-inner">

        <div class="cover-container">

            <div class="masthead clearfix">
                <div class="inner">
                    <h3 class="masthead-brand"><img src="/bootstrap-3.3.7-dist/imges/logo.png" alt="Norway"
                                                    style="max-width: 100%;height: auto; "></h3>
                    <nav>
                        <ul class="nav masthead-nav">
                            <li class="active"><a href="#">首页</a></li>
                            <li><a href="warning.html" style="color: red">注意事项</a></li>
                            <li><a href="donations.html">捐助</a></li>
                            <li><a href="https://blogs.boollan.pro">依梦汉化组</a></li>

                            <%
                                traverse traverse = new traverse();
                                JSONObject jsonObject = traverse.GetHomeShowInfo();
                                Object userName = session.getAttribute("UserName");
                                if (userName != null) {
                                    out.print("<li><a href=\"accout/index.jsp\">" + "账号:" + userName + "</a></li>");
                                } else {
                                    out.print("<li><a href=\"accout/login.jsp\">登录</a></li>");
                                }
                            %>
                        </ul>
                    </nav>
                </div>
                <br><br>
                <div id="myCarousel" class="carousel slide">
                    <!-- 轮播（Carousel）指标 -->
                    <ol class="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                        <li data-target="#myCarousel" data-slide-to="2"></li>
                    </ol>
                    <!-- 轮播（Carousel）项目 -->
                    <div class="carousel-inner">
                        <div class="item active">
                            <img src="<%out.print(jsonObject.get("imge_1"));%>" alt="First slide">
                        </div>
                        <div class="item">
                            <img src="<%out.print(jsonObject.get("imge_2"));%>" alt="Second slide">
                        </div>
                        <div class="item">
                            <img src="<%out.print(jsonObject.get("imge_3"));%>" alt="Third slide">
                        </div>
                    </div>
                    <!-- 轮播（Carousel）导航 -->
                    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" style="color: #2a2730;"><h3 id="Title_text">
                        <%out.print(jsonObject.get("homeTite"));%>
                    </h3></div>
                    <div class="panel-body" id="text" style="color:#2a2730;" align="left">
                        <%out.print(jsonObject.get("HomeText"));%>
                    </div>
                </div>
            </div>

            <div class="mastfoot">
                <div class="inner">
                    <p>® Registered: <a href="https://blogs.boollan.pro/">依梦汉化组</a>，by<a href="http://getbootstrap.com">Bootstrap</a>.
                    </p>
                </div>
            </div>

        </div>

    </div>

</div>

<script src="js/ajax.js"></script>

<!--[if lt IE 9]>
<script src="bootstrap-3.3.7-dist/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
<script src="bootstrap-3.3.7-dist/assets/js/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<%--重要 轮播图片 需要2.1.1 jquery.min.js 支持--%>
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="bootstrap-3.3.7-dist/dist/js/bootstrap.min.js"></script>
<%--<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->--%>
<script src="bootstrap-3.3.7-dist/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

