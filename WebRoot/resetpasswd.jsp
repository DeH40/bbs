<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html lang="zh-CN">
  <head >
    <base href="<%=basePath%>">
    
    <title>找回密码</title>
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
            padding-top:70px
        }
    </style>
  </head>
  
  <body>
  <%@include file="header.jsp" %>
    <div class="container" style="width:50%">
    <form role="form" action="rl!login" method="post">
		  <div class="form-group has-feedback">
		    <label class="control-label" for="inputSuccess1">邮箱</label>
		    <input type="email" class="form-control" id="inputSuccess1" name="email" placeholder="请输入你注册时使用的邮箱" required 
		    pattern="^[A-z0-9_-]+[\.A-z0-9_-]*@[A-z0-9_-]+([\.A-z0-9_-]+)+[A-z]+$">
		  </div>
		  
		  <div class="pull-right">
            <button class="btn btn-default" id="emailCode">点击获取验证码</button>
          </div>
		  
		  <div class="form-group has-feedback" style="clear:both">
		    <label class="control-label" for="inputemailcode">验证码</label>
		    <input type="text" class="form-control" id="inputemailcode" name="emailCode" placeholder="请输入邮箱验证码" required 
		    pattern="[0-9]{6}">
		  </div>
		  
		  <div class="form-group has-feedback">
		    <label for="exampleInputPassword1">新密码</label>
		    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="密码" required name="upasswd"
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
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/myvalidateextension.js"></script>
    
    
    <script type="text/javascript">
      
        $(function(){
            var form = $(".container form");
            var CONF = {
                email:{
                        success:"",
                        error:"请输入正确的邮箱"
                    },
                emailCode:{
                        success:"",
                        error:"请输入6位数字验证码"    
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
                    $.post('rp!reset',form.serialize(),function(data,state){
	                    $("#exampleInputPassword2").attr("name","rpasswd");   
	                    input.val("确认修改");
                        input.removeClass("disabled");
                        if(data == "fail"){
                           $("#showInfo").find(".modal-body p").html("修改失败！ 验证码错误，或以过期");
	                        $("#showInfo").modal({
	                                  show:true,
	                                  keyboard:false,
	                                  backdrop:true,
	                        });
                        }else{
	                        $("#showInfo").find(".modal-body p").html("修改成功");
	                        $("#showInfo").modal({
	                                  show:true,
	                                  keyboard:false,
	                                  backdrop:true,
	                        });
                            console.log(data);
                            $(".btn.btn-default[data-dismiss='modal']").click(function(){
                                window.location.href = 'index';
                            })
                        }
                    })  
                }
            })
            var delay = 30;
            function delayGet(){
                if(delay > 0){
                    $("#emailCode").addClass("disabled");
                    $("#emailCode").html(delay + "秒后可重新发送");
                    delay--;
                    setTimeout(delayGet,1000);
                }else{
                    $("#emailCode").html("点击获取验证码");
                     $("#emailCode").removeClass("disabled");
                    delay = 30;
                }
            }
            
            $("#emailCode").click(function(){
                if(!$(this).hasClass("disabled")){
	                var val = form.find("input[name='email']").val();
	                console.log("val: " + val);
	                if(val == ""){
	                   $("#showInfo").find(".modal-body p").html("请先输入邮箱");
                       $("#showInfo").modal({
                                 show:true,
                                 keyboard:false,
                                 backdrop:true,
                       });
	                   return;
	                }
	                $.post("rp!getCode",{
	                    email:val
	                },function(data,stat){
	                console.log("rpgetcode: " +data);
	                    if("success" == data){
	                        $("#showInfo").find(".modal-body p").html("验证码获取成功，请检查您的邮箱");
	                        $("#showInfo").modal({
	                                  show:true,
	                                  keyboard:false,
	                                  backdrop:true,
	                        });
	                        delayGet();
	                    }else{
	                        $("#showInfo").find(".modal-body p").html("获取失败，请输入你注册时使用的邮箱");
	                        $("#showInfo").modal({
	                                  show:true,
	                                  keyboard:false,
	                                  backdrop:true,
	                        });
	                    }
	                }) 
                }
            })
            
        })
    </script>
    
    
    
    
    
    
    <div class="modal fade" id="showInfo" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">提示</h4>
            </div>
            <div class="modal-body">
                <p>获取失败，请输入你注册时使用的邮箱</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">朕知道了</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

  </body>
</html>
