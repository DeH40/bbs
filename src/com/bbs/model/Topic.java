package com.bbs.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Topic {
	public final static String TOP_FLAG = "1";
	public final static String NOT_TOP_FLAG = "0";
	
	private int tid;
	private String tname = "";
	private int cid = 1;
	private Date ctime;
	private Date mtime;
	private int tsize = 0;
	private String top = Topic.NOT_TOP_FLAG;
	private int taclick = 0;
	private int tclick = 0;
	
	private Set<Reply> replys = new HashSet<Reply>();
	
	private User user;
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "tid: " + tid + " | " + "tname: " + tname + " | " + "cid: " + cid + " | " 
				+ "user: " + user + " | " + "ctime: " + ctime + " | " + "mtime: " + mtime + " | "
				+"tsize: " + tsize + " | " + "top: " + top + " | " + "taclick: " + taclick + " | "
				+ "tclick: " + tclick;
	}

	@Id
	@GeneratedValue
	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public Date getCtime() {
		return ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}

	public Date getMtime() {
		return mtime;
	}

	public void setMtime(Date mtime) {
		this.mtime = mtime;
	}

	public int getTsize() {
		return tsize;
	}

	public void setTsize(int tsize) {
		this.tsize = tsize;
	}


	public int getTaclick() {
		return taclick;
	}

	public void setTaclick(int taclick) {
		this.taclick = taclick;
	}

	public int getTclick() {
		return tclick;
	}

	public void setTclick(int tclick) {
		this.tclick = tclick;
	}

	public String getTop() {
		return top;
	}

	public void setTop(String top) {
		this.top = top;
	}
	@ManyToOne(fetch=FetchType.EAGER,targetEntity=User.class)
	@JoinColumn(name="uid")
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}

	@OneToMany(fetch=FetchType.LAZY,targetEntity=Reply.class,cascade=CascadeType.REMOVE)
	@JoinColumn(name="tid")
	public Set<Reply> getReplys() {
		return replys;
	}

	public void setReplys(Set<Reply> replys) {
		this.replys = replys;
	}
}
