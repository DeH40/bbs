package com.bbs.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.bbs.dao.impl.ReplyDaoImpl;
import com.bbs.model.Reply;

@Component
public class ReplyService {
	private ReplyDaoImpl replyDaoImpl;

	public Reply add(Reply reply) {
		return replyDaoImpl.insert(reply);
	}
	
	public Reply update(Reply reply){
		return replyDaoImpl.update(reply);
	}
	
	/**
	 * 获取具有分页功能的楼层信息
	 * @param index
	 * @param pageSize
	 * @param tid
	 * @return List<Reply>
	 */
/*	public List<Reply> getFloor(int index,int pageSize,int tid){
		List<Reply> floor = replyDaoImpl.getFloor(index, pageSize,tid);
		return floor;
	}*/
	public List<Reply> getFloor(int index,int pageSize,String limit){
		List<Reply> floor = replyDaoImpl.getFloor(index, pageSize,limit);
		return floor;
	}

	/**
	 * 获取指定的帖子回复的信息
	 * @param tid
	 * @param pid
	 * @return List<Reply>
	 */
	public List<Reply> getReply(int tid,int pid){
		return replyDaoImpl.getReply(tid, pid);
	}
	
	/**
	 * 获取一个帖子完整内容，带分页
	 * @param index
	 * @param pageSize
	 * @param tid
	 * @return List<Map<String,Object>>
	 */
	public List<Map<String,Object>> getTopic(int index,int pageSize,int tid,String limit){
		List<Reply> floor = this.getFloor(index, pageSize,limit);
		//System.out.println("楼层大小： "+floor.size());
		List<Map<String,Object>> topic = new ArrayList<Map<String,Object>>();
		Map<String,Object> item;
		for(Reply r:floor){
			item = new LinkedHashMap<String, Object>();
			item.put("floor", r);
			item.put("reply", this.getReply(tid, r.getRid()));
			topic.add(item);
		}
		return topic;
	}
	
	public ReplyDaoImpl getReplyDaoImpl() {
		return replyDaoImpl;
	}

	@Resource
	public void setReplyDaoImpl(ReplyDaoImpl replyDaoImpl) {
		this.replyDaoImpl = replyDaoImpl;
	}
	
	public void modifyReadFlag(Serializable rid){
		this.replyDaoImpl.modifyReadFlag(rid);
	}
}
