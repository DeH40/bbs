package com.bbs.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.opensymphony.xwork2.ActionSupport;
@Component
@Scope("prototype")
public class MyZoneAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1825322332030673033L;
	public String execute(){
		return SUCCESS;
	}

}
