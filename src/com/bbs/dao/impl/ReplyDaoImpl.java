package com.bbs.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.springframework.stereotype.Component;

import com.bbs.dao.ReplyDao;
import com.bbs.model.Reply;

@Component
public class ReplyDaoImpl extends BaseImpl implements ReplyDao {
	@Override
	public Reply insert(Reply reply) {
		// TODO Auto-generated method stub
		Session session = this.getSession();
		session.persist(reply);
		return reply;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Reply> getFloor(int index, int pageSize,String limit) {
		//limit = " where tid = " + tid + " and floor = 1 order by rtime asc";
		List<?> data = this.getAll(index, pageSize, "reply", limit, Reply.class);
		return (List<Reply>) data;
	}
/*	@SuppressWarnings("unchecked")
	@Override
	public List<Reply> getFloor(int index, int pageSize,Serializable tid) {
		String limit = " where tid = " + tid + " and floor = 1 order by rtime asc";
		List<?> data = this.getAll(index, pageSize, "reply", limit, Reply.class);
		return (List<Reply>) data;
	}
*/
	@Override
	public List<Reply> getReply(Serializable tid,Serializable pid) {
		List<Reply> data = new ArrayList<Reply>();
		this.get(tid, pid, data);
		if(data.size() > 0){
			if(data.get(0).getRid() == 0 ){
				data.remove(0);
			}
		}
		return data;
	}
	
	@SuppressWarnings("unchecked")
	private void get(Serializable tid,Serializable pid,List<Reply> data){
//		String limit = " where tid = " + tid + " and pid = " + pid + " and rid != 0 ";
		String limit = " where floor = 0 and tid = " + tid + " and pid = " + pid;
		List<Reply> temp = (List<Reply>) this.getAll("reply", limit , Reply.class);
		data.addAll(temp);
		if(temp.size() > 0){
			for(Reply r:temp){
				get(tid,r.getRid(),data);
			}
		}else{
			return;
		}
	}

	@Override
	public Reply update(Reply reply) {
		Reply r = (Reply) this.saveOrUpdate(reply);
		this.flush();
		return r;
	}

	@Override
	public void modifyReadFlag(Serializable rid) {
		// TODO Auto-generated method stub
		Reply r = (Reply) this.getOne(rid, Reply.class);
		r.setRread("1");
		this.update(r);
	}

	
}
