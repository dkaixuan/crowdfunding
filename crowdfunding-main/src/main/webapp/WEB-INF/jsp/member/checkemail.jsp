<%--
  Created by IntelliJ IDEA.
  User: kaixuan
  Date: 2019/8/31
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/theme.css">
    <style>
        #footer {
            padding: 15px 0;
            background: #fff;
            border-top: 1px solid #ddd;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="navbar-wrapper">
    <div class="container">
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse" style="float:right;">
                    <ul class="nav navbar-nav">
                        <jsp:include page="/WEB-INF/jsp/member/common/navbar.jsp"/>
                    </ul>
                </div>
            </div>
        </nav>

    </div>
</div>

<div class="container theme-showcase" role="main">
    <div class="page-header">
        <h1>实名认证 - 申请</h1>
    </div>

    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" ><a href="#"><span class="badge">1</span> 基本信息</a></li>
        <li role="presentation" ><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
        <li role="presentation" class="active"><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
        <li role="presentation"><a href="#"><span class="badge">4</span> 申请确认</a></li>
    </ul>

    <form role="form" style="margin-top:20px;">
        <div class="form-group">
            <label for="exampleInputEmail1">邮箱地址</label>
            <input type="text" class="form-control" value="${loginMember.email}"   id="checkEmail" placeholder="请输入用于接收验证码的邮箱地址">
        </div>
        <button type="button"  class="btn btn-default">上一步</button>
        <button id="emailNextBtn"  type="button"   class="btn btn-success">下一步</button>
    </form>
    <hr>
</div> <!-- /container -->
<div class="container" style="margin-top:20px;">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div id="footer">
                <div class="footerNav">
                    <a rel="nofollow" href="http://www.atguigu.com">关于我们</a> | <a rel="nofollow" href="http://www.atguigu.com">服务条款</a> | <a rel="nofollow" href="http://www.atguigu.com">免责声明</a> | <a rel="nofollow" href="http://www.atguigu.com">网站地图</a> | <a rel="nofollow" href="http://www.atguigu.com">联系我们</a>
                </div>
                <div class="copyRight">
                    Copyright ?2017-2017atguigu.com 版权所有
                </div>
            </div>

        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script>
    $('#myTab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    });

    var loadingIndex = -1;

    $("#emailNextBtn").click(function(){
        $.ajax({
            url : "${APP_PATH}/member/startProcess.do",
            data:{
                "email": $("#checkEmail").val(),
            },
            type:"post",
            beforeSend : function() {
                loadingIndex = layer.msg('邮件发送中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if (result.msg=="处理成功") {
                    layer.msg("邮件发送成功", {time:1000, icon:6}, function(){
                        window.location.href = "${APP_PATH}/member/apply.htm";
                    });
                } else {
                    layer.msg("邮件发送失败", {time:1000, icon:5, shift:6});
                }
            }
        })
    });






</script>
</body>
</html>