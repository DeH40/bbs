package com.bbs.action;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.Catalog;
import com.bbs.model.Reply;
import com.bbs.model.Topic;
import com.bbs.model.User;
import com.bbs.service.ReplyService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Component
@Scope("prototype")
public class ManagementAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4062486884978555216L;
	private int rid;
	private int tid;
	private int cid;
	private HashMap<String,Object> jsonMap = new HashMap<String,Object>();
	
	private ReplyService replyService;
	
	public String deleteReply(){
		return this.delete(rid, Reply.class);
	}
	public String deleteTopic(){
		return this.delete(tid, Topic.class);
	}
	public String deleteCatalog(){
		return this.delete(getCid(), Catalog.class);
	}
	
	private String delete(int id,Class<?> entityType){
		jsonMap.put("status", "ok");
		Object userObj = ActionContext.getContext().getSession().get(LoginAndRegAction.USER_IN_SESSION);
		if(tid < 0){
			jsonMap.put("code", "param error");
			return SUCCESS;
		}
		if(userObj != null && ((User)userObj).getUgroup().getAuthority() == 1){
			replyService.getReplyDaoImpl().delete(id,entityType);
			jsonMap.put("code", "success");
		}else{
			jsonMap.put("code", "permission denied");
		}
		return SUCCESS;
	}

	public HashMap<String,Object> getJsonMap() {
		return jsonMap;
	}

	public void setJsonMap(HashMap<String,Object> jsonMap) {
		this.jsonMap = jsonMap;
	}

	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}

	public ReplyService getReplyService() {
		return replyService;
	}

	@Resource
	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}


}
