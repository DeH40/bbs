package com.bbs.action;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ApplicationAware;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.hibernate.Session;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.User;
import com.bbs.model.UserGroup;
import com.bbs.service.UserService;
import com.bbs.tool.CookieUtils;
import com.bbs.tool.PathUtil;
import com.bbs.tool.SendEmailUtils;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Component
@Scope("prototype")
public class LoginAndRegAction extends ActionSupport
		implements RequestAware, SessionAware, ApplicationAware, ModelDriven<User> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final String USER_IN_SESSION = "user";
	private Map<String, Object> request;
	private Map<String, Object> session;
	private Map<String, Object> application;
	private UserService userService;
	private User user = new User();
	private String remember;
	private String uuid;
	private String randomCode;

	private HashMap<String,Object> jsonMap = new HashMap<String,Object>();

	public String login() {
		getJsonMap().put("status", "ok");
		String codeInSession = (String) session.get(ValidationCodeAction.RANDOM_CODE_IN_SESSION);
		if (codeInSession != null && codeInSession.toUpperCase().equals(randomCode.toUpperCase())) {
			User userFromDB = userService.login(user);
			if (null != userFromDB) {
				if (userFromDB.getActive() == User.UNACTIVE_FLAG) {
					getJsonMap().put("code", "needactive");
					return SUCCESS;
				}
				userFromDB.setUstat(User.USTAT_ONLINE);
				Session dbSession = userService.getUserDaoImpl().getSession();
				dbSession.update(userFromDB);
				dbSession.flush();
				session.put(USER_IN_SESSION, userFromDB);
				if (remember != null && remember.equals("rememberme")) {
					Cookie cookie = CookieUtils.addCookie(userFromDB);
					ServletActionContext.getResponse().addCookie(cookie);
				}
				getJsonMap().put("code", "success");
			} else {
				System.out.println("no user");
				getJsonMap().put("code", "nouser");
			}
		} else {
			getJsonMap().put("code", "codeerror");
		}
		return SUCCESS;
	}

	public String register() {
		getJsonMap().put("status", "ok");
		if (user.getUname().equals("") || user.getUpasswd().equals("") || user.getEmail().equals("")) {
			getJsonMap().put("code", "paramerror");
			return SUCCESS;
		}
		UserGroup ug = new UserGroup();
		ug.setId(2);
		user.setUgroup(ug);// 默认用户组
		this.userService.add(user);
		// session.put("user", user);
		if (user.getUid() == 0) {
			getJsonMap().put("code", "dberror");
			return SUCCESS;
		}
		String servletBasePath = PathUtil.getServletBasePath(ServletActionContext.getRequest());
		System.out.println(servletBasePath);
		System.out.println(PathUtil.getBasePath());
		SendEmailUtils.sendRegisterEmail(user.getEmail(), servletBasePath + "rl!active?uuid=" + user.getUid(),
				PathUtil.getBasePath(), "regcode.html");
		getJsonMap().put("code", "success");
		return SUCCESS;
	}

	public String active() {
		this.userService.active(uuid);
		return "activited";
	}

	public String logout() {
		session.remove("user");
		Cookie cookie = CookieUtils.delCookie(ServletActionContext.getRequest());
		if (cookie != null) {
			ServletActionContext.getResponse().addCookie(cookie);
		}
		return "logout";
	}

	@Override
	public void setApplication(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.application = arg0;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.session = arg0;
	}

	@Override
	public void setRequest(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		this.request = arg0;
	}

	@Override
	public User getModel() {
		// TODO Auto-generated method stub
		return this.getUser();
	}

	public Map<String, Object> getRequest() {
		return request;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public Map<String, Object> getApplication() {
		return application;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public UserService getUserService() {
		return userService;
	}

	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getRemember() {
		return remember;
	}

	public void setRemember(String remember) {
		this.remember = remember;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getRandomCode() {
		return randomCode;
	}

	public void setRandomCode(String randomCode) {
		this.randomCode = randomCode;
	}

	public HashMap<String,Object> getJsonMap() {
		return jsonMap;
	}

	public void setJsonMap(HashMap<String,Object> jsonMap) {
		this.jsonMap = jsonMap;
	}

}
