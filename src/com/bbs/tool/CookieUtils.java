package com.bbs.tool;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

import com.bbs.model.User;
import com.bbs.service.UserService;

public class CookieUtils {
	public static final String USER_COOKIE = "userCookie";

	public static Cookie addCookie(User user) {
		Cookie cookie = null;
		String uname;
		try {
			uname = MD5.EncoderByBASE64(user.getUname());
		} catch (Exception e) {
			e.printStackTrace();
			uname = "";
		} 
		cookie = new Cookie(USER_COOKIE, uname + "," + user.getUpasswd());

		//System.out.println("添加cookie");
		cookie.setPath("/bbs/");
		cookie.setDomain("localhost");
		cookie.setMaxAge(60 * 60 * 24 * 14);// cookie保存两周
		
		return cookie;
	}

	public static User getCookie(HttpServletRequest request, UserService userService) {
		Cookie[] cookies = request.getCookies();
		//System.out.println("cookies: " + cookies);
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				//System.out.println("cookie: " + cookie.getName());
				if (CookieUtils.USER_COOKIE.equals(cookie.getName())) {
					String value = cookie.getValue();
					if (StringUtils.isNotBlank(value)) {
						String[] split = value.split(",");
						String username = split[0];
						
						try {
							username = MD5.DecoderByBASE64(username);
						} catch (Exception e) {
							e.printStackTrace();
							username = "anonymous";
						} 
						
						String password = split[1];
						User temp = new User();
						temp.setUname(username);
						temp.setUpasswd(password);
						User user = userService.login(temp);
						
						if(user == null){
							CookieUtils.delCookie(request);
						}
						
						return user;
					}
				}
			}
		}
		return null;
	}

	public static Cookie delCookie(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (USER_COOKIE.equals(cookie.getName())) {
					cookie.setValue("");
					cookie.setPath("/bbs/");
					cookie.setDomain("localhost");
					cookie.setMaxAge(0);
					return cookie;
				}
			}
		}
		return null;
	}

}
