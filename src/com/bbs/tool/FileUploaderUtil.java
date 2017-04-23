package com.bbs.tool;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class FileUploaderUtil {
	/**
	 * 
	 * @param file 要存储的文件
	 * @param path 文件存储的路径 当路径不存在时尝试创建
	 * @param totalPath	文件存储全路径
	 * @return
	 */
	public static boolean upload(File file,String path,String totalPath){
		FileInputStream fis = null;
		FileOutputStream fos = null;
		try {
			File f = new File(path);
			if(!f.exists()){
				f.mkdirs();
			}
			
			fos = new FileOutputStream(totalPath);
			// 建立文件上传流
			fis = new FileInputStream(file);
			
			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = fis.read(buffer)) > 0) {
			    fos.write(buffer, 0, len);
			}
		} catch (Exception e) {
			System.out.println(e);
			return false;
		}finally{
			if (fis != null) {
	            try {
	                fis.close();
	            } catch (IOException e) {
	                System.out.println("FileInputStream 关闭失败");
	                e.printStackTrace();
	            }
	        }
	        if (fos != null) {
	            try {
	                fos.close();
	            } catch (IOException e) {
	                System.out.println("FileOutputStream 关闭失败");
	                e.printStackTrace();
	            }
	        }
		}
		
		return true;
	}
}
