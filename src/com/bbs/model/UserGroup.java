package com.bbs.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class UserGroup {
	private int id;
	private String ugname;
	private int authority;
	
	
	
	public int getAuthority() {
		return authority;
	}
	public void setAuthority(int authority) {
		this.authority = authority;
	}
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUgname() {
		return ugname;
	}
	public void setUgname(String ugname) {
		this.ugname = ugname;
	}
	
	

}
