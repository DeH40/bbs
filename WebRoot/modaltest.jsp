<%@ page language="java" import="java.util.*,com.bbs.model.*,com.bbs.tool.*" pageEncoding="utf-8"%>
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
            padding-top:100px;
        }
    </style>
  </head>
  
  <body>
	<%@include file="header.jsp"%>

<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<p>xczcxz</p>
<div class="btn btn-danger" id="zxczxc">click</div>
	<%@include file="footer.jsp"%>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/alertutil.js"></script>
    <script type="text/javascript">
   var toggle = true;
        $("#zxczxc").click(function(){
        if(toggle){
	        alertModalFullOption(new Date() ,function(){
	           console.log(new Date());
	        },'title','cancel','ok','sm');
	        
	        toggle = false;
	    }else{
	    
	    alertModalFullOption(new Date() ,null,'title','cancel','ok','lg');
	    toggle = true;
	    }
        
        })
    </script>
  </body>
</html>
