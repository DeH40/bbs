package com.bbs.dao;

import java.io.Serializable;
import java.util.List;

import com.bbs.model.Reply;

public interface ReplyDao {
	Reply insert(Reply reply);
	Reply update(Reply reply);
	List<Reply> getFloor(int index,int pageSize,String limit);
	List<Reply> getReply(Serializable tid,Serializable pid);
	void modifyReadFlag(Serializable rid);
}
