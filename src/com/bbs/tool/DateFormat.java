package com.bbs.tool;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormat {
	public static String dateToString(Date time){ 
	    SimpleDateFormat formatter; 
	    formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss"); 
	    String ctime = formatter.format(time); 

	    return ctime; 
	} 
}
