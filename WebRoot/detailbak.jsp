<%@page import="com.bbs.action.LoginAndRegAction"%>
<%@ page language="java" import="java.util.*,com.bbs.service.*,org.springframework.context.ApplicationContext,com.bbs.model.*,com.bbs.tool.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">

	<head>
	<base href="<%=basePath%>">
	<title>BBS</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css"href="highlight/styles/dark.css"/> 
	<!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
	
	<style>
	body{
		padding-top:70px;
	}
	</style>
	
	
  </head>
  
  <body>
<%@include file="header.jsp"%>

<!--
	catalog
-->
<div class="container">
<div class="panel panel-default ">
  <div class="panel-heading">
    <h3 class="panel-title">帖子分类</h3>
  </div>
  <div class="panel-body">
    <ul class="list-group list-inline">
    	<%-- <li class="list-group-item"><a href="#" class="btn btn-default active">休闲灌水<span class="badge">13</span></a></li>
    	<li class="list-group-item"><a href="#" class="btn btn-default">交流学习<span class="badge">13</span></a></li> --%>
    	<%
	  		int[] catalogSize = (int[])request.getAttribute("catalogSize");
	  		int i = 0;
	  		for(Catalog c:(List<Catalog>)request.getAttribute("catalogs")){
  		%>
  		<li class="list-group-item"><a href="index?cid=<%=c.getCid()%>" class="btn btn-default" data-type="cid"><%=c.getCname() %><span class="badge"><%=catalogSize[i]%></span></a></li>
  		<%
  				i++;
  			}
  		%>
    </ul>
  </div>
</div>
</div>

