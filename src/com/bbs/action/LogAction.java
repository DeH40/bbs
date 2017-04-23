package com.bbs.action;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bbs.model.UpdateLog;
import com.bbs.service.UpdateLogService;
import com.opensymphony.xwork2.ActionSupport;

@Component
@Scope("prototype")
public class LogAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 706658914335243801L;
	
	public static final String LOG_IN_REQUEST = "logs";
	
	private UpdateLogService updateLogService;
	
	private List<UpdateLog> logs;
	
	public String execute(){
		logs = updateLogService.getAll();
		return SUCCESS;
	}

	public UpdateLogService getUpdateLogService() {
		return updateLogService;
	}

	@Resource
	public void setUpdateLogService(UpdateLogService updateLogService) {
		this.updateLogService = updateLogService;
	}

	public List<UpdateLog> getLogs() {
		return logs;
	}

	public void setLogs(List<UpdateLog> logs) {
		this.logs = logs;
	}
	
	

}
