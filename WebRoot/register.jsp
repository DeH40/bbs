<%@ page language="java" import="java.util.*,com.bbs.model.*,com.bbs.tool.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
    <head>
    <base href="<%=basePath%>">
    <title>注册</title>
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
        .container{
              width:50%;
         }
        /**ipad**/
        @media only screen (max-width:1024px){
        .container{
              width:70%;
          }
        }
        /**iphone**/
         @media only screen and (max-width:768px){
          .container{
                 width:90%;
             }
         }
    </style>
  </head>
  
  <body>
<!-- 正文开始 -->
<%@include file="header.jsp"%>
<div class="container">
<form action="rl!register" method="post">

    <div class="form-group has-feedback">
    <label for="exampleInputName1">用户名</label>
    <input type="text" class="form-control" id="exampleInputName1" placeholder="昵称" required name="uname"
    pattern="^[\u4E00-\u9FA5a-zA-z][\u4E00-\u9FA5a-zA-Z0-9_]{2,9}$">
  </div>
    
  <div class="form-group has-feedback">
    <label for="exampleInputEmail1">邮箱地址</label>
    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="邮箱" required name="email"
    pattern="^[A-z0-9_-]+[\.A-z0-9_-]*@[A-z0-9_-]+([\.A-z0-9_-]+)+[A-z]+$"    >
  </div>
  <div class="form-group has-feedback">
    <label for="exampleInputPassword1">密码</label>
    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="密码" required name="upasswd"
    pattern="[\S]{6,10}">
  </div>
  <div class="form-group has-feedback">
    <label for="exampleInputPassword2">确认密码</label>
    <input type="password" class="form-control" id="exampleInputPassword2" placeholder="确认密码" required name="rpasswd"
    pattern="[\S]{6,10}">
  </div>
  <div class="form-group">
	   <label class="radio-inline">
	       <input type="radio" name="gender" id="inlineRadio1" value="S" checked> 保密
	   </label>
	   <label class="radio-inline">
	       <input type="radio" name="gender" id="inlineRadio2" value="M"> 男
	   </label>
	   <label class="radio-inline">
	       <input type="radio" name="gender" id="inlineRadio3" value="F"> 女
	   </label>
  </div>
  <div class="form-group">
    <label for="exampleInputTextarea1"> 个人简介</label>
    <textarea class="form-control" rows="3" id="exampleInputTextarea1" name="uintro"></textarea>
  </div>
  
  <div class="form-group has-feedback">
    <label class="control-label" for="inputCode1">验证码</label>
    <input type="text" class="form-control" id="inputCode1" name="randomCode" placeholder="请输入验证码" required 
    pattern="[\S]{4}">
    <img alt="验证码" src="" title="看不清？点击换一张" class="pull-right" id="imgCode" style="width:100px;height:30px">
  </div>
  
  <div class="form-group" style="clear:both">
     <input type="submit" class="btn btn-default" value="提交"/>
  </div>
</form>

</div>

<!-- 正文结束 -->


<%@include file="footer.jsp" %>


    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/myvalidateextension.js"></script>
    <script src="js/myvalidatecodeextension.js"></script>
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
            var CONF = {
                uname:{
                        success:"",
                        error:"用户名由必须以字母，数字，或中文开头，3-10位"
                    },
                email:{
                        success:"",
                        error:"请输入正确的邮箱"
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
                    },
                randomCode:{
                    success:"",
                    error:"请输入正确的验证码"
                },
                rname:{
                    success:"",
                    error:"用户名已存在"
                },
                remail:{
                    success:"",
                    error:"邮箱已被注册"
                }
            };
            var SUCCESS = {div:'has-success',span:'glyphicon-ok'};
            var WARNING = {div:'has-warning',span:'glyphicon-warning'};
            var DANGER = {div:'has-error',span:'glyphicon-remove'};   
            form.find("input").each(function(){
                $(this).blur(function(){
                    var name =  $(this).attr('name');
                   if(name == 'randomCode'){
                         $(this).validateInputCode(CONF[name],randomCode);
                    }else{
                        $(this).validateInput(CONF[$(this).attr('name')]);
                    }
                    //console.log(name + " " + $(this).parent().hasClass("has-success"));
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
                    if("uname" == name && $(this).parent().hasClass("has-success")){
                        var value = $(this).val();
                        var node = $(this);
                        //console.log("validation name");
                        $.post("validation!name",{
                            uname:value
                        },function(data,stat){
                            if("morethenzero" == data){
                                $.removeInfo(node,SUCCESS);
                                $.showInfo(node,DANGER,CONF['rname']['error']);
                            }
                        })
                    }
                     if("email" == name && $(this).parent().hasClass("has-success")){
                        var value = $(this).val();
                        var node = $(this);
                        $.post("validation!email",{
                            email:value
                        },function(data,stat){
                            if("morethenzero" == data){
                                $.removeInfo(node,SUCCESS);
                                $.showInfo(node,DANGER,CONF['remail']['error']);
                            }
                        })
                    }
                })
            })
            $(".btn.btn-default[value='提交']").click(function(event){
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
                    var input = $(this); 
                    input.val("提交中...");
                    input.addClass("disabled");
                    $("#exampleInputPassword2").removeAttr("name");
                    //$("#inputCode1").removeAttr("name");
                    //console.log(form.serialize());
                    $.post('rl!register',form.serialize(),function(data,state){
                        //$("#inputCode1").attr("name","randomCode");
                        input.val("提交");
                        input.removeClass("disabled");
                        if(data.code == "paramerror" || data.code == "dberror"){
                            alertModalFullOption('<p>请检查您的输入</p>',null,'警告','朕知道了','','d');
                        }else if(data.code == "success"){
                            window.location.href = 'regmail.jsp';
                        }
                        randomCode = $.getRandomCode(4);
                        imgCode.flushImg(randomCode,"validationCode?randomCode=");
                    },'json');     
                }
            })
        })
    </script>
    <script type="text/javascript" src="js/search.js"></script>
  </body>
</html>
