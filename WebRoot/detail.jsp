<%@page language="java" import="java.util.*,com.bbs.service.*,org.springframework.context.ApplicationContext,com.bbs.model.*,com.bbs.tool.*" pageEncoding="utf-8"%>
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
	<link rel="stylesheet" type="text/css" href="highlight/styles/dark.css"/> 
	
	<!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
	
	<style>
	body{
		padding-top:70px;
	}
	 #background{
            position:fixed;
            width:100%;
            height:100%;
            z-index:-1;
            margin-top:-70px;
        }
        #background img{
            width:100%;
            height:100%;
                        
        }
	</style>
	
	
  </head>
  
  <body>
  <%@include file="header.jsp"%>
  <%
//权限认证
boolean authority = (user != null && user.getUgroup().getAuthority() == 1);
%>
<!--
	catalog start
-->
<div class="container">
	<div class="panel panel-default ">
	  <div class="panel-heading">
	    <h3 class="panel-title">帖子分类</h3>
	  </div>
	  <div class="panel-body">
	  <%
            int[] catalogSize = (int[])request.getAttribute("catalogSize");
            int i = 0;
            for(Catalog c:(List<Catalog>)request.getAttribute("catalogs")){
        %>
	    
		  		<a href="index?cid=<%=c.getCid()%>" class="btn btn-default" data-type="cid">
                    <%=c.getCname() %>
		  			<span class="badge"><%=c.getCsize() %></span>
		  		</a>
	  		
	  	<%
                i++;
            }
        %>
	  	
	  </div>
	</div>
</div>
<!-- catalog end -->

