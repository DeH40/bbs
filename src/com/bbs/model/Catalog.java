package com.bbs.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;

@Entity
public class Catalog {
	private int cid;
	private String cname = "";
	private String cintro = "";
	private int csize = 0;
	
	private Set<Topic> topics = new HashSet<Topic>();

	@Override
	public String toString() {
		return "cid: " + cid + " | cname: " + cname + " | cintro: " + cintro + " | csize: " + csize;
	}
	
	@Id
	@GeneratedValue
	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCintro() {
		return cintro;
	}

	public void setCintro(String cintro) {
		this.cintro = cintro;
	}

	public int getCsize() {
		return csize;
	}

	public void setCsize(int csize) {
		this.csize = csize;
	}

	@OneToMany(fetch=FetchType.LAZY,targetEntity=Topic.class,cascade=CascadeType.REMOVE)
	@JoinColumn(name="cid")
	public Set<Topic> getTopics() {
		return topics;
	}

	public void setTopics(Set<Topic> topics) {
		this.topics = topics;
	}
}
