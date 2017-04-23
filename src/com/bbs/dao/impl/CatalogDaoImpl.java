package com.bbs.dao.impl;

import java.util.List;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.springframework.stereotype.Component;

import com.bbs.dao.CatalogDao;
import com.bbs.model.Catalog;

@Component
@Transactional
public class CatalogDaoImpl extends BaseImpl implements CatalogDao {

	@Override
	public void insert(Catalog catalog) {
		Session session = getSession();
		session.persist(catalog);
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<Catalog> getAll() {
		String sql = "select * from catalog";
		List<Catalog> catalogs = (List<Catalog>) createSqlQueryForEntity(sql, Catalog.class);
		return catalogs;
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<Catalog> getAll(int index,int pageSize) {
		initPagenation();
		pagination.caculate(index, pageSize, "catalog",null);
		String sql = "select * from catalog limit " + pagination.getStart() + " , " + pagination.getPageSize();
		List<Catalog> catalogs = (List<Catalog>) createSqlQueryForEntity(sql, Catalog.class);
		return catalogs;
	}

}