<div class="container">	
	<div class="row">
	<!-- updatelog start -->
		<!-- <div class="col-xs-12 ">
			<div class="panel panel-default ">
				<div class="panel-heading">
					<h3 class="panel-title">
						更新日志
						<a href="log"><span class="label label-primary pull-right">ALL</span></a>
					</h3>
				</div>
				<%
                UpdateLog updateLog = (UpdateLog)request.getAttribute("updateLog");
                %>
				<div class="panel-body">
					<%=updateLog.getInfo() %>
				</div>
				<div class="panel-footer">
					<small><%=DateFormat.dateToString(updateLog.getCtime()) %></small>
				</div>
			</div>
		</div>  -->
		<!-- updatelog end -->
		<!-- detail start -->
		<div class="col-xs-12">	
			<div class="panel panel-default">	
				<h3 class="well" style="margin-top:0px">帖子详情
						<button class="btn btn-default btn-sm pull-right" 
								data-type="host-only">
								只看楼主
						</button>
						<button class="btn btn-default btn-sm pull-right" 
								data-type="reply">
								我也说一句
						</button>
				</h3>
				<div class="container-fluid">
		 		<!-- 主楼脚本开始 -->
					<%
                            Object objects = request.getAttribute("items");
                            List<Map<String,Object>> items = (List<Map<String,Object>>)objects;
                            int rid = 0;
                            String title = "";
                            Object obj = request.getAttribute("topic");
                            if(null != obj){
                                title = ((Topic)obj).getTname();
                            }
                            int uid =((Topic)obj).getUser().getUid();
                            if(items.size() > 0){
                                Reply temp = (Reply)items.get(0).get("floor");
                                rid = temp.getRid();
                            }
                            for(Map<String,Object> m:items){
                            Reply r = ((Reply)m.get("floor"));
                      %>
					<div class="row">
						<div class="col-xs-12 col-lg-1">
							<p class="text-center"><img class="img-circle" src="<%=r.getUser().getUface()%>" title="<%=r.getUser().getUname()%>" style="max-width:50px;max-height:50px"></p>
							<%if(r.getUser().getUid() == r.getPuser().getUid() ){ %>
							<p class="text-center text-danger"><small>楼主</small></p>
							<%} %>
							<p class="text-center"><a href="#"><%=r.getUser().getUname() %></a></p>
						</div>
								
						<div class="col-xs-12 col-lg-11">
							<div class="well"><%=r.getContent()%></div>
							<div class="text-right">
						      	<button class="btn btn-default btn-xs" 
						      			data-toggle="<%=r.getRid()%>" data-id="<%=r.getRid()%>" data-type="reply">
						      		回复
						      	</button>
						      	<%
						      	//权限认证
						      	if(authority){
						          %>
						      	<button class="btn btn-danger btn-xs" 
						      			data-toggle="<%=r.getRid()%>" data-id="<%=r.getRid()%>" data-type="delete">
						      		删除
						      	</button>
						      	<%} %>
							</div>
							<small><%=DateFormat.dateToString(r.getRtime())%></small>
							<hr class="divider"/>
							<table class="table table-hover table-striped table-condensed table-bordered">		
							<!-- 子楼脚本开始-->
							<% 
                                    List<Reply> replys = (List<Reply>)m.get("reply");
                                    for(Reply reply:replys){
                                  %>
								<tr>
									<td rowspan="2" width="50px"><img class="img-circle"  src="<%=reply.getUser().getUface()%>" title="<%=reply.getUser().getUname()%>" style="max-width:50px;max-height:50px"></td>
									<td>
										<strong><%=reply.getUser().getUname()%>
                                                <%=reply.getPuser().getUid() == r.getUser().getUid() || reply.getUser().getUid() ==  reply.getPuser().getUid() ? ":":"回复："+reply.getPuser().getUname() %></strong>
                                    <%=reply.getContent()%>
                                    </td>
								</tr>
								<tr>
									<td class="text-right">
										<small class="text-right" ><%=DateFormat.dateToString(reply.getRtime())%></small>
										<button class="btn btn-default btn-xs"  
                                                data-toggle="<%=r.getRid()%>" data-id="<%=reply.getRid()%>" data-type="reply">
                                                                                                                                                回复
                                        </button>
                                        <%
			                                //权限认证
			                                if(authority){
		                                  %>
                                        <button class="btn btn-danger btn-xs"  
                                                data-id="<%=reply.getRid()%>" data-type="delete">
                                                                                                                                                删除
                                        </button>
                                        <%} %>
									</td>
								</tr>
							<!-- 主楼脚本结束 -->
							<%} %>
							</table>	
							<div class="form-container hidden" data-toggle="<%=r.getRid()%>" data-type="talk-form" >
								<div class="form-group" >
								  		<form action="publish!publishReply" method="post" class="form-inline">
									  		<input type="hidden" name="pid" value="0"/>
									  		<input type="hidden" name="floor" value="0"/>
									  		<input type="hidden" name="tid" value="<%=request.getAttribute("tid")%>"/>
											<label for="inputEmail3" class="sr-only">内容</label>
									    	<div class="input-group">
									    		<div class="input input-group-addon"><span class="glyphicon glyphicon-send"></span></div>
										      	<input type="text" name="content" class="form-control" id="inputEmail3" placeholder="请输入要发送的内容" required>
										    </div>
											<button type="submit" class="btn btn-default">回复</button>   
					    				</form>
				    			</div>
							</div>
						</div>
							    
					</div>
					<hr class="divider" />		
					<%} %>
				<!-- 主楼脚本结束 -->
				</div>
				<!-- pagination start -->
			<!-- <div class="panel"> -->
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-2">
					    	<div class="input-group">
					    		<div class="input input-group-addon"><span class="glyphicon glyphicon-share-alt"></span></div>
						      	<input type="text" id="jumpInput" class="form-control" id="inputEmail3" placeholder="跳页" required>
						    </div>
						</div>
						<div class="col-md-1">
							<button class="btn btn-default btn-block" id="go">GO</button>  
						</div>

						<!-- <div class="clearfix visible-xs-block"></div> -->

						<div class="col-md-9">
							<nav aria-label="Page navigation" class="text-right">
						    	<ul class="pagination" style="margin: 0px;padding: 0px">
						    		<li title="首页">
						    			<a href="javascript:void(0)" ><span>首页</span></a>
						    		</li>
						    		<li class="previous" title="上一页">
						    			<a href="javascript:void(0)" ><span>&laquo;</span></a>
						    		</li>
						    		
						    		<li class="next" title="下一页">
						    			<a href="javascript:void(0)" ><span>&raquo;</span></a>
						    		</li>
						    		<li title="尾页">
						    			<a href="javascript:void(0)" ><span>尾页</span></a>
						    		</li>
						    	</ul>
						    </nav>
						</div>
	    			</div>
				</div>
			<!-- </div> -->
			
			<!-- pagenation end -->
				
			</div><!--wraper-->
		
		</div>
		
		<!-- detail end -->
	</div>
</div>
 <%
    int index = Integer.parseInt(request.getAttribute("index")+"");
    index = index<=0?1:index;
%>

<div class="container" data-type="reply">
	<div class="panel panel-default">
		<div class="row">
			<div class="col-md-12 column">
				<form action="publish!publishReply" method="post">
					<input type="hidden" name="pid" value="<%=rid%>"/>
					<input type="hidden" name="floor" value="1"/>
					<input type="hidden" name="tid" value="<%=request.getAttribute("tid")%>"/>
					<input type="hidden" name="index" value="<%=index%>"/>
					<h4 class="well" style="margin:0px"><strong>回复</strong></h4>
					<div class="form-group">
						 <textarea id="ckeditor" name="content" class="form-control" placeholder="说点什么吧" required="required"></textarea>
					</div>
					<div class="text-right">
						<button type="submit" class="btn btn-primary" data-type="main-reply">回复</button>
					</div>
				</form>
			</div> 
					
		</div>
	</div>
</div>


