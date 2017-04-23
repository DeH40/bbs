package com.bbs.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.bbs.dao.impl.UpdateLogDaoImpl;
import com.bbs.model.UpdateLog;

@Component
public class UpdateLogService {
	private UpdateLogDaoImpl updateLogDaoImpl;
	
	public UpdateLog getLatest(){
		return updateLogDaoImpl.getLatest();
	}
	
	public List<UpdateLog> getAll(){
		return updateLogDaoImpl.getAll();
	}

	public UpdateLogDaoImpl getUpdateLogDaoImpl() {
		return updateLogDaoImpl;
	}

	@Resource
	public void setUpdateLogDaoImpl(UpdateLogDaoImpl updateLogDaoImpl) {
		this.updateLogDaoImpl = updateLogDaoImpl;
	}
}
