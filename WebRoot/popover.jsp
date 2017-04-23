<%@ page language="java" import="java.util.*,com.bbs.model.*,com.bbs.tool.*" pageEncoding="utf-8"%>
<script type="text/javascript">
   $(function(){
       <%if(user != null){%>
           var popMessage = $('#popover-message');
           function togglePop(){
               if(popMessage.attr('data-visible') == 'false'){
                   popMessage.popover({
                       title:'新消息',
                       content:'<div id="pop-show" class="clearfix" style="width:200px;word-wrap:break-word;padding:2px auto;max-height:200px;overflow-y:auto">loading...</div>',
                       html:true
                   })
                   popMessage.attr('data-visible','true');
                   popMessage.popover('toggle')
                   $.get("getMessage!getMessage",function(data){
                       console.log(data);
                       if(data.code == 'success'){
                           var msgs = data.msg;
                           var dom ="";
                           var template = '<p><a href="detail?msg=1&tid=$tid$&rid=$rid$">$msg$</a></p>';
                           //console.log(msgs.length)
                           if(msgs.length <= 0){
                        	   $('#pop-show').html('<p>没有新消息</p>');
                           }else{
	                           msgs.forEach(function(row,index){
	                               //console.log(index);
	                               var temp = template.replace('$tid$',row.tid).replace('$rid$',row.rid).replace('$msg$','<strong>' + row.uname + "：</strong>" + row.msg);   
	                               dom += temp;
	                           })
	                           
	                           $('#pop-show').html(dom);
                           }
                       }
                   },'json');
               }else{
                   popMessage.attr('data-visible','false');
                   popMessage.popover('toggle');
               }
           }
           $("#popover-container").hover(togglePop).on('click',togglePop);
           <%}%>
           
           
   })
</script>

