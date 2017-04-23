package com.bbs.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.Reply;
import com.bbs.model.User;
import com.bbs.service.ReplyService;
import com.bbs.tool.HTMLUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Component
@Scope("prototype")
public class GetMessageAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8202935824293112259L;
	
	public static final int MESSAGE_LENGHT = 10;
	
	private ReplyService replyService;
	
	private LinkedHashMap<String,Object> jsonMap = new LinkedHashMap<String,Object>();
	
	@SuppressWarnings("unchecked")
	public String getMessage(){
		Object userObj = ActionContext.getContext().getSession().get(LoginAndRegAction.USER_IN_SESSION);
		jsonMap.put("status", "ok");
		if(userObj != null){
			User user = (User)userObj;
			int uid = user.getUid();
			String limit = " where puid != uid and rread = '0' and puid = " + uid + " order by rtime desc";
			List<Reply> replys = (List<Reply>) replyService.getReplyDaoImpl().getAll("reply", limit, Reply.class);
			jsonMap.put("code", "success");
			List<HashMap<String,Object>> msgs = new ArrayList<HashMap<String,Object>>();
			System.out.println(replys.size());
			for(Reply r:replys){
				HashMap<String,Object> row = new HashMap<String,Object>();
				row.put("uname",r.getUser().getUname());
				String containsImg = r.getContent().contains("<img")?"【图片】":"";
				row.put("msg", containsImg + HTMLUtil.delHTMLTag(r.getContent(), MESSAGE_LENGHT));
				row.put("rid", r.getRid());
				row.put("tid", r.getTid());
				row.put("rread", r.getRread());
				msgs.add(row);
			}
			jsonMap.put("msg", msgs);
		}else{
			jsonMap.put("code", "login first");
		}
		return SUCCESS;
	}

	public LinkedHashMap<String,Object> getJsonMap() {
		return jsonMap;
	}

	public void setJsonMap(LinkedHashMap<String,Object> jsonMap) {
		this.jsonMap = jsonMap;
	}

	public ReplyService getReplyService() {
		return replyService;
	}

	@Resource
	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}

}
