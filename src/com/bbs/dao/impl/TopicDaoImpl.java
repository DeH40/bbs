package com.bbs.dao.impl;

import java.util.List;


import org.hibernate.Session;
import org.springframework.stereotype.Component;

import com.bbs.dao.TopicDao;
import com.bbs.model.Topic;

@Component
public class TopicDaoImpl extends BaseImpl implements TopicDao {


	@Override
	public Topic insert(Topic topic) {
		Session session = getSession();
		session.persist(topic);
		return topic;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Topic> getAll(int index, int pageSize,int cid) {
		String limit = " where cid = " + cid + " and top = '0' order by mtime desc";
		List<Topic> data = (List<Topic>) this.getAll(index, pageSize, "topic",limit, Topic.class);
		return data;
	}

	@Override
	public Topic update(Topic topic) {
		return (Topic) this.saveOrUpdate(topic);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Topic> getTop(int cid) {
		String sql = "select * from topic where top = '1' and cid = " + cid + " ";
		List<Topic> tops = (List<Topic>) this.createSqlQueryForEntity(sql, Topic.class);
		return tops;
	}

	@Override
	public Topic get(int tid) {
		Object obj = (Topic) this.getOne(tid, Topic.class);
		return null == obj ? null:(Topic)obj;
	}


}
