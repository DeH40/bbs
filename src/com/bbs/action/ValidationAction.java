package com.bbs.action;

import java.io.ByteArrayInputStream;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.service.UserService;
import com.opensymphony.xwork2.ActionSupport;

@Component
@Scope("prototype")
public class ValidationAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3518688765363645791L;
	private String uname;
	private String email;
	private UserService userService;
	
	private ByteArrayInputStream inputStream;
	
	public String name(){
		int size = userService.countByType(uname, "uname");
		if(size > 0){
			inputStream = new ByteArrayInputStream("morethenzero".getBytes());
		}else{
			inputStream = new ByteArrayInputStream("zero".getBytes());
		}
		return SUCCESS;
	}
	
	public String email(){
		int size = userService.countByType(email, "email");
		if(size > 0){
			inputStream = new ByteArrayInputStream("morethenzero".getBytes());
		}else{
			inputStream = new ByteArrayInputStream("zero".getBytes());
		}
		return SUCCESS;
	}
	
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public UserService getUserService() {
		return userService;
	}

	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public ByteArrayInputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(ByteArrayInputStream inputStream) {
		this.inputStream = inputStream;
	}

}
