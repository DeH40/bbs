package com.bbs.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class AuthorityInterceptor extends AbstractInterceptor{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String intercept(ActionInvocation arg0) throws Exception {
		Object user = ActionContext.getContext().getSession().get("user");
		if(null == user){
			return ActionSupport.LOGIN;
		}
		System.out.println("user" + user);
		return arg0.invoke();
	}

}
