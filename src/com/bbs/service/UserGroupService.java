package com.bbs.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.bbs.dao.impl.UserGroupDaoImpl;
import com.bbs.model.UserGroup;

@Component
public class UserGroupService {
	private UserGroupDaoImpl userGroupDaoImpl;
	
	public void add(UserGroup userGroup){
		userGroupDaoImpl.insert(userGroup);
	}
	
	public UserGroup get(int id){
		return userGroupDaoImpl.get(id);
	}

	public UserGroupDaoImpl getUserGroupDaoImpl() {
		return userGroupDaoImpl;
	}

	@Resource
	public void setUserGroupDaoImpl(UserGroupDaoImpl userGroupDaoImpl) {
		this.userGroupDaoImpl = userGroupDaoImpl;
	}
}