<div class="container">	
	<div class="row">
		<div class="col-xs-12 ">
			<div class="panel panel-default ">
				<div class="panel-heading">
					<h3 class="panel-title">
						更新日志<a href="log"><span class="label label-default">ALL</span></a>
					</h3>
				</div>
				<%
				UpdateLog updateLog = (UpdateLog)request.getAttribute("updateLog");
				%>
				<div class="panel-body">
					<%=updateLog.getInfo() %>
				</div>
				<div class="panel-footer">
					<small><%=DateFormat.dateToString(updateLog.getCtime()) %></small>
				</div>
			</div>
		</div> 
		<div class="col-xs-12">
		
			
				
				
			<div class="panel panel-default">	
				<h3 class="well" style="margin-top:0px">帖子详情
						<button class="btn btn-default btn-sm pull-right" 
								 data-type="reply">
								      		我也说一句
						</button>
				</h3>
		 		
					<!-- <div class="row"> -->
				<div class="container-fluid">
						 <%
					  		Object objects = request.getAttribute("items");
						    List<Map<String,Object>> items = (List<Map<String,Object>>)objects;
						    int rid = 0;
						    String title = "";
						    Object obj = request.getAttribute("topic");
						    if(null != obj){
						    	title = ((Topic)obj).getTname();
						    }
					  		if(items.size() > 0){
					  			Reply temp = (Reply)items.get(0).get("floor");
					  			rid = temp.getRid();
					  		}
					  		for(Map<String,Object> m:items){
					  		Reply r = ((Reply)m.get("floor"));
					  		%>
					  			<!--楼层内容-->
					  	<div class="row">
							    <div class="col-xs-12 col-lg-1">
							
								        <p class="text-center"><img class="img-circle" src="<%=r.getUser().getUface()%>" title="<%=r.getUser().getUname()%>" style="max-width:50px;max-height:50px"></p>
								        <a href="#">
								        	<p class="text-center"><%=r.getUser().getUname() %></p>
								        </a>
							      
							    </div>
								
							    <div class="col-xs-12 col-lg-11" style="overflow:hidden">
							      <div class="well"><%=r.getContent()%></div>
							      <div style="overflow:auto;text-align:right;width:100%">
							      
							      	<button class="btn btn-default btn-sm align-right" 
							      			data-toggle="<%=r.getRid()%>" data-id="<%=r.getRid()%>" data-type="reply">
							      		回复
							      	</button>
								  </div>
								  <small><%=DateFormat.dateToString(r.getRtime())%></small>
								  <hr/>
								  <table class="table table-hover table-striped table-condensed">
							      <% 
							  		List<Reply> replys = (List<Reply>)m.get("reply");
							  		for(Reply reply:replys){
								  %>
									<!-- <div class="media"> -->
							    		<%-- <div class="media-left">
                                            
                                            <div class="media-object" style="width:50px">
                                                <a href="#">
                                                    <img src="<%=r.getUser().getUface()%>" style="max-width:50px;max-height:50px">
                                                </a>
                                            </div>
                                            
                                        </div> --%>
							    		<%-- <div class="media-body">
								      		<h4 class="media-heading">
								      		    <img src="<%=r.getUser().getUface()%>" style="max-width:50px;max-height:50px">
									      		<%=reply.getUser().getUname()%>
												<%=reply.getPuser().getUid() == r.getUser().getUid() || reply.getUser().getUid() ==  reply.getPuser().getUid() ? ":":"回复："+reply.getPuser().getUname() %>
											</h4>
											<div style="padding:10px"><%=reply.getContent()%></div>
											<div >
							      				<div class="btn btn-default btn-sm"  style="float:right"
							      				data-toggle="<%=r.getRid()%>" data-id="<%=reply.getRid()%>" data-type="reply">
							      					回复
							      				</div>
											     <small class="text-right" style="float:right;line-height: 300%"><%=DateFormat.dateToString(reply.getRtime())%></small>
								  			</div>
							    		</div> --%>
							    		
							    		
										   <tr>
										    <td rowspan="2" width="50px"><img class="img-circle"  src="<%=reply.getUser().getUface()%>" title="<%=reply.getUser().getUname()%>" style="max-width:50px;max-height:50px"></td>
										    <td>
										      <strong>
										        <%=reply.getUser().getUname()%>
                                                <%=reply.getPuser().getUid() == r.getUser().getUid() || reply.getUser().getUid() ==  reply.getPuser().getUid() ? ":":"回复："+reply.getPuser().getUname() %>
                                             </strong>
                                                <%=reply.getContent()%>
                                            </td>
										  </tr>
										  <tr>
										    <td>
										      <div class="btn btn-default btn-sm"  style="float:right"
                                                data-toggle="<%=r.getRid()%>" data-id="<%=reply.getRid()%>" data-type="reply">
                                                                                                                                                                                 回复
                                                </div>
                                                 <small class="text-right" style="float:right;line-height: 300%"><%=DateFormat.dateToString(reply.getRtime())%></small>
										    </td>
										  </tr>
										
							    		
							  		<!-- </div> -->
							  		<%} %>
							  		</table>
							  		
							  		
							  		<div class="form-container" data-toggle="<%=r.getRid()%>" data-visible="hidden" style="height:0px;">
								  		<form action="publish!publishReply" method="post" class="form-inline">
									  		<input type="hidden" name="pid" value="0"/>
									  		<input type="hidden" name="floor" value="0"/>
									  		<input type="hidden" name="tid" value="<%=request.getAttribute("tid")%>"/>
					    	
											<div class="form-group" >
											    <label for="inputEmail3" class="sr-only">内容</label>
											    <div class="col-sm-4">
											      <input type="text" name="content" class="form-control" id="inputEmail3" placeholder="请输入要发送的内容" required>
											    </div>
											    <div class="col-sm-offset-4 col-sm-1">
											      <button type="submit" class="btn btn-default">回复</button>
											    </div>
											  </div>
					    				</form>
				    				</div>
							  		
							  		
							  		
							    </div>
							    
						</div>
							    <!--li  -->
					  		<hr class="divider" />
					 		<% 
					 		}
					 		%>
				</div>
					 		<!-- ul -->
						<!-- </div> -->
				
				  <ul class="pager">
				    <li class="previous"><a href="javascript:void(0)">上一页</a></li>
				    <%
				        int index = Integer.parseInt(request.getAttribute("index")+"");
				        index = index<=0?1:index;
				    %>
				    <li class="text-center"><%=index%>/<%=request.getAttribute("maxPageSize") %></li>
				    <li class="next"><a href="javascript:void(0)">下一页</a></li>
				  </ul>
			
			</div><!--wraper-->
		
		</div>
	</div>
