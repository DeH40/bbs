package com.bbs.dao;

import java.util.List;

import com.bbs.model.Catalog;

public interface CatalogDao {
	void insert(Catalog catalog);
	List<Catalog> getAll();
	List<Catalog> getAll(int index,int pageSize);
}
