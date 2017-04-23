package com.bbs.action;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.User;
import com.bbs.service.UserService;
import com.bbs.tool.FileUploaderUtil;
import com.bbs.tool.PathUtil;
import com.bbs.tool.RandomFileNameUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
@Component
@Scope("prototype")
public class UploadAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1250959702860185524L;
	public static final String[] ACCESS_IMAGE_TYPE = {"jpg","jpeg","gif","bmp","png"};
	 // 封装上传文件域的属性
    private File upload;
    // 封装上传文件类型的属性
    private String uploadContentType;
    private String uploadFileName;
    // 封装上传文件的属性
    private String uploadType;
    
    private ByteArrayInputStream inputStream;
    private String CKEditorFuncNum;
    
    private UserService userService;
    
    @Override
    public String execute() {
    	Map<String,Object> session = ActionContext.getContext().getSession();
    	Object obj = session.get(LoginAndRegAction.USER_IN_SESSION);
    	if(null == obj){
    		inputStream = new ByteArrayInputStream("请先登录".getBytes());
    		return SUCCESS;
    	}
    	User user = (User)obj;
    	String uid = user.getUid() + "";
    	
    	String fileType = getUploadContentType().split("/")[1];
    	
    	String path = PathUtil.getPath();
    	
    	String totalPath = null;
    	
    	String callbackInfo = null;
    	
    	/**
    	 * 是否为可接受的文件类型
    	 */
    	System.out.println(fileType);
    	if(!accessImageType(fileType)){
    		if(getUploadType().equals("userface")){
    			inputStream = new ByteArrayInputStream("文件类型不支持".getBytes());
        	}else if(getUploadType().equals("article")){
        		callbackInfo = "文件格式不正确（必须为.jpg/.gif/.bmp/.png文件）";
        		setInputStreamForCallbackError(callbackInfo);
        	}
    		return SUCCESS;
    	}
    	
    	String datePath = RandomFileNameUtil.getDatePathName();
    	String name = RandomFileNameUtil.getRandomName();
    	
    	/**
    	 * 上传文件 准备工作，文件名，路径名的获取
    	 */
    	if(getUploadType() != null && getUploadType().equals("userface")){
    		path = path + "userface" + File.separator;
    		totalPath = path + uid + "." + fileType;
    	}else if(getUploadType() == null){
    		path = path + "userimages" + File.separator + datePath + File.separator;
    		totalPath = path + name + "." + fileType;
    		System.out.println(path);
    		System.out.println(totalPath);
    	}
    	
    	/**
    	 * 上传文件
    	 */
    	boolean uploaded = FileUploaderUtil.upload(getUpload(), path, totalPath);
    	if(uploaded){
    		/**
    		 * 如果上传的是头像，曾修改数据库
    		 * 如果是用户发的帖子，则反馈回调函数
    		 */
    		if(getUploadType() != null && getUploadType().equals("userface")){
    			String url = PathUtil.getServletBasePath(ServletActionContext.getRequest());
    			userService.updateFace(url + "userface/" + uid + ".png", uid);
    			user = userService.login(user);
    			session.put(LoginAndRegAction.USER_IN_SESSION, user);
    			inputStream = new ByteArrayInputStream("上传成功".getBytes());
        	}else if(getUploadType() == null ){
        		String url = PathUtil.getServletBasePath(ServletActionContext.getRequest());
            	callbackInfo = url + "userimages" + "/" + datePath + "/" + name + "." + fileType;
            	setInputStreamForCallbackSuccess(callbackInfo);
        	}
    		
    	}else{
    		/**
    		 * 文件上传失败
    		 */
    		if(getUploadType() != null && getUploadType().equals("userface")){
    			inputStream = new ByteArrayInputStream("文件上传失败</br>".getBytes());
        	}else if(getUploadType() == null){
        		callbackInfo = "文件上传失败";
        		setInputStreamForCallbackError(callbackInfo);
        	}
    		
    	}
        return SUCCESS;
    }
    

    private boolean accessImageType(String type){
    	for(String typ:ACCESS_IMAGE_TYPE){
    		if(typ.equals(type)){
    			return true;
    		}
    	}
    	return false;
    }
    
    private String getCallback(String callbackInfo,boolean ok){
    	//上传成功回调函数模板callFunction(CKEditorFunNum,文件存放路径,'')
    	if(ok){
    		return "<script type=\"text/javascript\">window.parent.CKEDITOR.tools.callFunction(" + CKEditorFuncNum + ",'" + callbackInfo + "','');</script>";
    	}else{
    		//上传失败回调函数模板callFunction(CKEditorFunNum,'','错误原因')
    		return "<script type=\"text/javascript\">window.parent.CKEDITOR.tools.callFunction(" + CKEditorFuncNum + ",'','" + callbackInfo + "');</script>";
    	}
    }
    
    private void setInputStreamForCallbackError(String callbackInfo){
    	inputStream = new ByteArrayInputStream(getCallback(callbackInfo,false).getBytes());
    }
    private void setInputStreamForCallbackSuccess(String callbackInfo){
    	inputStream = new ByteArrayInputStream(getCallback(callbackInfo,true).getBytes());
    }
    
	public String getUploadType() {
		return uploadType;
	}
	public void setUploadType(String uploadType) {
		this.uploadType = uploadType;
	}
	public ByteArrayInputStream getInputStream() {
		return inputStream;
	}
	public void setInputStream(ByteArrayInputStream inputStream) {
		this.inputStream = inputStream;
	}
	public UserService getUserService() {
		return userService;
	}
	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}


	public String getCKEditorFuncNum() {
		return CKEditorFuncNum;
	}


	public void setCKEditorFuncNum(String cKEditorFuncNum) {
		CKEditorFuncNum = cKEditorFuncNum;
	}


}
