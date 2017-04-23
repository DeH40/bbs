package com.bbs.tool;

import java.text.SimpleDateFormat;
import java.util.Random;

public class RandomFileNameUtil {
	public static String getRandomName(){
		String time = new SimpleDateFormat("yyyyMMddHHmm").format(System.currentTimeMillis()) + "";
		
		Random r = new Random();
		int l = r.nextInt(10000);
		
		return time + l;
	}
	
	public static String getDatePathName(){
		String time = new SimpleDateFormat("yyyyMMdd").format(System.currentTimeMillis()) + "";
		return time;
	}

}