</div>


<div class="container" data-type="reply">
	<div class="row">
		<div class="col-md-12 column">
			<form action="publish!publishReply" method="post">
				<input type="hidden" name="pid" value="<%=rid%>"/>
				<input type="hidden" name="floor" value="1"/>
				<input type="hidden" name="tid" value="<%=request.getAttribute("tid")%>"/>
				<input type="hidden" name="index" value="<%=index%>"/>
				<h4><strong>回复</strong></h4>
				<div class="form-group">
					 <!-- <input type="text" class="form-control" name="content" placeholder="请输入要回复的内容" /> -->
					 <textarea id="ckeditor" name="content" class="form-control" placeholder="说点什么吧" required="required"></textarea>
				</div>
				<button type="submit" class="btn btn-default" data-type="main-reply">回复</button>
			</form>
		</div> 
				
	</div>
</div>

<%@include file="footer.jsp"%>





  	<script type="text/javascript" src="js/jquery.min.js"></script>
  	<script src="js/bootstrap.min.js"></script>
  	<script type="text/javascript" src="js/imageviewer.js"></script>
  	<script type="text/javascript" src="js/alertutil.js"></script>
  	<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
  	<script type="text/javascript" src="highlight/highlight.pack.js"></script>
  	<script type="text/javascript">
  	$("pre code").each(function(i,ele){
        hljs.highlightBlock(ele);
    })
  	</script>
  	<script type="text/javascript">
		$(function(){
			var maxPage = <%=request.getAttribute("maxPageSize") %>;
			var index = <%=index %>;
			var cid = <%=request.getAttribute("cid")%>;
			var tid = <%=request.getAttribute("tid")%>;
			var user = <%=session.getAttribute(LoginAndRegAction.USER_IN_SESSION) == null%>;
			var title = '<%=title%>';
			if("" != title){
				document.title = title;
			}
			var editor = CKEDITOR.replace( 'ckeditor');
			$("a.btn.btn-default[data-type='cid']").eq(cid-1).addClass("active");
			if(index <= 1 ){
				$(".previous").addClass("disabled");
			}else{
				$(".previous").click(function(){
					index--;
					window.location.href = "detail?index=" + index + "&tid=" + tid;
				})	
			}
			
			if(index >= maxPage){
				$(".next").addClass("disabled");
			}else{
				$(".next").click(function(){
					index++;
                    window.location.href = "detail?index=" + index + "&tid=" + tid;
				})
			}
			
			$(".btn.btn-default.btn-sm.pull-right[data-type='reply']").click(function(){
				var id = $(this).attr("data-id");
				var form = $(".container[data-type='reply']");
				var targetTop = form.offset().top;
				console.log(targetTop);

				$("body").animate({scrollTop:targetTop-100},1000);
				editor.focus();
			});
			
			$(".btn.btn-default.btn-sm[data-type='reply']").click(function(){
				console.log('click');
				var btn = $(this);
				var dataToggle = btn.attr("data-toggle");
				var form = $(".form-container[data-toggle='"+dataToggle+"']");
				var dataVisible = form.attr("data-visible");
				if("visible" == dataVisible){
					form.animate({
	                    'height':'0px'
	                },300);
					form.attr("data-visible","hidden");
					return false;
				}
				form.attr("data-visible","visible");
				
				var dataId = btn.attr("data-id");
				console.log(dataToggle+' '+dataId);
				form.animate({
					'height':'60px'
				},300);
				var targetTop = form.offset().top;
				console.log(targetTop);

				$("body").animate({scrollTop:targetTop-100},1000);
				//form.css('display','block');
				var input = form.find("input[name='pid']");
				input.val(dataId);
				form.find("input[name='content']").focus();
			})
			
			
			$("button[type='submit'][data-type='main-reply']").click(function(event){
                event.preventDefault();
                console.log(editor);
                if(user){
                    alertModalWithOption('请先登录',function(){
                        window.location.href= 'login.jsp';
                    })
                }else{
                    if(editor.getData() == ''){
                        alertModal('输入不能为空');
                    }else{
                       $("form").submit();
                    }
                }
                return true;
            })
		})
	</script>
  </body>
</html>
