<%@ page language="java"
	import="java.util.*,com.bbs.model.*,com.bbs.tool.*"
	pageEncoding="utf-8"%>
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
<link href="css/cropper.css" rel="stylesheet">
<!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
<style type="text/css">
body {
	padding-top: 100px;
}
</style>
</head>

<body>
	<%@include file="header.jsp"%>

	<div class="container" style="height:300px">
		<button id="select-file" class="btn btn-default">选择图片</button>
		<input type="file" class="sr-only" accept=".jpg,.jpeg,.png,.gif,.bmp,.tiff">
		<button id="btn" class="btn btn-primary">保存并上传</button>
		<img src="" class="sr-only" id="img-change">
	</div>



	<%@include file="footer.jsp"%>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/cropper.js"></script>
	<script type="text/javascript" src="js/uploadface.js"></script>
	<script type="text/javascript" src="js/alertutil.js"></script>
	<script type="text/javascript">
	   initUpload("#select-file","input[type='file']","#img-change","#btn")
    </script>

</body>
</html>
