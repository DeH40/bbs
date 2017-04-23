<%@ page language="java" import="java.util.*,com.bbs.service.*,org.springframework.context.ApplicationContext,com.bbs.model.*,com.bbs.tool.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>BBS</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/mian.css"/>
	<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
	<script type="text/javascript">
		$(function(){
			$(".content_item:even").css("background","#CCC");
			var node = "<img src='icon/top.png' />";
			$(".top").prepend($(node));
			var maxPage = <%=request.getAttribute("maxPageSize") %>;
			var index = <%=request.getAttribute("index") %>;
			var cid = <%=request.getAttribute("cid")%>;
			$(".catalog_item").eq(cid-1).css("background","#CCC");
//			alert(maxPage);
			if(index <= 1 ){
				$("#pre").attr("disabled","disabled");
			}else{
				$("#pre").click(function(){
					index--;
					$("#index").val(index);
					$("#switchPage").submit();
				})	
			}
			
			if(index >= maxPage){
				$("#next").attr("disabled","disabled");
			}else{
				$("#next").click(function(){
					index++;
					$("#index").val(index);
					$("#switchPage").submit();
				})
			}
		})
	</script>
  </head>
  
  <body>
  	<div id="head">
  		<div id="logo">
  			<a href="index"><img src="http://www.uugai.com/logo/logo_a/20170303/148853474272215c.png" width="200px" height="49px"/></a>
  		</div>
  		<div id="user">
  			<div id="rl">
  				<a href="login.jsp">登录</a>|
  				<a href="register">注册</a>
  			</div>
  		</div>
  	</div>
  	<div id="catalog">
  		<div id="catalog_title">
  			板块列表
  		</div>
  		<hr width="98%" style="margin: 0 auto;"/>
  		<%
  		int[] catalogSize = (int[])request.getAttribute("catalogSize");
  		int i = 0;
  		for(Catalog c:(List<Catalog>)request.getAttribute("catalogs")){
  		%>
  		<div class="catalog_item">
  			<a href="index?cid=<%=c.getCid()%>"><%=c.getCname() %>(<%=catalogSize[i]%>)</a>
  		</div>
  		<%
  		i++;
  		}
  		%>
  		
  	</div>
  	<div id="content">
  		<%
  		int[] topicSize = (int[])request.getAttribute("topicSize");
  		i = 0;
  		%>
  		<%
  			for(Topic t:(List<Topic>)request.getAttribute("tops")){
  		%>
  		<div class="content_item top">
  				<a href="detail?tid=<%=t.getTid()%>"><%=t.getTname()%>(<%=topicSize[i] %>)</a>
  				<font size="2">发布时间:<%=DateFormat.dateToString(t.getCtime())%>  发布人：<%=t.getUser().getUname() %></font>
  			</div>
  		<%
  		i++;
  		}%>
  		
  		<%
  		for(Topic t:(List<Topic>)request.getAttribute("topics")){%>
  			<div class="content_item">
  				<a href="detail?tid=<%=t.getTid()%>"><%=t.getTname()%>(<%=topicSize[i] %>)</a>
  				<font size="2">发布时间:<%=DateFormat.dateToString(t.getCtime())%>  发布人：<%=t.getUser().getUname() %></font>
  			</div>
  		<%
  		i++;
  		}%>
  		<div class="pagination">
  			<form action="index" method="post" id="switchPage">
  				<input type="hidden" id="index" name="index"/>
  			</form>
  			<button id="pre">上一页</button>
  			<%=request.getAttribute("index") %>
  			<button id="next">下一页</button>
  		</div>
  	</div>
  	
  	<form action="publish!publishTopic" method="post">
  		<input type="hidden"  value="<%=request.getAttribute("cid")%>" name="cid"/>
    	<label for="title">主题</label><input type="text" name="title" id="title" value=""/><br />
    	<label for="content">内容</label><input type="text" name="content" id="content" value="" /><br />
    	<input type="submit" value="发布主题"/>
    </form>
  	
  	<%=request.getAttribute("cid") %>
  	<%=request.getAttribute("maxPageSize") %>
  </body>
</html>
