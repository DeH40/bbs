<%@ page language="java" import="java.util.*,com.bbs.model.*,com.bbs.tool.*,com.bbs.action.LogAction" pageEncoding="utf-8"%>
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
        .my-row-item{
        	float: left;
        	min-width: 150px;
        	position: relative;
        }
		/* clearfix */
		.my-row-item:after {
		  content: '';
		  display: block;
		  clear: both;
		}
    </style>
  </head>
  
  <body>
	<%@include file="header.jsp"%>
	<%
	   List<UpdateLog> logs = (List<UpdateLog>)request.getAttribute(LogAction.LOG_IN_REQUEST);
	 %>

<div class="container" data-masonry='{ "itemSelector": ".my-row-item","columnWidth":100}'>
<%
int i = 0;
for(UpdateLog log:logs){
 %>
<div class="my-row-item">
    <div class='panel panel-<%=(i==0?"primary":"default")%>'>
         <div class="panel-heading">
             <h3 class="panel-title">
                 更新日志
             </h3>
         </div>
         <div class="panel-body">
             <%= log.getInfo()%>
         </div>
         <div class="panel-footer">
             <small><%=DateFormat.dateToString(log.getCtime()) %></small>
         </div>
     </div>
</div>
<%
i++;
} %>

</div>
	<%@include file="footer.jsp"%>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
    <!-- <script>
		$(function(){
			$('.container').masonry({
			  // options
			  itemSelector: '.my-row-item',
			  columnWidth: 100,
			  percentPosition: true,
			  horizontalOrder: true
			});
		})
	</script> -->
	<script type="text/javascript" src="js/search.js"></script>
  </body>
</html>
