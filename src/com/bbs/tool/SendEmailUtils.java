package com.bbs.tool;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.sun.mail.util.MailSSLSocketFactory;

public class SendEmailUtils {
	
	
	public static boolean sendRegisterEmail(String to,String code,String basePath,String filename) {
		File f = new File(basePath + filename);
		try {
			SendEmailUtils.sendEmailWithHTML(to, "感谢您的注册", f, code,basePath);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} 
		return true;
	}
	public static boolean sendResetPasswordEmail(String to,String href,String basePath,String filename,String subject){
		File f = new File(basePath + filename);
		try {
			SendEmailUtils.sendEmailWithHTML(to, subject, f, href,basePath);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} 
		return true;
	}
	
	
	/**
	 * 
	 * @param to 收件人
	 * @param subject 标题
	 * @param html HTML文件资源
	 * @param code 要发送的验证码
	 * @throws IOException
	 * @throws GeneralSecurityException
	 * @throws MessagingException
	 */
	public static void sendEmailWithHTML(String to,String subject,File html,String code,String basePath) throws IOException, GeneralSecurityException, MessagingException{
		if(!html.exists()){
			throw new FileNotFoundException(html.getName() + "文件未找到");
		}
		FileReader fr = new FileReader(html);
		BufferedReader br = new BufferedReader(fr);
		StringBuilder content = new StringBuilder("");
		String line = "";
		line = br.readLine();
		while(null != line){
			//System.out.println(line);
			line = line.replace("#placeholder#", code);
			content.append(line);
			line = br.readLine();
		}
		br.close();
		SendEmailUtils.sendEmailWithHTML(to, subject, content.toString(),basePath);
	}
	
	/**
	 * 
	 * @param to 收件人
	 * @param subject 主题
	 * @param html 要发送的HTML模板
	 * @throws IOException
	 * @throws GeneralSecurityException
	 * @throws MessagingException
	 */
	public static void sendEmailWithHTML(String to,String subject,File html,String basePath) throws IOException, GeneralSecurityException, MessagingException{
		if(!html.exists()){
			throw new FileNotFoundException(html.getName() + "文件未找到");
		}
		FileReader fr = new FileReader(html);
		BufferedReader br = new BufferedReader(fr);
		StringBuilder content = new StringBuilder();
		String line = "";
		line = br.readLine();
		while(null != line){
			content.append(line);
			line = br.readLine();
		}
		br.close();
		SendEmailUtils.sendEmailWithHTML(to, subject, content.toString(),basePath);
	}
	
	/**
	 * 
	 * @param to 收件人
	 * @param subject 标题
	 * @param html 要发送的HTML字符串
	 * @throws IOException
	 * @throws GeneralSecurityException
	 * @throws MessagingException
	 */
	public static void sendEmailWithHTML(String to,String subject,String html,String basePath) throws IOException, GeneralSecurityException, MessagingException{
		String propFileName = basePath + "mail.properties";
		File propFile = new File(propFileName);
		if(!propFile.exists()){
			throw new FileNotFoundException("默认邮件配置文件 mail.properties 未找到");
		}
		
		FileReader fr = new FileReader(propFile);
			
		
		final Properties props = new Properties();
		props.load(fr);

		// 开启ssl加密（并不是所有的邮箱服务器都需要，但是qq邮箱服务器是必须的）

		MailSSLSocketFactory msf = new MailSSLSocketFactory();

		msf.setTrustAllHosts(true);


		props.put("mail.smtp.ssl.socketFactory", msf);

		// 获取Session会话实例（javamail
		// Session与HttpSession的区别是Javamail的Session只是配置信息的集合）

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {

			protected PasswordAuthentication getPasswordAuthentication() {

				// 用户名密码验证（取得的授权吗）

				return new PasswordAuthentication(props.getProperty("from"), props.getProperty("authority"));

			}

		});

		// 抽象类MimeMessage为实现类 消息载体封装了邮件的所有消息

		Message message = new MimeMessage(session);

		// 设置邮件主题

		message.setSubject(subject);
		message.setHeader("charset", "utf-8");

		// 封装需要发送电子邮件的信息

		Multipart multipart=new MimeMultipart();
		
		//-------------------------------------------

        BodyPart messagePart=new MimeBodyPart();

        messagePart.setContent(html,"text/html;charset=utf-8");

        multipart.addBodyPart(messagePart);
        
        

        message.setContent(multipart);

		// 设置发件人地址

		message.setFrom(new InternetAddress(props.getProperty("from")));

		// 此类的功能是发送邮件 又会话获得实例

		Transport transport = session.getTransport();

		// 开启连接

		transport.connect();

		// 设置收件人地址邮件信息

		transport.sendMessage(message, new Address[] { new InternetAddress(to) });

		// 邮件发送后关闭信息

		transport.close();

	}
	
	/*public static void main(String[] args) throws Exception {
//		SendEmailUtils.sendEmailWithHTML("1120955357@qq.com", "测试中文","<h1>标题</h1>");
		File f = new File("test.html");
		SendEmailUtils.sendEmailWithHTML("2608027102@qq.com", "找回密码",f,"123456");
	}*/

}
