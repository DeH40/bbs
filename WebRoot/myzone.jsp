<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html lang="zh-CN">
  <head >
    <base href="<%=basePath%>">
    
    <title>个人中心</title>
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
        body{
            padding-top:70px
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
        #imgCode:hover{
            cursor:pointer
        }
        .mycontainer{
              width:50%;
         }
        /**ipad**/
        @media only screen (max-width:1024px){
        .mycontainer{
              width:70%;
          }
        }
        /**iphone**/
         @media only screen and (max-width:768px){
          .mycontainer{
                 width:90%;
             }
         }
    </style>
  </head>
  
  <body>
 <%@include file="header.jsp" %>

	 <div class="container mycontainer">
     <div class="row">
	     <div class="col-md-4">
            <button id="select-file" class="btn btn-default">修改头像</button>
               <input type="file" class="sr-only" accept=".jpg,.jpeg,.png,.gif,.bmp">
               <button id="btn" class="btn btn-primary">保存并上传</button>
		     <p><img src="<%=user.getUface()%>"  style="max-width:200px;" class="img-circle" ></p>
		     
	     </div>
		<div class="col-md-8">
			<h1>欢迎您:<%=user.getUname() %></h1>
		     <h2>性别:<%=user.getGenderString() %></h2>
		     <p>个人介绍:<%=user.getUintro() %></p>
		</div>
	     <div class="col-md-12">
		        <div>
		          <img src="" class="sr-only" id="img-change">
		        </div>
	    </div>
    </div>
	</div>
     <hr class="divider">
     
     <div class="container">
     <h2>修改密码</h2>
    <form role="form" action="rl!login" method="post">
          
          <div class="form-group has-feedback">
            <label for="exampleInputPassword">旧密码</label>
            <input type="password" class="form-control" id="exampleInputPassword" placeholder="确认密码" required name="opasswd"
            pattern="[\S]{6,10}">
          </div>
          
          <div class="form-group has-feedback">
            <label for="exampleInputPassword1">新密码</label>
            <input type="password" class="form-control" id="exampleInputPassword1" placeholder="旧密码" required name="upasswd"
            pattern="[\S]{6,10}">
          </div>
          
          <div class="form-group has-feedback">
            <label for="exampleInputPassword2">确认密码</label>
            <input type="password" class="form-control" id="exampleInputPassword2" placeholder="确认密码" required name="rpasswd"
            pattern="[\S]{6,10}">
          </div>
          
          <div class="form-group">

                <input type="submit" class="btn btn-default" value="确认修改"/>

            </div>
    </form> 
    
    </div>
     
     
     
 <%@include file="footer.jsp" %>   
   
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/myvalidateextension.js"></script>
    <script src="js/myvalidatecodeextension.js"></script>
    <script type="text/javascript" src="js/cropper.js"></script>
    <script type="text/javascript" src="js/uploadface.js"></script>
    <script type="text/javascript" src="js/alertutil.js"></script>
    <script type="text/javascript" src="js/imageviewer.js"></script>
    <script type="text/javascript">
       initUpload("#select-file","input[type='file']","#img-change","#btn")
    </script>
    
    <script type="text/javascript">
      
        $(function(){
             var form = $(".container form");
            var CONF = {
                opasswd:{
                        success:"",
                        error:"密码不能包含空格，6-10位"
                    },
                upasswd:{
                        success:"",
                        error:"密码不能包含空格，6-10位"
                    },
                rpasswd:{
                        success:"",
                        error:"密码不能包含空格，6-10位"
                    },
                different:{
                        success:"",
                        error:"两次输入的密码不一致"
                    }
            };
            var SUCCESS = {div:'has-success',span:'glyphicon-ok'};
            var WARNING = {div:'has-warning',span:'glyphicon-warning'};
            var DANGER = {div:'has-error',span:'glyphicon-remove'};   
            form.find("input").each(function(){
                $(this).blur(function(){
                    var name =  $(this).attr('name');
                    $(this).validateInput(CONF[name]);
                    console.log(name + " " + $(this).parent().hasClass("has-success"));
                    if("rpasswd" == name && $(this).parent().hasClass("has-success")){
                        var rvalue = $(this).val();
                        var uinput = $("#exampleInputPassword1");
                        if(uinput.parent().hasClass("has-success")){
                            if(rvalue != uinput.val()){
                                $.removeInfo($(this),SUCCESS);
                                $.showInfo($(this),DANGER,CONF['different']['error']);
                            }
                        }
                    }
                    
                    if("upasswd" == name && $(this).parent().hasClass("has-success")){
                        var rvalue = $(this).val();
                        var uinput = $("#exampleInputPassword2");
                        if(uinput.parent().hasClass("has-success")){
                            if(rvalue != uinput.val()){
                                $.removeInfo($(this),SUCCESS);
                                $.showInfo($(this),DANGER,CONF['different']['error']);
                            }
                        }
                    }
                })
            })
            $(".btn.btn-default[value='确认修改']").click(function(event){
                event.preventDefault();
                var flag = 0;
                var size = 0;
                form.find("input").each(function(index){
                    if(this.pattern != "" && typeof(this.pattern) != "undefined"){
                        if($(this).parent().hasClass('has-success')){
                            flag++;
                        }
                        size++;
                    }
                
                });
                if(flag == size && !$(this).hasClass("disabled")){
                    $("#exampleInputPassword2").removeAttr("name");
                    console.log(form.serialize());
                    var input = $(this);
                    input.val("提交中...");
                    input.addClass("disabled");
                    
                    $.post('rp!modify',form.serialize(),function(data,state){
                    $("#exampleInputPassword2").attr("name","rpasswd"); 
                    
                    input.val("确认修改");
                    input.removeClass("disabled"); 
                    console.log(data); 
                        if(data == "oldwrong"){
                           $("#showInfo").find(".modal-body p").html("原密码错误");
                            alertModal('原密码错误');
                        }else if("success" == data){
                            alertModalWithOption('修改成功，是否重新登录',function(){
                                window.location.href= 'login.jsp';
                            })
                        }else if("loginfirst" == data){
                            
                            alertModalWithOption('请先登录',function(){
                                window.location.href= 'login.jsp';
                            })
                        }
                    })  
                }
            })
            
        })
    </script>
    <script type="text/javascript" src="js/search.js"></script>
    <%@include file="popover.jsp"%>
  </body>
</html>
