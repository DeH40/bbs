package com.bbs.tool;

import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

public class JSONUtil {
	public static String forMap(HashMap<String, Object> params){
		return (new JSONObject(params)).toString();
	}
	
	public static String forString(String str){
		try {
			return new JSONObject(str).toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}

}
