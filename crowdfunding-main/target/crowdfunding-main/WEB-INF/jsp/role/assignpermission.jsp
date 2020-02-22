<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/ztree/zTreeStyle.css">

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
    </div>
    <jsp:include page="/WEB-INF/jsp/user/common/navbar.jsp"></jsp:include>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <jsp:include page="/WEB-INF/jsp/user/common/menu.jsp"></jsp:include>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>许可树</h3>
                </div>
                <div class="panel-body">
                    <button id="assignPermissionBtn" class="btn btn-success">分配许可</button>
                    <br><br>
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>




<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/ztree/jquery.ztree.all-3.5.min.js"></script>
<script src="${APP_PATH}/script/menu.js"></script>

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
        showMenu();
    });
    $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    });





    var setting = {
        check : {
            enable : true  //在树节点前显示复选框
        },
        view: {
            selectedMulti: false,
            addDiyDom: function(treeId, treeNode){
                var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                if ( treeNode.icon ) {
                    icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
                }
            },
        },
        async: {
            enable: true, //采用异步
            url:"${APP_PATH}/role/loadDataAsync.do?roleid=${param.roleid}", // ?id=1&n=xxx&lv=2
            autoParam:["id", "name=n", "level=lv"]
        },
        callback: {
            onClick : function(event, treeId, json) {

            }
        }
    };

    //异步加载树:注意问题,服务器端返回的结果必须是一个数组.
    $.fn.zTree.init($("#treeDemo"), setting); //异步加载树的数据.
    //$.fn.zTree.init($("#treeDemo"), setting , ztreeJSON);//同步加载树的数据.

    var permissionId = "";

    $("#assignPermissionBtn").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var checkedNodes = treeObj.getCheckedNodes(true);

        if(checkedNodes.length == 0) {
            layer.msg("请选择至少一个分配许可", {time:1000, icon:5});
        }else{
            var loadingIndex = -1;

            $.each(checkedNodes,function (index,item) {
                permissionId += item.id+"-";
            })


            permissionId=permissionId.substring(0, permissionId.length - 1);


            $.ajax({
                url:"${APP_PATH}/role/doAssignPermission.do",
                type: "post",
                data:{
                    roleid:${param.roleid},
                    ids: permissionId,
                },
                beforeSend : function(){
                    loadingIndex = layer.msg('正在分配许可...', {icon: 16});
                    return true ;
                },
                success:function () {
                    layer.close(loadingIndex);
                    layer.msg("分配成功", {time:1000, icon:6});
                     permissionId = "";
                }
            })
        }






        
    })













</script>
</body>
</html>
