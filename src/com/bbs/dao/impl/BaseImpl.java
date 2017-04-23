package com.bbs.dao.impl;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Component;

import com.bbs.tool.Pagination;


@Component
public class BaseImpl {
	protected SessionFactory sessionFactory;
	protected Pagination pagination;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	@Resource
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}
	
	public void flush(){
		this.getSession().flush();
	}

	/**
	 * 执行一条SQL语句，结果集中每一条只有一个数据
	 * @param sql
	 * @return List
	 */
	public List<?> createSqlQuery(String sql) {
		return getSession().createSQLQuery(sql).list();
	}
	
	/**
	 * 执行一条SQL语句，并指定结果的实体类型
	 * @param sql
	 * @param entityType
	 * @return List<entityType>
	 */
	public List<?> createSqlQueryForEntity(String sql,Class<?> entityType){
		List<?> list = getSession().createSQLQuery(sql).addEntity(entityType).list();
		return list;
	}

	public Pagination getPagination() {
		return pagination;
	}

	@Resource
	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}
	
	public Pagination initPagenation(){
		return this.pagination.init(this);
	}
	
	public int getTableSize(String tableName){
		String sql = "select count(*) from " + tableName;
		Object o = this.createSqlQuery(sql).get(0);
		//System.out.println("count: "+((BigInteger)o).intValue());
		return ((BigInteger)o).intValue();
	}
	
	public int getTableSize(String tableName,String limit){
		String sql = "select count(*) from " + tableName + " " + limit;
		Object o = this.createSqlQuery(sql).get(0);
		return ((BigInteger)o).intValue();
	}
	
	public List<?> getAll(int index, int pageSize,String tableName,String limit,Class<?> entityType) {
		initPagenation();
		this.pagination.caculate(index, pageSize, tableName, limit);
		String sql = "select * from " + tableName;
		if(limit != null){
			sql += " " + limit + " ";
		}
//		if(Topic.class == entityType){
//			sql += " order by mtime desc ";
//		}else if(Reply.class == entityType){
//			sql += "order by rtime desc ";
//		}
		sql += " limit " + pagination.getStart() + " , " + pagination.getPageSize();
		List<?> data = createSqlQueryForEntity(sql, entityType);
		return data;
	}
	
	public List<?> getAll(String tableName,String limit,Class<?> entityType){
		String sql = "select * from " + tableName + " " + limit;
		List<?> data = createSqlQueryForEntity(sql, entityType);
		return data;
	}
	
	public int getMaxPage(int pageSize,String tableName,String limit){
		this.initPagenation();
		return pagination.getMaxPageSize(pageSize, tableName, limit);
	}
	
	public Object saveOrUpdate(Object entity){
		this.getSession().saveOrUpdate(entity);
		return entity;
	}
	
	public Object getOne(Serializable id,Class<?> entityType){
		return this.getSession().get(entityType, id);
	}
	
	public void delete(Serializable id,Class<?> entityType){
		this.getSession().delete(this.getOne(id, entityType));
		this.flush();
	}
}
