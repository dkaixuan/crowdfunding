<%--
  Created by IntelliJ IDEA.
  User: kaixuan
  Date: 2019/8/29
  Time: 15:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i>${loginMember.username}<span class="caret"></span></a>
    <ul class="dropdown-menu" role="menu">
        <li><a href="member.html"><i class="glyphicon glyphicon-scale"></i> 会员中心</a></li>
        <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
        <li class="divider"></li>
        <li><a href="${APP_PATH}/logout.htm"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
    </ul>
</li>