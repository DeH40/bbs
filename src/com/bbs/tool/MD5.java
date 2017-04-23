package com.bbs.tool;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class MD5 {
	public static String binary(byte[] bytes, int radix) throws Exception {
		if (radix <= 1 || radix > 32)
			throw new Exception("进制有效范围2~32");

		return new BigInteger(1, bytes).toString(radix);// 这里的1代表正数
	}

	/**
	 * MD5 BASE64加密
	 * @param str
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	public static String EncoderByMD5(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		BASE64Encoder base64en = new BASE64Encoder();
		byte[] b = md5.digest(str.getBytes("UTF-8"));
		String newstr = base64en.encode(b);
		return newstr;
	}

	/**
	 * SHA1 BASE64加密
	 * @param str
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	public static String EncoderBySHA1(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		MessageDigest sha1 = MessageDigest.getInstance("SHA1");
		BASE64Encoder base64en = new BASE64Encoder();
		byte[] b = sha1.digest(str.getBytes("UTF-8"));
		String newstr = base64en.encode(b);
		return newstr;
	}

	/**
	 * MD5加密
	 * @param str
	 * @param radix
	 * @return
	 * @throws Exception
	 */
	public static String EncoderByMD5Direct(String str, int radix) throws Exception {
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		byte[] b = md5.digest(str.getBytes("UTF-8"));
		return binary(b, radix);
	}

	/**
	 * SHA1加密
	 * @param str
	 * @param radix
	 * @return
	 * @throws Exception
	 */
	public static String EncoderBySHA1Direct(String str, int radix) throws Exception {
		MessageDigest md5 = MessageDigest.getInstance("SHA1");
		byte[] b = md5.digest(str.getBytes("UTF-8"));
		return binary(b, radix);
	}

	/**
	 * BASE64加密
	 * @param str
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	public static String EncoderByBASE64(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		// 确定计算方法
		BASE64Encoder base64en = new BASE64Encoder();
		String newstr = base64en.encode(str.getBytes("UTF-8"));
		return newstr;
	}

	/**
	 * BASE64解密
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public static String DecoderByBASE64(String str) throws Exception {
		BASE64Decoder base64de = new BASE64Decoder();
		byte[] b = base64de.decodeBuffer(str);
		return new String(b);
	}
}
