package com.bbs.dao;

import java.util.List;

import com.bbs.model.Topic;

public interface TopicDao {
	Topic insert(Topic topic);
	Topic update(Topic topic);
	List<Topic> getTop(int cid);
	List<Topic> getAll(int index,int pageSize,int cid);
	Topic get(int tid);
}
