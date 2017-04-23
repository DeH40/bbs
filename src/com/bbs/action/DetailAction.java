package com.bbs.action;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.Topic;
import com.bbs.service.ReplyService;

@Component
@Scope("prototype")
public class DetailAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int msg;
	private int rid;
	private int tid;
	private int index;
	private int uid;
	private String hostOnly;
	private Topic topic;
	private ReplyService replyService;
	private List<Map<String, Object>> items;
	
	
	public String detail(){
		this.base();
		tid = tid<=0?1:tid;
		setPageSize(5);
		String limit = " where tid = " + tid + " and floor = 1";
		if("true".equals(hostOnly)){
			limit += " and uid = " + uid;
		}
		maxPageSize = topicService.getTopicDaoImpl().getMaxPage(pageSize, "reply", limit);
		setItems(replyService.getTopic(index, pageSize, tid,limit));
		topic = topicService.get(tid);
		if(msg == 1 && rid > 0){
			replyService.modifyReadFlag(rid);
		}
		return SUCCESS;
	}
	
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}

	public ReplyService getReplyService() {
		return replyService;
	}
	@Resource
	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}

	public List<Map<String, Object>> getItems() {
		return items;
	}

	public void setItems(List<Map<String, Object>> items) {
		this.items = items;
	}

	public Topic getTopic() {
		return topic;
	}

	public void setTopic(Topic topic) {
		this.topic = topic;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getMsg() {
		return msg;
	}

	public void setMsg(int msg) {
		this.msg = msg;
	}

	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}

	public String getHostOnly() {
		return hostOnly;
	}

	public void setHostOnly(String hostOnly) {
		this.hostOnly = hostOnly;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}
	

}
