package com.bbs.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.User;
import com.bbs.tool.PathUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
@Component
@Scope("prototype")
public class TestUpload extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1250959702860185524L;
	 // 封装上传文件域的属性
    private File image;
    // 封装上传文件类型的属性
    private String imageContentType;
    // 封装上传文件名的属性
    private String imageFileName;
    @Override
    public String execute() {
    	System.out.println(imageContentType);
    	System.out.println(imageFileName);
        FileOutputStream fos = null;
        FileInputStream fis = null;
        try {
            // 建立文件输出流
        	Object obj = ActionContext.getContext().getSession().get(LoginAndRegAction.USER_IN_SESSION);
        	if(null == obj){
        		return INPUT;
        	}
        	String uid = ((User)obj).getUid() + "";
            String path = PathUtil.getPath();
            String type = getImageContentType().split("/")[1];
            path = path + "userface" + File.separator;
            File f = new File(path);
            if(!f.exists()){
            	f.mkdir();
            }
            fos = new FileOutputStream(path + uid + '.' + type);
            // 建立文件上传流
            fis = new FileInputStream(getImage());
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = fis.read(buffer)) > 0) {
                fos.write(buffer, 0, len);
            }
        } catch (Exception e) {
            System.out.println("文件上传失败");
            e.printStackTrace();
        } finally {
            close(fos, fis);
        }
        return SUCCESS;
    }
    public File getImage() {
        return image;
    }
    public void setImage(File image) {
        this.image = image;
    }
    public String getImageContentType() {
        return imageContentType;
    }
    public void setImageContentType(String imageContentType) {
        this.imageContentType = imageContentType;
    }
    public String getImageFileName() {
        return imageFileName;
    }
    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }
    private void close(FileOutputStream fos, FileInputStream fis) {
        if (fis != null) {
            try {
                fis.close();
            } catch (IOException e) {
                System.out.println("FileInputStream关闭失败");
                e.printStackTrace();
            }
        }
        if (fos != null) {
            try {
                fos.close();
            } catch (IOException e) {
                System.out.println("FileOutputStream关闭失败");
                e.printStackTrace();
            }
        }
    }

}
