package com.bbs.action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.Reply;
import com.bbs.service.ReplyService;
import com.opensymphony.xwork2.ActionSupport;

@Component
@Scope("prototype")
public class SearchAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2024402278487490513L;
	
	private String query;
	private String index;
	private String pageSize;
	private int maxPageSize;
	private List<Reply> replys = new ArrayList<Reply>();
	private ReplyService replyService;
	
	@SuppressWarnings("unchecked")
	public String execute() throws UnsupportedEncodingException{
		if("".equals(query) || query == null){
			return SUCCESS;
		}
		query = new String(query.getBytes("iso-8859-1"),"utf-8");
		System.out.println("query: " + query);
		int pageSizeNum = 0;
		int indexNum = 0;
		try{
			pageSizeNum = Integer.parseInt(pageSize);
		}catch(Exception e){
			pageSizeNum = 5;
		}
		try{
			indexNum = Integer.parseInt(index);
		}catch(Exception e){
			indexNum = 1;
		}
		
		pageSizeNum = pageSizeNum < 1?1:pageSizeNum;
		String tableName = "reply";
		String limit = " where content like '%" + query + "%'";
		maxPageSize = replyService.getReplyDaoImpl().getMaxPage(pageSizeNum, tableName, limit);
		indexNum = indexNum<1?1:indexNum;
		indexNum = indexNum > maxPageSize?maxPageSize:indexNum;
		replys = (List<Reply>) replyService.getReplyDaoImpl().getAll(indexNum, maxPageSize, tableName, limit, Reply.class);
		index = indexNum + "";
		pageSize = pageSizeNum + "";
		System.out.println(index + ' ' + pageSize + ' ' + maxPageSize);
		return SUCCESS;
	}
	
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public List<Reply> getReplys() {
		return replys;
	}
	public void setReplys(List<Reply> replys) {
		this.replys = replys;
	}
	public ReplyService getReplyService() {
		return replyService;
	}
	@Resource
	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}

	public int getMaxPageSize() {
		return maxPageSize;
	}

	public void setMaxPageSize(int maxPageSize) {
		this.maxPageSize = maxPageSize;
	}

	public String getIndex() {
		return index;
	}

	public void setIndex(String index) {
		this.index = index;
	}

	public String getPageSize() {
		return pageSize;
	}

	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}

}
