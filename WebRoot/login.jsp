<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html lang="zh-CN">
  <head >
    <base href="<%=basePath%>">
    
    <title>登录</title>
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
        #imgCode:hover{
            cursor:pointer
        }
        /* .container{
              width:50%;
         } */
        /**ipad**/
		/* @media only screen (max-width:1024px){
		.container{
              width:70%;
          }
		} */
		/**iphone**/
		/*  @media only screen and (max-width:768px){
		  .container{
	             width:90%;
	         }
		 } */
    </style>
  </head>
  
  <body>
  
  <%@include file="header.jsp" %>
    <div class="container">
    <form role="form" action="rl!login" method="post">
		  <div class="form-group has-feedback">
		    <label class="control-label" for="inputSuccess1">用户名</label>
		    <input type="text" class="form-control" id="inputSuccess1" name="uname" placeholder="请输入用户名" required 
		    pattern="^[\u4E00-\u9FA5a-zA-z][\u4E00-\u9FA5a-zA-Z0-9_]{2,9}$">
		  </div>
		  <div class="form-group has-feedback">
		    <label class="control-label" for="inputWarning1">密码</label>
		    <input type="password" class="form-control" id="inputWarning1" name="upasswd" placeholder="请输入密码" required 
		    pattern="[\S]{6,10}">
		  </div>
		  
		  <div class="form-group has-feedback">
            <label class="control-label" for="inputCode1">验证码</label>
            <input type="text" class="form-control" id="inputCode1" name="randomCode" placeholder="请输入验证码" required 
            pattern="[\S]{4}">
            <img alt="验证码" src="" title="看不清？点击换一张" class="pull-right" id="imgCode" style="width:100px;height:30px">
          </div>
		  
		  <div class="form-group" style="clear:both">
		      <div class="checkbox">
                <label>
                    <input type="checkbox" name="remember" value="rememberme"> 记住我
                </label>
               </div>
		  </div>
		  <div class="form-group">
                <input type="submit" class="btn btn-default" value="登录"/>
                <a href="resetpasswd.jsp" class="btn btn-default pull-right">忘记密码</a>
                    
            </div>
    </form> 
    
    </div>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/myvalidateextension.js"></script>
    <script src="js/myvalidatecodeextension.js"></script>
    <script src="js/alertutil.js"></script>
    
    <!-- <script type="text/javascript">
             在对应的input后面添加以下信息
            在对应的div.form-group中添加类   has-success 、has-xxx
    
    <span class='help-block'>你输入的信息是正确的</span>
    <span class='glyphicon glyphicon-ok form-control-feedback'></span>
    
     <span class='help-block'>请输入正确信息</span>
    <span class='glyphicon glyphicon-warning-sign form-control-feedback"></span>
    
     <span class="help-block">你输入的信息是错误的</span>
    <span class="glyphicon glyphicon-remove form-control-feedback"></span>  
    </script> -->
    
    <script type="text/javascript">
      
        $(function(){
            var randomCode = $.getRandomCode(4); 
            var imgCode = $("#imgCode");
            imgCode.flushImg(randomCode,"validationCode?randomCode=");
            imgCode.click(function(){
                randomCode = $.getRandomCode(4);
                imgCode.flushImg(randomCode,"validationCode?randomCode=");
            })
        
            var form = $(".container form");
           /*  $.validate(form,{
                uname:"用户名由必须以字母，数字，或中文开头，3-10位",
                upasswd:"密码不能包含空格，6-10位"
            }); */
            var CONF = {
                uname:{
                        success:"",
                        error:"用户名由必须以字母，数字，或中文开头，3-10位"
                    },
                upasswd:{
                        success:"",
                        error:"密码不能包含空格，6-10位"
                    },
                randomCode:{
                    success:"",
                    error:"请输入正确的验证码"
                }
            };
            form.find("input").each(function(){
                $(this).blur(function(){
	                if($(this).attr('name') == 'randomCode'){
	                     $(this).validateInputCode(CONF[$(this).attr('name')],randomCode);
	                }else{
                        $(this).validateInput(CONF[$(this).attr('name')]);
                    }
                })
            })
            $(".btn.btn-default[value='登录']").click(function(event){
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
                    console.log(form.serialize());
                    //$("#inputCode1").removeAttr("name");
                    var input = $(this);
                    input.val("提交中...");
                    input.addClass("disabled");
                    $.post('rl!login',form.serialize(),function(data,state){
                        //$("#inputCode1").attr("name","randomCode");
                         input.val("登录");
                         input.removeClass("disabled");
                         console.log(data);
                         console.log(data.code);
                        if(data.code == "nouser"){
                            alertModalFullOption('<p>登陆失败，请检查用户名和密码</p>',null,'警告','朕知道了','','d');
                        }else if(data.code == "needactive"){
                            alertModalFullOption('<p>请登录邮箱先激活账号</p>',null,'警告','朕知道了','','d');
                        }else if(data.code == "success"){
                            window.location.href = 'index';
                        }else if(data.code == 'codeerror'){
                            alertModalFullOption('<p>验证码错误或已失效</p>',null,'警告','朕知道了','','d');
                        }
                        randomCode = $.getRandomCode(4);
                        imgCode.flushImg(randomCode,"validationCode?randomCode=");
                        $("#inputCode1").val("");
                    },'json');  
                }
            })
        })
    </script>
    <script type="text/javascript" src="js/search.js"></script>
  </body>
</html>
