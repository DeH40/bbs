package com.bbs.dao;

import com.bbs.model.UpdateLog;

public interface UpdateLogDao {
	
	UpdateLog getLatest();
}
