<%--
  Created by IntelliJ IDEA.
  User: kaixuan
  Date: 2019/8/31
  Time: 14:49
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
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 实名认证审核</a></div>
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
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered" id="authcert_table">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th>流程名称</th>
                                <th>流程版本</th>
                                <th>任务名称</th>
                                <th>申请会员</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                            <tfoot>
                            <tr >
                                <div id="page_nav_area">


                                </div>
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



    var totalRecord,currentNum;

    function to_page(pn) {

        var loadingIndex=-1;
        $.ajax({
            url:"${APP_PATH}/authcert/queryAll.do",
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
                    $("#authcert_table tbody").empty();
                    var user=result.extend.pageInfo.list;
                    $.each(user,function (index,item) {
                        var IdTd = $("<td></td>").append(item.member.id);
                        var procDeNameTd=$("<td></td>").append(item.procDeName);
                        var procDefVersionTd=$("<td></td>").append(item.procDefVersion);
                        var taskNameTD = $("<td></td>").append(item.taskName);
                        var usernameTD = $("<td></td>").append(item.member.username);

                        var showBtn = $("<button></button>").addClass("btn btn-success btn-xs show_btn").append($("<i></i>")).addClass("glyphicon glyphicon-check");
                        showBtn.attr("member_id", item.member.id);
                        showBtn.attr("taskId", item.taskId);


                        var btnTd = $("<td></td>").append(showBtn);

                        $("<tr></tr>").append(IdTd).append(procDeNameTd).append(procDefVersionTd).append(taskNameTD).append(usernameTD).append(btnTd)

                            .appendTo("#authcert_table tbody");
                    })
                }
            }
        })
    }

    $(document).on("click",".show_btn",function () {
        var id = $(this).attr("member_id");
        var taskId = $(this).attr("taskId");

        window.location.href='${APP_PATH}/authcert/show.htm?taskid='+taskId+'&memberid='+id;
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
</script>
</body>
</html>
