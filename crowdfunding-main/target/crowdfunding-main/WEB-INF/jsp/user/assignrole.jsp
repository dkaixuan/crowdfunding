<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/layui.css" media="all">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">

                    <div id="userTransfer"></div>


                </div>
            </div>
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/layer/layui.js"></script>
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

    $.ajax({
        url:'${APP_PATH}/user/getAssignRole.do',
        type:'get',
        data:{
            'id':${id}
        },
        success:function (result) {
         var rightList=result.extend.rightList;
          //已分配角色Id
          var arrId=[];
          rightList.forEach(function (item) {
              arrId.push(item.id);
          })

            //所有角色
          var leftList=result.extend.leftList;
            console.log(leftList);
            console.log(arrId);
            layui.use('transfer', function(){
                var transfer = layui.transfer;
                //渲染
                transfer.render({
                    elem: '#userTransfer',
                    url: '${APP_PATH}/user/getAssignRole.do'+${id},//绑定元素
                    //data:未分配角色
                    data: leftList,
                    title:['未分配角色','已分配角色'],
                    //value:已分配角色
                    value:arrId
                    ,parseData: function(result){
                        return {
                            "value": result.id //数据值
                            ,"title": result.name //数据标题
                            ,"disabled": ""  //是否禁用
                            ,"checked": ""//是否选中
                        }
                    }
                    ,onchange: function(data, index){
                        var arrRoleId=[];
                        data.forEach(function (item) {
                            arrRoleId.push(item.value);
                        })
                        var RoleIds = arrRoleId.toString();
                        var loadingIndex=1;
                        if (index == 1) {
                            //取消角色
                            $.ajax({
                                url:'${APP_PATH}/user/doUnAssignRole.do',
                                data:{
                                    userid:'${id}',
                                    roleIds:RoleIds
                                },
                                beforeSend:function () {
                                    loadingIndex = layer.load(2,{time:10*1000});
                                },
                                success:function () {
                                    layer.msg("取消分配",{time:1000, icon:1, shift:6},function () {
                                        layer.close(loadingIndex);
                                    })
                                }
                            })
                        }

                        if (index ==0) {
                            //分配角色
                            $.ajax({
                                url:'${APP_PATH}/user/doAssignRole.do',
                                data:{
                                    userid:'${id}',
                                    roleIds:RoleIds
                                },
                                beforeSend:function () {
                                    loadingIndex = layer.load(2,{time:10*1000});
                                },
                                success:function (result) {
                                    if (result.code == 0) {
                                        layer.msg("分配成功",{time:1000, icon:1, shift:6},function () {
                                            layer.close(loadingIndex);
                                        })
                                    }
                                }
                            })
                        }

                        //console.log(data); //得到当前被穿梭的数据
                        //console.log(index); //如果数据来自左边，index 为 0，否则为 1



                    }
                    ,id: 'demo1' //定义索引

                });
            });


        }
    })






</script>
</body>
</html>
