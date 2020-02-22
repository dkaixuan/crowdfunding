<%--
  Created by IntelliJ IDEA.
  User: kaixuan
  Date: 2019/8/28
  Time: 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-ch">
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
        <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 流程管理</a></div>
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

                    <button  id="uploadBtn" type="button" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-upload"></i> 上传流程定义文件</button>
                    <br>
                    <hr style="clear:both;">
                    <form id="deployForm"  action="" method="post" enctype="multipart/form-data">
                        <input style="display:none" id="processDefFile" type="file" name="processDefFile">
                    </form>

                    <div class="table-responsive">
                        <table class="table  table-bordered" id="process_table">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th>流程定义名称</th>
                                <th>流程定义版本</th>
                                <th>流程定义Key</th>
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
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery-form/jquery-form.min.js"></script>

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




    $(function () {
        to_page(1);
    })
    var totalRecord,currentNum;


    function to_page(pn) {

        var loadingIndex=-1;
        $.ajax({
            url:"${APP_PATH}/process/doIndex.do",
            type: "get",
            data:{
                "pn":pn,
            },
            beforeSend: function () {
                loadingIndex = layer.load(2,{time:10*1000});
            },
            success:function (result) {
                layer.close(loadingIndex);
                //构建用户表格数据
                build_users_table(result);
                //解析并显示分页数据

                function build_users_table(result) {
                    $("#process_table tbody").empty();
                    var user=result.extend.pageInfo.list;
                    $.each(user,function (index,item) {
                        var processIdTd = $("<td></td>").append(item.id);
                        var processNameTd=$("<td></td>").append(item.name);
                        var processVsnTd=$("<td></td>").append(item.version);
                        var processKeyTD = $("<td></td>").append(item.key);

                        var showProcessBtn = $("<button></button>").addClass("btn btn-success btn-xs showProcess_btn").append($("<i></i>")).addClass(" glyphicon glyphicon-eye-open");
                        showProcessBtn.attr("process_id", item.id);

                        var deleteBtn=$("<button></button>").addClass("btn btn-danger btn-xs delete_btn").append($("<i></i>")).addClass("glyphicon glyphicon-remove");
                        deleteBtn.attr("del_id",item.id).attr("process_name",item.name);
                        var btnTd = $("<td></td>").append(showProcessBtn).append(" ").append(" ").append(deleteBtn);

                        $("<tr></tr>").append(processIdTd).append(processNameTd).append(processVsnTd).append(processKeyTD).append(btnTd)
                            .appendTo("#process_table tbody");
                    })
                }
            }
        })
    }

    
    
    $("#uploadBtn").click(function () {
        $("#processDefFile").click()
    })
    var loadingIndex = -1;

    $("#processDefFile").change(function () {
        var options={
            url: "${APP_PATH}/process/deploy.do",
            beforeSubmit:function () {
                loadingIndex=layer.msg("流程部署中",{icon:6});
                return true;
            },
            success:function () {
                layer.close(loadingIndex);
                layer.msg("流程部署成功",{time:1000,icon:6, shift: 6})
                to_page(1);
            }
        }
        $("#deployForm").ajaxSubmit(options);
        return;
    })
    
 $(document).on("click",".delete_btn",function () {
     var processId=$(this).attr("del_id");
     var processName = $(this).attr("process_name");
     console.log(processId);
     layer.confirm("您确认要删除"+processName+"?",  {icon: 3, title:'提示'}, function(index){
         layer.close(index);
         $.ajax({
             url:"${APP_PATH}/process/doDelete.do",
             data:"id="+processId,
             type:"post",
             success: function () {
                 layer.msg("删除成功",{time:1000, icon:1, shift:6},function () {
                     to_page(1);
                 })

             }
         })
     });
 })

    $(document).on("click",".showProcess_btn",function () {
        var processId = $(this).attr("process_id");
    window.location.href='${APP_PATH}/process/showimg.do?id='+processId+'';
    })




</script>
</body>
</html>
