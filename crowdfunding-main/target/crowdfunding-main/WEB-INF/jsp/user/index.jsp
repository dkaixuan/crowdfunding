
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
    <link rel="stylesheet" href="${APP_PATH}/css/layui.css" media="all">
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
        <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
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
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件(账号)</div>
                                <input  id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryBtn"  type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button id="deleteBatchBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" id="user_add_model_btn" class="btn btn-primary" style="float:right;" o><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                        <table id="users_table" lay-filter="userFilter" >

                        </table>

                </div>
                <div class="row">

                    <div class="col-md-6" id="page_info_area">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!--用户添加的模态框-->
<div class="modal fade" id="userAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">用户添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="loginacct_add_input" class="col-sm-2 control-label">登陆账号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="loginacct" id="loginacct_add_input" placeholder="">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="username_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="username" id="username_add_input" placeholder="">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮箱地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_add_input" placeholder="">
                            <span class="help-block"></span>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>



<!--用户修改的模态框-->
<div class="modal fade" id="userUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="Label">用户修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="loginacct_add_input" class="col-sm-2 control-label">登陆账号</label>
                        <div class="col-sm-10">
                            <input type="hidden" name="id" id="edit_input_id">
                            <input type="text" class="form-control" name="loginacct" id="loginacct_update_input" >
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="username_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="username" id="username_update_input" >
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮箱地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input" >
                            <span class="help-block"></span>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_update_btn">保存</button>
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


<script type="text/html" id="toolBar">
    <a class="layui-btn layui-btn-xs" lay-event="assignRole">分配角色</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a></script>

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





    layui.use('table',function () {
        var table =layui.table;
      var tableIns=table.render({
            elem:'#users_table',
            url: '${APP_PATH}/user/users.do',
            toolbar: true,
            loading:true,
            text: {
                none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
            },
            parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": res.code,
                    "msg": res.msg, //解析提示文本
                    "count": res.extend.pageInfo.total,//解析接口状态
                    "data": res.extend.pageInfo.list   //解析数据列表
                };
            },
            page:true,
            cols:[[
                {checkbox:true},
                {field: 'id', title: 'ID'},
                {field: 'loginacct', title: '账号'},
                {field: 'username', title: '用户名'},
                {field: 'email', title: '邮箱'},
                ,{title:'操作',  width: 250,toolbar: '#toolBar'}
            ]]
        })

        //监听表格复选框选择
        table.on('checkbox(userFilter)', function(obj){

            var checkStatus = table.checkStatus('users_table')
                ,data = checkStatus.data;

            var arr=[];
            data.forEach(function (item) {
                arr.push(item.id);
            })

            var ids = arr.toString();

            console.log(ids);
            $("#deleteBatchBtn").click(function () {
                layer.confirm('真的要删除吗', function(index){
                    $.ajax({
                        url:'${APP_PATH}/user/doDelete.do',
                        data:{
                            'ids': ids
                        },
                        type: 'get',
                        success:function () {
                            layer.msg("删除成功",{time:1000, icon:1, shift:6},function () {
                                layer.close(index);
                                tableIns.reload();
                            })
                        }

                    })


                });
            })



        });




        $("#queryBtn").click(function () {
            var queryText = $("#queryText").val();
            //表格重载
            tableIns.reload({
                url: '${APP_PATH}/user/users.do',
                where:{
                    queryText: queryText,
                }
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            })
        })



        //监听工具栏事件
        table.on('tool(userFilter)',function (obj) {
            var data =obj.data;
            var layEvent = obj.event;
            console.log(data.id);
            var index =1;
            //修改
            if (layEvent === 'edit') {

            }

            //分配角色
            if (layEvent === 'assignRole') {

                window.location.href="${APP_PATH}/user/assignRole.htm?id="+data.id;
                console.log(data.id)
            }

            //删除
            if (layEvent === 'del') {
                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        url:'${APP_PATH}/user/doDelete.do',
                        data:{
                            'ids': data.id
                        },
                        type: 'get',
                        success:function () {
                            layer.msg("删除成功",{time:1000, icon:1, shift:6},function () {
                                layer.close(index);
                                tableIns.reload();
                            })
                        }

                    })


                });
            }





        })





    })
























    $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    });

</script>
</body>
</html>
