package com.bbs.model;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Reply {
	public final static String UNREAD_FLAG = "0"; 
	public final static String READ_FLAG = "1"; 
	public final static int FLOOR_FLAG = 0; 
	public final static int NOT_FLOOR_FLAG = 1; 
	private int rid;
	private String content = "";
	/**
	 * 父回复
	 */
	private int pid = 0;
//	private Reply preply;
	
	private Set<Reply> childs;
	
	private int tid = 1;
	private Date rtime;
	/**
	 * 读标志 0  标识未读
	 */
	private String rread = Reply.UNREAD_FLAG;
	/**
	 * 楼层标识 0 标识非楼层 1标识楼层
	 */
	private int floor = Reply.NOT_FLOOR_FLAG;
	
	private User user;
	private User puser;
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "rid: " + rid + " | " + "content: " + content + " | " + "pid: " + pid + " | "
				+ "user: " + user + " | " + "tid: " + tid + " | "
				+"rtime: " + rtime + " | " + "rread: " + rread;
	}

	@Id
	@GeneratedValue
	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

/*	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}*/

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public Date getRtime() {
		return rtime;
	}

	public void setRtime(Date rtime) {
		this.rtime = rtime;
	}

	public String getRread() {
		return rread;
	}

	public void setRread(String rread) {
		this.rread = rread;
	}

	@ManyToOne(fetch=FetchType.EAGER,targetEntity=User.class)
	@JoinColumn(name="uid")
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}

	@ManyToOne(fetch=FetchType.EAGER,targetEntity=User.class)
	@JoinColumn(name="puid")
	public User getPuser() {
		return puser;
	}

	public void setPuser(User puser) {
		this.puser = puser;
	}

	public int getFloor() {
		return floor;
	}

	public void setFloor(int floor) {
		this.floor = floor;
	}

/*	@ManyToOne(fetch=FetchType.LAZY,targetEntity=Reply.class,cascade=CascadeType.REMOVE)
	@JoinColumn(name="pid")
	public Reply getPreply() {
		return preply;
	}

	public void setPreply(Reply preply) {
		this.preply = preply;
	}*/

	@OneToMany(fetch=FetchType.LAZY,targetEntity=Reply.class,cascade=CascadeType.REMOVE)
	@JoinColumn(name="pid")
	public Set<Reply> getChilds() {
		return childs;
	}

	public void setChilds(Set<Reply> childs) {
		this.childs = childs;
	}

	@Column(name="pid")
	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

}
