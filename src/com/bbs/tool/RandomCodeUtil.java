package com.bbs.tool;

import java.util.Random;

public class RandomCodeUtil {
	/**
	 * 数字
	 */
	public final static String BASE_DIGIT_CODE = "0123456789";
	/**
	 * 字母
	 */
	public final static String BASE_LETTER_CODE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	/**
	 * 返回由数字组成，指定长度的字符串，请确保长度 <= 10
	 * @param length
	 * @return
	 */
	public static String getRandomDigitCode(int length){
		StringBuilder sb = new StringBuilder();
		Random r = new Random();
		for(int i=0;i<length;i++){
			int index = r.nextInt(length);
			sb.append(RandomCodeUtil.BASE_DIGIT_CODE.charAt(index));
		}
		return sb.toString();
	}
	
	/**
	 * 返回由字母组成，指定长度的字符串,请确保长度 <= 26
	 * @param length
	 * @return
	 */
	public static String getRandomLetterCode(int length){
		StringBuilder sb = new StringBuilder();
		Random r = new Random();
		for(int i=0;i<length;i++){
			int index = r.nextInt(length);
			sb.append(RandomCodeUtil.BASE_LETTER_CODE.charAt(index));
		}
		return sb.toString();
	}
	
	/**
	 * 返回由数字字母组成，指定长度的字符串，请确保长度 <= 26
	 * @param length
	 * @return
	 */
	public static String getRandomMixCode(int length){
		StringBuilder sb = new StringBuilder();
		Random r = new Random();
		int digit = 0;
		digit = length > 10 ? 10:length;
		for(int i=0;i<length;i++){
			int index = r.nextInt(length);
			if(index%2 == 0){
				index = r.nextInt(digit);
				sb.append(RandomCodeUtil.BASE_DIGIT_CODE.charAt(index));
			}else{
				sb.append(RandomCodeUtil.BASE_LETTER_CODE.charAt(index));
			}
		}
		return sb.toString();
	}
}
