<%@page import="com.bbs.action.LoginAndRegAction"%>
<%@ page language="java" import="java.util.*,com.bbs.model.*,com.bbs.tool.*" pageEncoding="utf-8"%>
<div id="background"><img src="http://www.17sucai.com/upload/293598/2015-09-25/1c89c0645f3942044e4b1b26f0f0a913.png"></div>
<nav class="navbar navbar-default navbar-fixed-top  navbar-inverse">
    <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
      <a class="navbar-brand" href="#">BBS</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="index">主页 <span class="sr-only">(current)</span></a></li>
       
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">更多<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="http://wpa.qq.com/msgrd?v=3&uin=2608027102&site=qq&menu=yes" target="_blank" title="2608027102">QQ联系</a></li>
			<li><a href="mailto:2608027102@qq.com" target="_blank" title="2608027102@qq.com">邮箱联系</a></li>
            <li><a href="#">建设中...</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">建设中...</a></li>
          </ul>
        </li>
      </ul>
      <form class="navbar-form navbar-left" id="search-form">
        <div class="form-group">
            <div class="input-group">
                <div class="input input-group-addon"><span class="glyphicon glyphicon-search"></span></div>
                <input type="text" class="form-control" placeholder="输入关键字">
            </div>
        </div>
        <button type="submit" class="btn btn-default">搜索</button>
      </form>
      <ul class="nav navbar-nav navbar-right">
        
        <!-- 用户信息  -->
        <%Object userObject = session.getAttribute(LoginAndRegAction.USER_IN_SESSION); 
           User user = null;
        %>
        <%if(null != userObject){ 
            user = (User)userObject;
        %>
		<li id="popover-container">
		<div style="position:absolute" ></div>
		<a href="javascript:void(0)"><span class="glyphicon glyphicon-envelope text-success" data-container="#popover-container div" data-toggle="popover" data-placement="bottom"
		style="color:white" id="popover-message" data-visible="false" data-trigger="disable"
		></span></a>
        </li>
        <li ><a href="myzone" >
        <img src="<%=user.getUface()%>" style="max-width:20px;max-height:20px">
        <span class="text-primary"><%=user.getUname() %></span></a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                   用户中心 <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="myzone">个人中心</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="rl!logout">注销</a></li>
          </ul>
        </li>
        <%} else{%>
            <li><a href="register.jsp">注册</a></li>
            <li><a href="login.jsp">登录</a></li>
        
        <%} %>
        <!-- 用户信息结束 -->
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
