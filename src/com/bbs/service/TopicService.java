package com.bbs.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.bbs.dao.impl.TopicDaoImpl;
import com.bbs.model.Topic;

@Component
public class TopicService {
	private TopicDaoImpl topicDaoImpl;

	public Topic add(Topic topic) {
		return topicDaoImpl.insert(topic);
	}
	
	public Topic update(Topic topic){
		return topicDaoImpl.update(topic);
	}
	
	public List<Topic> getAll(int index,int pageSize,int cid){
		return topicDaoImpl.getAll(index, pageSize,cid);
	}
	public List<Topic> getTop(int cid){
		return topicDaoImpl.getTop(cid);
	}
	
	public Topic get(int tid){
		return topicDaoImpl.get(tid);
	}

	public TopicDaoImpl getTopicDaoImpl() {
		return topicDaoImpl;
	}

	@Resource
	public void setTopicDaoImpl(TopicDaoImpl topicDaoImpl) {
		this.topicDaoImpl = topicDaoImpl;
	}
	
}
