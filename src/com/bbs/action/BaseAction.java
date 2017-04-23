package com.bbs.action;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ApplicationAware;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.Catalog;
import com.bbs.model.Topic;
import com.bbs.model.UpdateLog;
import com.bbs.model.User;
import com.bbs.service.CatalogService;
import com.bbs.service.TopicService;
import com.bbs.service.UpdateLogService;
import com.bbs.service.UserService;
import com.bbs.tool.CookieUtils;
import com.opensymphony.xwork2.ActionSupport;

@Component
@Scope("prototype")
public class BaseAction extends ActionSupport 
implements RequestAware , SessionAware, ApplicationAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected Map<String, Object> request;
	protected Map<String, Object> session;
	protected Map<String, Object> application;
	
	protected CatalogService catalogService;
	protected TopicService topicService;
	protected UpdateLogService updateLogService;
	protected UserService userService;
	protected List<Catalog> catalogs;
	protected List<Topic> topics;
	protected List<Topic> tops;
	protected UpdateLog updateLog;
	
	
	protected int cid;
	protected int index;
	protected int pageSize;
	protected int maxPageSize;
	protected int[] catalogSize;
	private int[] topicSize;
	
	@Override
	public String execute() throws Exception {
		this.base();
		setPageSize(5);
		//不统计指定帖子
		String limit = " where cid = " + cid + " and top = '0'";
		maxPageSize = topicService.getTopicDaoImpl().getMaxPage(pageSize, "topic", limit);
		index = index > maxPageSize ? maxPageSize:index;
		topics = topicService.getAll(index, getPageSize(),cid);
		tops = topicService.getTop(cid);
		topicSize = new int[topics.size()+tops.size()];
		int i = 0;
		for(Topic t:tops){
			topicSize[i] = t.getTsize();
			i++;
		}
		for(Topic t:topics){
			topicSize[i] = t.getTsize();
			i++;
		}
		return SUCCESS;
	}
	
	/**
	 * 获取cid，
	 * 获取index，
	 * 获取目录
	 */
	protected void base(){
		cid = cid <=0 ?1:cid;
		cid = cid > catalogService.getSize() ?catalogService.getSize():cid;
		index = index < 1 ? 1:index;
		catalogs = catalogService.getAll();
		catalogSize = new int[catalogs.size()];
		for(int i=0;i<catalogs.size();i++){
			catalogSize[i] = catalogs.get(i).getCsize();
		}
		updateLog = updateLogService.getLatest();
		//System.out.println("session: --- "+session);
		if(null == session.get(LoginAndRegAction.USER_IN_SESSION)){
			User u = CookieUtils.getCookie(ServletActionContext.getRequest(), userService);
			if(null != u){
				session.put(LoginAndRegAction.USER_IN_SESSION, u);
			}
		}
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public CatalogService getCatalogService() {
		return catalogService;
	}

	@Resource
	public void setCatalogService(CatalogService catalogService) {
		this.catalogService = catalogService;
	}

	public List<Catalog> getCatalogs() {
		return catalogs;
	}

	public void setCatalogs(List<Catalog> catalogs) {
		this.catalogs = catalogs;
	}

	public TopicService getTopicService() {
		return topicService;
	}

	@Resource
	public void setTopicService(TopicService topicService) {
		this.topicService = topicService;
	}

	public List<Topic> getTopics() {
		return topics;
	}

	public void setTopics(List<Topic> topics) {
		this.topics = topics;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getMaxPageSize() {
		return maxPageSize;
	}

	public void setMaxPageSize(int maxPageSize) {
		this.maxPageSize = maxPageSize;
	}

	public int[] getCatalogSize() {
		return catalogSize;
	}

	public void setCatalogSize(int[] catalogSize) {
		this.catalogSize = catalogSize;
	}

	public int[] getTopicSize() {
		return topicSize;
	}

	public void setTopicSize(int[] topicSize) {
		this.topicSize = topicSize;
	}

	@Override
	public void setApplication(Map<String, Object> arg0) {
		this.application = arg0;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	@Override
	public void setRequest(Map<String, Object> arg0) {
		this.request = arg0;
	}

	public Map<String, Object> getRequest() {
		return request;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public Map<String, Object> getApplication() {
		return application;
	}

	public List<Topic> getTops() {
		return tops;
	}

	public void setTops(List<Topic> tops) {
		this.tops = tops;
	}

	public UpdateLogService getUpdateLogService() {
		return updateLogService;
	}

	@Resource
	public void setUpdateLogService(UpdateLogService updateLogService) {
		this.updateLogService = updateLogService;
	}

	public UpdateLog getUpdateLog() {
		return updateLog;
	}

	public void setUpdateLog(UpdateLog updateLog) {
		this.updateLog = updateLog;
	}

	public UserService getUserService() {
		return userService;
	}

	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	

}
