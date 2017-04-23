package com.bbs.tool;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

public class PathUtil {
	public static String getCurrentPath(){
		return PathUtil.class.getResource("").getPath();
	}
	
	public static String getBasePath(){
		String basePath =  PathUtil.class.getResource("/").getPath();
//		System.out.println("basePath:" + basePath);
		if(null != basePath && System.getProperty("os.name").contains("Windows")){
			basePath = basePath.substring(1);
			basePath = basePath.replaceAll("%20", " ");
			basePath = basePath.replaceAll("/", "\\\\");
		}
		return basePath;
	}
	
	public static String getPath(){
		String path = PathUtil.getBasePath();
		path = path.split("bbs")[0];
		path = path + "bbs";
		path = path + File.separator;
		return path;
	}
	
	public static String getServletBasePath(HttpServletRequest request){
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		return basePath;
	}
}