<%@include file="footer.jsp"%>


  	<script type="text/javascript" src="js/jquery.min.js"></script>
  	<script type="text/javascript" src="js/bootstrap.min.js"></script>
  	<script type="text/javascript" src="highlight/highlight.pack.js"></script>
  	<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
  	<script type="text/javascript" src="js/imageviewer.js"></script>
  	<script type="text/javascript" src="js/alertutil.js"></script>
  	<script type="text/javascript" src="js/pagination.js"></script>
  	<!-- <script src="js/bg.vendors.js"></script> -->
  	<script type="text/javascript" src="js/search.js"></script>
	
  	<script type="text/javascript">
	  	//highlight
	  	$("pre code").each(function(i,ele){
	        hljs.highlightBlock(ele);
	    })
	    var clientHeight = document.body.clientHeight;
	    var clientWidth = document.body.clientWidth;
	    
  	</script>
  	<script type="text/javascript">
		$(function(){
			var maxPage = <%=request.getAttribute("maxPageSize") %>;
            var index = <%=index %>;
            var uid = <%=uid%>;
            var cid = <%=request.getAttribute("cid")%>;
            var tid = <%=request.getAttribute("tid")%>;
            var user = <%= user == null%>;
            var title = '<%=title%>';
            if("" != title){
                document.title = title;
            }
			//ckeditor
			var editor = CKEDITOR.replace( 'ckeditor');

			//分页
			var split = 10;
		    if(clientWidth <= 512){
		    	split = 5;
		    }
		    var prefix = "detail?tid=" + tid + "&index=";
		    //选择器，当前页码，总页数，每行显示页数，链接前缀
		    paginationInit(".pagination",index,maxPage,split,prefix);
		    jumpInit("#go","#jumpInput",prefix);

	    //分类按钮
			$("a.btn.btn-default[data-type='cid']").eq(cid-1).addClass("btn-primary");
			
			//帖子回复按钮
			$(".btn.btn-default.pull-right[data-type='reply']").click(function(){
				var id = $(this).attr("data-id");
				var form = $(".container[data-type='reply']");
				var targetTop = form.offset().top;
				console.log(targetTop);
				$("body").animate({scrollTop:targetTop},500);
				editor.focus();
			});
			
			//只看楼主
			$(".btn.btn-default.pull-right[data-type='host-only']").click(function(){
				window.location.href = 'detail?index=' + index + "&tid=" + tid +"&hostOnly=true&uid=" + uid;
				console.log('detail?index=' + index + "&tid=" + tid +"&hostOnly=true&uid=" + uid)
			});
			
			//楼层回复按钮
			$(".btn.btn-default[data-type='reply']").click(function(){
				console.log('click');
				var btn = $(this);
				var dataToggle = btn.attr("data-toggle");				

				//formContainer 当前是否可见
				var formContainer = $("div.form-container[data-type='talk-form'][data-toggle='"+dataToggle+"']");
				//formContainer 当前可见  则隐藏
				if(!formContainer.hasClass("hidden")){
					formContainer.addClass("hidden");
					return true;
				}
				//formContainer 当前不可见  则显示
				formContainer.removeClass("hidden");

				var dataId = btn.attr("data-id");
				console.log(dataToggle+' '+dataId);
				var targetTop = formContainer.offset().top;
				
				console.log("targetTop" + targetTop);
				console.log("clientHeight" + clientHeight);
				//让input  显示在屏幕中央
				$("body").animate({scrollTop:targetTop-clientHeight/4},500);
				var input = formContainer.find("input[name='pid']");
				input.val(dataId);
				formContainer.find("input[name='content']").focus();
			})
			
			//
			$("button[type='submit'][data-type='main-reply']").click(function(event){
                event.preventDefault();
                console.log(editor);
                if(user){
                    alertModalWithOption('请先登录',function(){
                        window.location.href= 'login.jsp';
                    })
                }else{
                    if(editor.getData() == ''){
                        alertModal('说点什么吧');
                    }else{
                       $("form").submit();
                    }
                }
                return true;
            })
            <%
            //删除
            if(authority){
            %>
            function deleteReply(rid){
            	$.post("manage!deleteReply",{'rid':rid},function(data,status){
            		console.log(data)
            		if(data.code == 'success'){
            			window.location.reload();
            		}else if(data.code == 'param error'){
            			alertModal('参数错误');
            		}else if(data.code == 'permission denied'){
            			alertModal('没有权限');
            		}
            	},'json');
            }
            $("button.btn.btn-danger.btn-xs[data-type='delete']").click(function(){
            	var btn = $(this);
            	var rid = btn.attr('data-id');
            	alertModalFullOption("确定删除？此操作不可逆",function(){
                    deleteReply(rid);
                },'警告','容我三思','我确定','md');
            })
            <%
            }
            %>
		})
	</script>
	<%@include file="popover.jsp"%>
  </body>
</html>
