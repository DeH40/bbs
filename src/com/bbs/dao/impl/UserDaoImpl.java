package com.bbs.dao.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.springframework.stereotype.Component;

import com.bbs.dao.UserDao;
import com.bbs.model.User;

@Component
@Transactional
public class UserDaoImpl extends BaseImpl implements UserDao {

	@Override
	public void insert(User user) {
		Session session = getSession();
		session.persist(user);
	}


	@Override
	public User login(User u) {
		String sql = "select * from user where uname = '"+u.getUname()+"' and upasswd = '"+u.getUpasswd()+"'";
		List<?> result = this.createSqlQueryForEntity(sql, User.class);
		if(result.size() <= 0){
			return null;
		}
		return (User) result.get(0);
	}


	@Override
	public void active(String uuid) {
		String sql = "update user set active = 1 where uid = " + uuid;
		this.getSession().createSQLQuery(sql).executeUpdate();
	}


	@Override
	public void resetPasswd(String newPsd,String email) {
		String sql = "update user set upasswd = '" + newPsd + "' where email = '" + email + "'";
		this.getSession().createSQLQuery(sql).executeUpdate();
	}


	@Override
	public void modifyPasswd(String newPsd, String uuid) {
		String sql = "update user set upasswd = '" + newPsd + "' where uid = " + uuid ;
		this.getSession().createSQLQuery(sql).executeUpdate();
	}
	
	public void setFace(String uuid,String path){
		
		String sql = "update user set uface = '" + path + "' where uid = " + uuid ;
		this.getSession().createSQLQuery(sql).executeUpdate();
	}

}
