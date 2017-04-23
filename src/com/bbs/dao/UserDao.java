package com.bbs.dao;

import com.bbs.model.User;

public interface UserDao {
	void insert(User user);
	User login(User u);
	void active(String uuid);
	void resetPasswd(String newPsd,String email);
	void modifyPasswd(String newPsd,String uuid);
}
