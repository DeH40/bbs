package com.bbs.dao.impl;

import java.util.List;

import org.springframework.stereotype.Component;

import com.bbs.dao.UpdateLogDao;
import com.bbs.model.UpdateLog;

@Component
public class UpdateLogDaoImpl extends BaseImpl implements UpdateLogDao{

	@Override
	public UpdateLog getLatest() {
		UpdateLog log = (UpdateLog) this.getAll("updatelog", "order by ctime desc limit 1 ", UpdateLog.class).get(0);
		return log;
	}

	@SuppressWarnings("unchecked")
	public List<UpdateLog> getAll() {
		List<UpdateLog> logs = (List<UpdateLog>) this.getAll("updatelog", "order by ctime desc", UpdateLog.class);
		return logs;
	}

}
