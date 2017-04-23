package com.bbs.dao;

import java.io.Serializable;

import com.bbs.model.UserGroup;

public interface UserGroupDao {
	void insert(UserGroup userGroup);
	UserGroup get(Serializable id);
}
