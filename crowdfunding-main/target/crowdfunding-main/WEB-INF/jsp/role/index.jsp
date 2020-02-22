<%--
  Created by IntelliJ IDEA.
  User: kaixuan
  Date: 2019/8/25
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="GB18030">
<head>
    <meta charset="GB18030">
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
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='form.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered" id="role_table">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <li class="disabled"><a href="#">上一页</a></li>
                                        <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
                                        <li><a href="#">2</a></li>
                                        <li><a href="#">3</a></li>
                                        <li><a href="#">4</a></li>
                                        <li><a href="#">5</a></li>
                                        <li><a href="#">下一页</a></li>
                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/script/menu.js"></script>
<script type="text/javascript">

    $(function () {
        to_rolePage(1);
    })

    function to_rolePage(pn) {

        $.ajax({
            url:"${APP_PATH}/role/roles.do",
            type: "get",
            data: "pn="+pn,
            success:function (result) {
                build_role_table(result);


            }

        })
    }

    function build_role_table(result) {
        var role = result.extend.pageInfo.list;
        $.each(role,function (index,item) {
            var roleIdTd = $("<td></td>").append(item.id);
            var roleNameTd = $("<td></td>").append(item.name);
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>")

            var roleBtn = $("<button></button>").addClass("btn btn-success btn-xs role_btn").append($("<i></i>")).addClass("glyphicon glyphicon-check");
            roleBtn.attr("role_id", item.id);
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-xs edit_btn").append($("<i></i>")).addClass("glyphicon glyphicon-pencil");
            editBtn.attr("edit_id", item.id).attr("roleName", item.name);

            var deleteBtn=$("<button></button>").addClass("btn btn-danger btn-xs delete_btn").append($("<i></i>")).addClass("glyphicon glyphicon-remove");
            deleteBtn.attr("del_id",item.id).attr("roleName",item.name);
            var btnTd = $("<td></td>").append(roleBtn).append(" ").append(editBtn).append(" ").append(deleteBtn);

            $("<tr></tr>").append(roleIdTd).append(checkBoxTd).append(roleNameTd).append(btnTd)
                .appendTo("#role_table tbody");
        })

    }


    $(document).on("click",".role_btn",function () {
        var id = $(this).attr("role_id");
        window.location.href = "${APP_PATH}/role/toAssignRole.htm?roleid="+id;

    })

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
        window.location.href = "assignPermission.html";
    });
</script>
</body>
</html>
