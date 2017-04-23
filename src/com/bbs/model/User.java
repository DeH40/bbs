package com.bbs.model;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;



@Entity
public class User {
	/**
	 * 保密
	 */
	public final static String GENDER_S = "S";
	/**
	 * 男
	 */
	public final static String GENDER_M = "M";
	/**
	 * 女
	 */
	public final static String GENDER_F = "F";
	/**
	 * 在线
	 */
	public final static String USTAT_ONLINE = "online";
	/**
	 * 离线
	 */
	public final static String USTAT_OFFLINE = "offline";
	
	/**
	 * 账号未激活
	 */
	public final static int UNACTIVE_FLAG = 0;
	/**
	 * 账号已激活
	 */
	public final static int ACTIVE_FLAG = 1;
	
	private int uid;
	private String uname = "";
	private String upasswd = "";
	private String email = "";
	private String ustat = User.USTAT_OFFLINE;
	private String uface = "";
	private String uintro = "";
	private int uexp = 0;
	private int urmb = 0;
	private int active = User.UNACTIVE_FLAG;
	private String gender = User.GENDER_S;
	private UserGroup ugroup ;
	
	@Transient
	public String getGenderString(){
		if(this.gender.equals("S")){
			return "保密";
		}else if(this.gender.equals("M")){
			return "男";
		}else{
			return "女";
		}
	}

	@Id
	@GeneratedValue
	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public String getUpasswd() {
		return upasswd;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public void setUpasswd(String upasswd) {
		this.upasswd = upasswd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUstat() {
		return ustat;
	}

	public void setUstat(String ustat) {
		this.ustat = ustat;
	}

	public String getUface() {
		return uface;
	}

	public void setUface(String uface) {
		this.uface = uface;
	}

	public String getUintro() {
		return uintro;
	}

	public void setUintro(String uintro) {
		this.uintro = uintro;
	}

	public int getUexp() {
		return uexp;
	}

	public void setUexp(int uexp) {
		this.uexp = uexp;
	}

	public int getUrmb() {
		return urmb;
	}

	public void setUrmb(int urmb) {
		this.urmb = urmb;
	}

	@ManyToOne(fetch=FetchType.EAGER,targetEntity=UserGroup.class)
	@JoinColumn(name="ugroup")
	public UserGroup getUgroup() {
		return ugroup;
	}

	public void setUgroup(UserGroup ugroup) {
		this.ugroup = ugroup;
	}

	
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

}
