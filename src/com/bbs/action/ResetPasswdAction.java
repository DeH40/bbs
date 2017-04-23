package com.bbs.action;

import java.io.ByteArrayInputStream;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.Resource;

import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.User;
import com.bbs.service.UserService;
import com.bbs.tool.PathUtil;
import com.bbs.tool.RandomCodeUtil;
import com.bbs.tool.SendEmailUtils;
import com.opensymphony.xwork2.ActionSupport;

@Component
@Scope("prototype")
public class ResetPasswdAction extends ActionSupport implements SessionAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2076042588734790748L;
	public static final String RESET_PASSWD_CODE = "rpc";
	/**
	 * 验证码失效时间（分钟）
	 */
	public static final int SESSION_INTERVAL_TIME = 5;
	private String email;
	private String upasswd;
	private String opasswd;
	private String emailCode;
	private ByteArrayInputStream inputStream;
	private UserService userService;
	private Map<String,Object> session;
	
	public String getCode(){
		String randomCode = RandomCodeUtil.getRandomDigitCode(6);
		String basePath = PathUtil.getBasePath();
		if(null != email){
			SendEmailUtils.sendResetPasswordEmail(email, randomCode, basePath, "resetpasswd.html", "重置密码");
			session.put(RESET_PASSWD_CODE, randomCode);
			Timer timer = new Timer(true);
			TimerTask task = new TimerTask() {
				
				@Override
				public void run() {
					session.remove(RESET_PASSWD_CODE);
					System.out.println("code deleted ");
				}
			};
			timer.schedule(task,SESSION_INTERVAL_TIME * 60 * 1000);
		}else{
			inputStream = new ByteArrayInputStream("fail".getBytes());
		}
		inputStream = new ByteArrayInputStream("success".getBytes());
		return SUCCESS;
	}
	
	public String reset(){
		Object ec = session.get(RESET_PASSWD_CODE);
		
		if(null != ec && ((String)ec).equals(emailCode)){
			this.userService.resetPasswd(upasswd, email);
			inputStream = new ByteArrayInputStream("success".getBytes());
			session.remove(LoginAndRegAction.USER_IN_SESSION);
		}else{
			inputStream = new ByteArrayInputStream("fail".getBytes());
		}
		return SUCCESS;
	}
	
	public String modify(){
		Object obj = session.get(LoginAndRegAction.USER_IN_SESSION);
		if(obj != null){
			User user = (User) obj;
			if(user.getUpasswd().equals(opasswd)){
				this.userService.modifyPasswd(upasswd, user.getUid()+"");
				session.remove(LoginAndRegAction.USER_IN_SESSION);
				inputStream = new ByteArrayInputStream("success".getBytes());
			}else{
				inputStream = new ByteArrayInputStream("oldwrong".getBytes());
			}
		}else{
			inputStream = new ByteArrayInputStream("loginfirst".getBytes());
		}
		return SUCCESS;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public ByteArrayInputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(ByteArrayInputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String getUpasswd() {
		return upasswd;
	}

	public void setUpasswd(String upasswd) {
		this.upasswd = upasswd;
	}

	public UserService getUserService() {
		return userService;
	}

	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getEmailCode() {
		return emailCode;
	}

	public void setEmailCode(String emailCode) {
		this.emailCode = emailCode;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}
	
	public Map<String,Object> getSession(){
		return this.session;
	}

	public String getOpasswd() {
		return opasswd;
	}

	public void setOpasswd(String opasswd) {
		this.opasswd = opasswd;
	}

}
