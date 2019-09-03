
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
                                <div class="input-group-addon">查询条件</div>
                                <input  id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryBtn"  type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button id="deleteBatchBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" id="user_add_model_btn" class="btn btn-primary" style="float:right;" o><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered" id="users_table">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input id="check_all" type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>

                            <div  id="page_nav_area">

                            </div>
                        </table>
                    </div>
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
        to_page(1);
    });





    $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    });


    $(function () {
        to_page(1);
    })
    var totalRecord,currentNum;


    function to_page(pn) {

        var loadingIndex=-1;
        $.ajax({
            url:"${APP_PATH}/user/users.do",
            type: "get",
            data:{
                "pn":pn,
                "queryText":queryText,
            },
            beforeSend: function () {
                loadingIndex = layer.load(2,{time:10*1000});
            },
            success:function (result) {
                layer.close(loadingIndex);
                //构建用户表格数据
                build_users_table(result);
                //解析并显示分页数据
                build_page_nav(result);
                //解析显示分页信息
                build_page_info(result);

                function build_users_table(result) {
                    $("#users_table tbody").empty();
                    var user=result.extend.pageInfo.list;
                    $.each(user,function (index,item) {
                        var userIdTd = $("<td></td>").append(item.id);
                        var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>")
                        var userAcctTd=$("<td></td>").append(item.loginacct);
                        var userNameTd=$("<td></td>").append(item.username);
                        var userEmailTD = $("<td></td>").append(item.email);

                        var roleBtn = $("<button></button>").addClass("btn btn-success btn-xs role_btn").append($("<i></i>")).addClass("glyphicon glyphicon-check");
                        roleBtn.attr("role_id", item.id);
                        var editBtn=$("<button></button>").addClass("btn btn-primary btn-xs edit_btn").append($("<i></i>")).addClass("glyphicon glyphicon-pencil");
                        editBtn.attr("edit_id", item.id).attr("loginacct", item.loginacct).attr("username", item.username).attr("email", item.email);

                        var deleteBtn=$("<button></button>").addClass("btn btn-danger btn-xs delete_btn").append($("<i></i>")).addClass("glyphicon glyphicon-remove");
                        deleteBtn.attr("del_id",item.id).attr("useracct",item.loginacct);
                        var btnTd = $("<td></td>").append(roleBtn).append(" ").append(editBtn).append(" ").append(deleteBtn);

                        $("<tr></tr>").append(userIdTd).append(checkBoxTd).append(userAcctTd).append(userNameTd).append(userEmailTD).append(btnTd)
                            .appendTo("#users_table tbody");
                    })
                }
            }
        })
    }

    $(document).on("click",".role_btn",function () {
        var id = $(this).attr("role_id");
        window.location.href="${APP_PATH}/user/assignRole.htm?id="+id;
    })



    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("总记录数："+result.extend.pageInfo.total+"当前页:"+result.extend.pageInfo.pageNum+"总页数："+result.extend.pageInfo.pages);
        totalRecord=result.extend.pageInfo.total;
        currentNum=result.extend.pageInfo.pageNum;
    }



    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        var firstPage=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePage=$("<li></li>").append($("<a></a>").append("&laquo;"));
        ul.append(firstPage).append(prePage);

        if (result.extend.pageInfo.hasPreviousPage==false) {
            firstPage.addClass("disabled");
            prePage.addClass("disabled");
        }else{
            firstPage.click(function () {
                to_page(1);
            })

            prePage.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            })
        }

        var nextPage =$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPage=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPage.addClass("disabled");
            lastPage.addClass("disabled");
        }else{
            nextPage.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            })
            lastPage.click(function () {
                totalNum=result.extend.pageInfo.total;
                to_page(totalNum);

            })
        }

        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum==item){
                numLi.addClass("active");
            }
            ul.append(numLi);
            numLi.click(function () {
                to_page(item);
            })
        });

        ul.append(nextPage).append(lastPage);

        var nav=$("<nav><nav>").append(ul);
        nav.appendTo("#page_nav_area");
    }
    //条件查询
    var queryText;
    $("#queryBtn").click(function () {
        queryText = $("#queryText").val();
        to_page(1);
    })

    //用户添加模态框
    $("#user_add_model_btn").click(function () {
        $("#userAddModel").modal();
        reset_form("#userAddModel form");
    })


    //清空表单样式和内容
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success")
        $(ele).find(".help-block").text("");
    }



    $("#user_save_btn").click(function () {

        $.ajax({
            url:"${APP_PATH}/user/user.do",
            type:"POST",
            data: $("#userAddModel form").serialize(),
            success:function () {
                $("#userAddModel").modal('hide');
                to_page(totalRecord);
            }
        })
    })

    $(document).on("click",".delete_btn",function () {
        var useracct =$(this).attr("useracct")
        var userId = $(this).attr("del_id");
            layer.confirm("您确认要删除"+useracct+"?",  {icon: 3, title:'提示'}, function(index){
            layer.close(index);
            $.ajax({
                url:"${APP_PATH}/user/doDelete.do",
                data:"ids="+userId,
                type:"post",
                success: function () {
                    layer.msg("删除成功",{time:1000, icon:1, shift:6},function () {
                        to_page(currentNum);
                    })

                }
            })
        });
    })
    
    $("#check_all").click(function () {
        var all_check = $(this).prop("checked");
        $(".check_item").prop("checked", all_check);
    })

    $(document).on("click",".check_item",function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    })


    //批量删除
    $("#deleteBatchBtn").click(function () {
        var ids="";
        var username=""
        $.each($(".check_item:checked"),function () {
            ids+= $(this).parents("tr").find("td:eq(0)").text()+ "-";
            username+= $(this).parents("tr").find("td:eq(3)").text()+ ",";
        })
        username=username.substring(0,username.length-1);
        ids=ids.substring(0, ids.length - 1);
        console.log(ids);
        layer.confirm("您确认要删除"+username+"?",  {icon: 3, title:'提示'}, function(index) {
            $.ajax({
                url: "${APP_PATH}/user/doDelete.do",
                data: {
                    "ids":ids,
                },
                type: "post",
                success:function () {
                    layer.msg("删除成功",{time:1000, icon:1, shift:6},function () {
                        to_page(currentNum);
                    })
                }

            })
            layer.close(index);

        });
    })


    //用户修改
    $(document).on("click",".edit_btn",function () {
        var id=$(this).attr("edit_id");
        var username=$(this).attr("username");
        var loginacct = $(this).attr("loginacct");
        var email=$(this).attr("email");
        $("#edit_input_id").val(id);
        $("#loginacct_update_input").val(loginacct);
        $("#username_update_input").val(username);
        $("#email_update_input").val(email);

        $("#userUpdateModel").modal();
    })



    $("#user_update_btn").click(function () {
        $.ajax({
            url:"${APP_PATH}/user/doUpdate.do",
            type: "post",
            data: $("#userUpdateModel form").serialize(),
            success:function () {
                $("#userUpdateModel").modal('hide');
                to_page(currentNum);
                layer.msg("修改成功",{time:1000, icon:1, shift:6},function () {
                })
            }
        })

    })


    







</script>
</body>
</html>
