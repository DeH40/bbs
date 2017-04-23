<%@page import="com.bbs.action.LoginAndRegAction"%>
<%@ page language="java" import="java.util.*,com.bbs.model.*,com.bbs.tool.*" pageEncoding="utf-8"%>
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
		<!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
	
	<style type="text/css">
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
<!--
	作者：2608027102@qq.com
	时间：2017-03-07
	描述：主内容
-->

<div class="container">
	<div class="row row-fluid">
		<div class="col-md-3">
		
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
			
		</div>
		<div class="col-md-9">
		<!-- 主内容 -->
				<div class="list-group">
					 <div class="list-group-item">
								帖子列表
					 </div>
			 
			
					<div class="list-group-item">
						<table class="table table-striped table-bordered table-hover">
							<tbody>
							<%
						  		int[] topicSize = (int[])request.getAttribute("topicSize");
						  		i = 0;
				  			%>
					  		<%
					  			for(Topic t:(List<Topic>)request.getAttribute("tops")){
					  		%>
				  			<tr >
									<td rowspan="2" width="50px">
									<img src="<%=t.getUser().getUface() %>" class="img-circle" style="max-width:50px;max-height:50px" title="<%=t.getUser().getUname()%>">
									</td>
									<td><span class="label label-danger">Top</span><a href="detail?tid=<%=t.getTid()%>"><%=t.getTname()%><span class="badge"><%=topicSize[i] %></span></a></td>
							</tr>
							<tr >
								<td class="text-right"><small><%=DateFormat.dateToString(t.getCtime())%>  <%=t.getUser().getUname() %></small>
								<%if(authority){ %>
                                    <button class="btn btn-danger btn-xs" 
                                        data-id="<%=t.getTid() %>" data-type="delete">
                                                                                                                        删除
                                    </button>
                                    <%} %>
								</td>
							</tr>
					  		<%
					  		i++;
					  		}%>
							<%
				  			for(Topic t:(List<Topic>)request.getAttribute("topics")){%>
				  			<tr >
									<td rowspan="2" width="50px">
                                        <img src="<%=t.getUser().getUface() %>" style="max-width:50px;max-height:50px" class="img-circle" >    
                                    </td>
									<td><a href="detail?tid=<%=t.getTid()%>"><%=t.getTname()%><span class="badge"><%=topicSize[i] %></span></a></td>
							</tr>
							<tr >
								<td class="text-right"><small><%=DateFormat.dateToString(t.getCtime())%>   ：<%=t.getUser().getUname() %></small>
								
								<%if(authority){ %>
								    <button class="btn btn-danger btn-xs" 
                                        data-id="<%=t.getTid() %>" data-type="delete">
                                                                                                                        删除
                                    </button>
                                    <%} %>
								</td>
							</tr>
					  		<%
					  		i++;
					  		}%>
							</tbody>
						</table>
						
						
						<!-- pagination start -->
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
            <!-- pagenation end -->
						
					</div>
		
			</div><!--  list-group -->
				    
		</div><!-- span8 -->
	</div>
</div><!--  container-fluid -->


<div class="container">
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">
			发帖
		</h3>
	</div>
	<div class="panel-body">
		<form role="form" action="publish!publishTopic" method="post">
		<input type="hidden"  value="<%=request.getAttribute("cid")%>" name="cid"/>
			<div class="form-group has-feedback">
				 <label for="exampleInputEmail1">标题</label>
				 <input type="text" name="title" class="form-control" id="exampleInputEmail1" required/>
			</div>
			<div class="form-group has-feedback">
				 <label for="exampleInputPassword1">内容</label>
				 <textarea id="ckeditor" name="content" class="form-control" placeholder="说点什么吧" required="required">说点什么吧</textarea>
				 
				 <!-- <input type="text" name="content" class="form-control" id="exampleInputPassword1" required/> -->
			</div>
			<button type="submit" class="btn btn-primary">发布主题</button>
		</form>
	</div>
</div>
</div>








<%@include file="footer.jsp"%>





  	<script type="text/javascript" src="js/jquery.min.js"></script>
  	<script src="js/bootstrap.min.js"></script>
  	<script type="text/javascript" src="js/alertutil.js"></script>
  	<script type="text/javascript" src="js/imageviewer.js"></script>
  	<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
  	<script type="text/javascript" src="js/pagination.js"></script>
  	<script type="text/javascript" src="js/search.js"></script>
  	<script type="text/javascript">
		$(function(){
			var maxPage = <%=request.getAttribute("maxPageSize") %>;
			var user = <%=session.getAttribute(LoginAndRegAction.USER_IN_SESSION) == null%>;
			var index = <%=request.getAttribute("index") %>;
			var cid = <%=request.getAttribute("cid")%>;
            
		    $("a.btn.btn-default[data-type='cid']").eq(cid-1).addClass("btn-primary");
            var editor = CKEDITOR.replace( 'ckeditor');
		    //分页
			/* if(index <= 1 ){
				$(".previous").addClass("disabled");
			}else{
				$(".previous").click(function(){
					index--;
					window.location.href = "index?index=" + index;
				})	
			}
			
			if(index >= maxPage){
				$(".next").addClass("disabled");
			}else{
				$(".next").click(function(){
					index++;
					window.location.href = "index?index=" + index;
				})
			} */
			
          //分页
          var clientWidth = document.body.clientWidth;
            var split = 10;
            if(clientWidth <= 512){
                split = 5;
            }
            var prefix = "index?index=";
            console.log(index + " " + maxPage);
            //选择器，当前页码，总页数，每行显示页数，链接前缀
            paginationInit(".pagination",index,maxPage,split,prefix);
            jumpInit("#go","#jumpInput",prefix);
			
			$("button.btn.btn-primary[type='submit']").click(function(event){
				event.preventDefault();
				if(user){
					alertModalWithOption('请先登录',function(){
	                    window.location.href= 'login.jsp';
	                })
				}else{
					if($("#exampleInputEmail1").val() == '' || editor.getData() == ''){
						alertModal('输入不能为空');
					}else{
					   $("form").submit();
				    }
				}
				return true;
			})
			
			<%
            //删除
            if(authority){%>
            
            function deleteTopic(tid){
            	$.post("manage!deleteTopic",{'tid':tid},function(data,status){
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
                var tid = btn.attr('data-id');
                alertModalFullOption("确定删除？此操作不可逆",function(){
                	deleteTopic(tid);
                },'警告','容我三思','我确定','md');
            });
            
            <%}%>
		})
		
		
	</script>
	<%@include file="popover.jsp"%>
  </body>
</html>
