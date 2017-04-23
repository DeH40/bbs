package com.bbs.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.bbs.dao.impl.CatalogDaoImpl;
import com.bbs.model.Catalog;

@Component
public class CatalogService {
	private CatalogDaoImpl catalogDaoImpl;

	public void add(Catalog catalog) {
		catalogDaoImpl.insert(catalog);
	}

	public CatalogDaoImpl getCatalogDaoImpl() {
		return catalogDaoImpl;
	}

	@Resource
	public void setCatalogDaoImpl(CatalogDaoImpl catalogDaoImpl) {
		this.catalogDaoImpl = catalogDaoImpl;
	}
	
	public List<Catalog> getAll(){
		return catalogDaoImpl.getAll();
	}
	public List<Catalog> getAll(int index,int pageSize){
		return catalogDaoImpl.getAll(index,pageSize);
	}
	
	public int getSize(){
		return catalogDaoImpl.getTableSize("catalog");
	};

}
