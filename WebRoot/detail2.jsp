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
	<style type="text/css">
		.content_reply{
			margin-left: 100px;
		}
	</style>
	<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
	<script type="text/javascript">
		var cid = <%=request.getAttribute("cid")%>;
		var tid = <%=request.getAttribute("tid")%>;
		var dialogVisible = false;
		var inp = $("<input type='text' id='_content'/><button onclick='reply()'>回复</button>");
		var dialogNode = null;
		function show(node,pid){
			
			$("#tid").val(tid);
			$("#pid").val(pid);
			if(dialogNode != node){
				inp.remove();
				$(node).after(inp);
				dialogNode = node;
			}else{
				if(!dialogVisible){
					$(node).after(inp);
					dialogNode = node;
					dialogVisible = dialogVisible?false:true;
				}
			}
			$("#_content").focus();
			
		}
		function reply(){
			$("#input_content").val($("#_content").val());
			$("#_content").val("ddd");
			
			inp.remove();
			console.log($("#input_content").val());
			console.log($("#publish").serialize());
			dialogVisible = false;
			$("#publish").submit();
		}
		$(function(){
			$(".content_item:even").css("background","#CCC");
			var maxPage = <%=request.getAttribute("maxPageSize") %>;
			var index = <%=request.getAttribute("index") %>;
			
			
			$(".catalog_item").eq(cid-1).css("background","#CCC");
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
  			<% User user = (User)session.getAttribute("user");%>
  			<%=user.getUname()%>
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
  		Object objects = request.getAttribute("items");
  		
  		for(Map<String,Object> m:(List<Map<String,Object>>)objects){
  		Reply r = ((Reply)m.get("floor"));
  		%>
  			<!--楼层内容-->
  			<div class="content_item">
  				  发布人：<%=r.getUser().getUname() %>||<%=r.getContent()%>
  				<font size="2">发布时间:<%=DateFormat.dateToString(r.getRtime())%></font>
  				<a href="javascript:void(0);" onclick="show(this,<%=r.getRid()%>)">回复</a>
  			</div>
  		<%
  						
				  		List<Reply> replys = (List<Reply>)m.get("reply");
				  		for(Reply reply:replys){
				  		%>
				  		<!--回复内容-->
				  		<div class="content_item content_reply">
				  				  <%=reply.getUser().getUname()%>
				  				  <%=reply.getPuser().getUid() == r.getUser().getUid() ? ":":"回复："+reply.getPuser().getUname() %>
				  				  &nbsp;&nbsp;<%=reply.getContent()%>
				  				<font size="2">发布时间:<%=DateFormat.dateToString(reply.getRtime())%></font>
				  				<a href="javascript:void(0);" onclick="show(this,<%=reply.getRid()%>)">回复</a>
				  		</div>
  		
  		<%
  		}
  		}%>
  		<div class="pagination">
  			<form action="detail" method="post" id="switchPage">
  				<input type="hidden" id="index" name="index"/>
  			</form>
  			<button id="pre">上一页</button>
  			<%=request.getAttribute("index") %>
  			<button id="next">下一页</button>
  		</div>
  	</div>
  	<form action="publish!publishReply" method="post" id="publish">
  		<input type="hidden" name="pid" id="pid"/>
  		<input type="hidden" name="tid" id="tid"/>
    	<input type="hidden" name="content" id="input_content"/>
    </form>
    
    <form action="publish!publishReply" method="post">
  		<input type="hidden" name="pid" value="0"/>
  		<input type="hidden" name="tid" value="<%=request.getAttribute("tid")%>"/>
    	<input type="text" name="content" /><br />
    	<input type="submit" value="发布" >
    </form>
  	
  </body>
</html>
