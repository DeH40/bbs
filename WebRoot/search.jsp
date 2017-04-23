<%@ page language="java" import="java.util.*,com.bbs.model.*,com.bbs.tool.*,com.bbs.action.GetMessageAction" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
    <head>
    <base href="<%=basePath%>">
    <title>搜索</title>
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


    <div class="container">
        <div class="panel panel-default">
           <div class="panel-heading">
              <h3 class="panel-title">
                                                               搜索结果
              </h3>
          </div>
          <div class="panel-body">
	        <div class="list-group">
			  <%List<Reply> replys = (List<Reply>)request.getAttribute("replys");
			  
			    if(replys == null || replys.size() <= 0){
			  %>
				    <a href="javascript:void(0)" class="list-group-item">你想搜点啥？</a>
		      <%}else{ %>
			  
				  <%
				  for(Reply r:replys){
					  String containsImg = r.getContent().contains("<img")?"【图片】":"";
		              String msg = containsImg + HTMLUtil.delHTMLTag(r.getContent(), 225);
				  %>
				  <a href="detail?tid=<%=r.getTid()%>" class="list-group-item">
				  <p><strong><%=r.getUser().getUname() %>：</strong><%=msg %></p>
				  <small><%=DateFormat.dateToString(r.getRtime()) %></small>
				  </a>
				  
				  <%} 
			  }%>
			</div>
		  </div>
		  
		  
		  <!-- pagination start -->
		  <!-- <div class="panel panel-default"> -->
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
           <!--  </div> -->
            
            <!-- pagenation end -->
		</div>
		
		
    </div>

 <%
    int index = Integer.parseInt(request.getAttribute("index")+"");
    index = index<=0?1:index;
    int maxPageSize = Integer.parseInt(request.getAttribute("maxPageSize")+"");
    String query = request.getAttribute("query") + "";
%>

	<%@include file="footer.jsp"%>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/pagination.js"></script>
    <script type="text/javascript" src="js/search.js"></script>
    <script type="text/javascript">
    $(function(){
    	var query = '<%=query%>';
    	var index = <%=index%>;
    	var maxPage = <%=maxPageSize%>;
    	console.log('------------------')
    	console.log(query);
    	console.log(index);
    	console.log(maxPage);
    	console.log('------------------')
    	//分页
    	var clientWidth = document.body.clientWidth;
        var split = 10;
        if(clientWidth <= 512){
            split = 5;
        }
        var prefix = "search?pageSize=5&query=" + query + "&index=";
      //选择器，当前页码，总页数，每行显示页数，链接前缀
       paginationInit(".pagination",index,maxPage,split,prefix);
       jumpInit("#go","#jumpInput",prefix);
       
       
       
       
      
    })
    </script>
    
    <%@include file="popover.jsp"%>
    
  </body>
</html>
