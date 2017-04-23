package com.bbs.dao.impl;

import java.io.Serializable;

import org.springframework.stereotype.Component;

import com.bbs.dao.UserGroupDao;
import com.bbs.model.UserGroup;

@Component
public class UserGroupDaoImpl extends BaseImpl implements UserGroupDao {

	@Override
	public void insert(UserGroup userGroup) {
		// TODO Auto-generated method stub
		this.getSession().persist(userGroup);
	}

	@Override
	public UserGroup get(Serializable id) {
		Object obj = this.getSession().get(UserGroup.class, id);
		return null == obj ? null:(UserGroup)obj ;
	}

}
