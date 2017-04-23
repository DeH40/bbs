package com.bbs.action;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.Reply;
import com.bbs.model.Topic;
import com.bbs.model.User;
import com.bbs.service.ReplyService;

@Component
@Scope("prototype")
public class PublishAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String title;
	private String content;
	private ReplyService replyService;
	
	private int tid;
	private int pid;
	private int floor;
	private int index;
	
	public String publishTopic(){
		this.base();
		User user = (User) this.session.get("user");
		Topic t = new Topic();
		t.setCid(cid);
		t.setTname(title);
		t.setUser(user);
		t = this.topicService.add(t);
		Reply r = new Reply();
		r.setContent(content);
		r.setTid(t.getTid());
		r.setUser(user);
		r.setPuser(user);
		r.setFloor(1);
		r = this.replyService.add(r);
		r.setPid(r.getRid());
		this.replyService.getReplyDaoImpl().flush();
		return SUCCESS;
	}
	
	public String publishReply(){
		this.base();
		User user = (User) this.session.get("user");
		Reply r = new Reply();
		//System.out.println("content: "+content);
		r.setContent(content);
//		r.setPreply(null);
		r.setTid(tid);
		r.setUser(user);
		r.setFloor(floor);
		System.out.println("publish action pid: "  + pid);
		Reply preply = (Reply) replyService.getReplyDaoImpl().getOne(pid, Reply.class);
		User puser = preply.getUser();
		r.setPuser(puser);
		r.setPid(preply.getRid());
		this.replyService.add(r);
		return "reply";
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getFloor() {
		return floor;
	}

	public void setFloor(int floor) {
		this.floor = floor;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

}
