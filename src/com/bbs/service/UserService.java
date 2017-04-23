package com.bbs.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.bbs.dao.impl.UserDaoImpl;
import com.bbs.model.User;

@Component
public class UserService {
	private UserDaoImpl userDaoImpl;

	public void add(User user) {
		userDaoImpl.insert(user);
	}
	
	public User login(User user){
		return userDaoImpl.login(user);
	}

	public void active(String uuid){
		userDaoImpl.active(uuid);
	}
	
	public void resetPasswd(String newPsd,String email){
		userDaoImpl.resetPasswd(newPsd, email);
	}
	
	public void modifyPasswd(String newPsd, String uuid) {
		userDaoImpl.modifyPasswd(newPsd, uuid);
	}
	
	public int countByType(String info,String type){
		String sql = "select * from user where " + type + " = '" + info +"'";
		List<?> list = this.userDaoImpl.getSession().createSQLQuery(sql).addEntity(User.class).list();
		return list.size();
	}
	
	public UserDaoImpl getUserDaoImpl() {
		return userDaoImpl;
	}

	@Resource
	public void setUserDaoImpl(UserDaoImpl userDaoImpl) {
		this.userDaoImpl = userDaoImpl;
	}
	
	public void updateFace(String path,String uuid){
		userDaoImpl.setFace(uuid, path);
	}

}
