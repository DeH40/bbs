package com.bbs.service;

import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.bbs.model.Catalog;
import com.bbs.model.Reply;
import com.bbs.model.Topic;
import com.bbs.model.User;
import com.bbs.tool.JSONUtil;
import com.bbs.tool.PathUtil;
import com.bbs.tool.SendEmailUtils;

public class ServiceTest {
	ApplicationContext ac1;

	@Before
	public void before() {
		ac1 = new FileSystemXmlApplicationContext("src\\beans.xml");
	}

	@Test
	public void test() {
		UserService us = (UserService) ac1.getBean("userService");
		User u = new User();
		u.setUname("users1");
		u.setUpasswd("1111");
		System.out.println(us);
		// us.add(u);
		System.out.println(us.login(u));
	}

	@Test
	public void testCatalog() {
		CatalogService cs = (CatalogService) ac1.getBean("catalogService");
		List<Catalog> catalogs = cs.getAll(1, 2);
		for (Catalog c : catalogs) {
			System.out.println(c);
		}
	}

	@Test
	public void testTopic() {
		TopicService ts = (TopicService) ac1.getBean("topicService");
		// List<Topic> catalogs = ts.getAll(0, 2);
		// System.out.println("------分割线------");
		// for (Topic c : catalogs) {
		// System.out.println(c);
		// }
		Topic t = new Topic();
		t.setCid(1);
		t.setTname("junit");

		// t.setUid(1);

		t = ts.add(t);

		System.out.println(t.getTid());

	}

	@Test
	public void testReply() {
		ReplyService ts = (ReplyService) ac1.getBean("replyService");
		List<Reply> reply = ts.getFloor(1, 3, "");
		System.out.println("------分割线------");
		for (Reply c : reply) {
			System.out.println(c.getUser());
			System.out.println(c.getPuser());
		}
	}

	@Test
	public void testReply2() {
		ReplyService ts = (ReplyService) ac1.getBean("replyService");
		List<Reply> reply = ts.getReply(1, 0);
		System.out.println("------分割线------");
		for (Reply c : reply) {
			System.out.println(c);
		}
	}

	@Test
	public void testReply3() {
		ReplyService ts = (ReplyService) ac1.getBean("replyService");
		List<Map<String, Object>> reply = ts.getTopic(1, 3, 0, "");
		System.out.println("------分割线------");
		for (Map<String, Object> temp : reply) {
			System.out.println(temp.get("floor"));
			for (Reply r : (List<Reply>) temp.get("reply")) {
				System.out.print("    ");
				System.out.println(r);
			}
		}
	}

	@Test
	public void testLog() {
		UpdateLogService us = (UpdateLogService) ac1.getBean("updateLogService");
		System.out.println(us.getLatest());
	}

	@Test
	public void testPath() throws IOException {
		System.out.println("-->" + PathUtil.getCurrentPath());
		String basePath = PathUtil.getBasePath();
		System.out.println("-->" + basePath);
		System.out.println(PathUtil.getPath());
	}

	@Test
	public void testEmail() {
		SendEmailUtils.sendRegisterEmail("2608027102@qq.com", "http://localhost/bbs/index", PathUtil.getBasePath(),
				"regcode.html");
	}

	@Test
	public void test1() {
		String str = "image/png";
		System.out.println(str.split("/")[1]);
	}

	@Test
	public void testJson() {
		HashMap<String,Object> params = new HashMap<String,Object>();
		HashMap<String,Object> params1 = new HashMap<String,Object>();
		params1.put("asdsa", "dsadas");
		params.put("status", "ok");
		params.put("code", "xxx");
		params.put("x",params1);
		
		System.out.println(JSONUtil.forMap(params));
		System.out.println(JSONUtil.forString("{a:a}"));
	}
	
	@Test
	public void testGetReply(){
		ReplyService ts = (ReplyService) ac1.getBean("replyService");
		//ts.getReplyDaoImpl().createSqlQueryForEntity("select * from reply where rid = 120", Reply.class);
		Reply r = (Reply) ts.getReplyDaoImpl().getOne(120, Reply.class);
		//System.out.println(r.getPreply());
		//System.out.println(r.getPreply().getRid());
		//System.out.println(r.getPreply().getPreply().getPreply());
		testSerializable(120);
	}
	public void testSerializable(Serializable id){
		System.out.println(id);
		System.out.println("a " + id + " b");
	}
	
	@Test
	public void testDeleteReply(){
		ReplyService ts = (ReplyService) ac1.getBean("replyService");
		//转baseimpl
		//ts.delete(136);
	}
	
	@Test
	public void testDeleteTopic(){
		TopicService ts = (TopicService) ac1.getBean("topicService");
		ts.getTopicDaoImpl().delete(37, Topic.class);
	}
	
	@Test
	public void testDeleteCatalog(){
		CatalogService cs = (CatalogService) ac1.getBean("catalogService");
		cs.getCatalogDaoImpl().delete(3, Catalog.class);
	}
}
