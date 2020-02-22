<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH }/css/main.css">
    <link rel="stylesheet" href="${APP_PATH }/css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 实名认证审核</a></div>
        </div>
        <jsp:include page="/WEB-INF/jsp/user/common/navbar.jsp"></jsp:include>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <jsp:include page="/WEB-INF/jsp/user/common/menu.jsp"></jsp:include>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">显示会员资质信息</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">会员数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <div class="panel-body">
                        <form>
                            <div class="form-group">
                                <label for="frealname">会员真实姓名</label>
                                ${member.realname }
                            </div>
                            <div class="form-group">
                                <label for="fcardnum">会员身份证号</label>
                                ${member.cardnum }
                            </div>
                            <div class="form-group">
                                <label for="ftel">会员电话号</label>
                                ${member.tel }
                            </div>

                            <hr>
                            <c:forEach items="${certimgs }" var="map">
                                <div class="form-group">
                                    <label for="frealname">${map.name }</label><br>
                                    <img src="${APP_PATH}/pics/cert/${map.iconpath}">
                                </div>
                            </c:forEach>

                            <button id="passBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 通过</button>
                            <button id="refuseBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 拒绝</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH }/script/docs.min.js"></script>
<script type="text/javascript" src="${APP_PATH }/jquery/layer/layer.js"></script>

<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

    $("#passBtn").click(function(){
        $.ajax({
            type : "POST",
            url  : "${APP_PATH}/authcert/pass.do",
            data : {
                taskid : "${param.taskid}",
                memberid : "${param.memberid}"
            },
            success : function(result) {
                window.location.href = "${APP_PATH}/authcert/index.htm";
            }
        });
    });

    $("#refuseBtn").click(function(){
        $.ajax({
            type : "POST",
            url  : "${APP_PATH}/authcert/refuse.do",
            data : {
                taskid : "${param.taskid}",
                memberid : "${param.memberid}"
            },
            success : function(result) {
                window.location.href = "${APP_PATH}/authcert/index.htm";
            }
        });

    });
</script>
</body>
</html>
