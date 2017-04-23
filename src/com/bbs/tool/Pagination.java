package com.bbs.tool;


import org.springframework.stereotype.Component;

import com.bbs.dao.impl.BaseImpl;

@Component
public class Pagination {
	/**
	 * 起始页码
	 */
	private int start;
	/**
	 * 每页显示数量
	 */
	private int pageSize;
	/**
	 * 页码
	 */
	private int index;
	/**
	 * 数据总量
	 */
	private int count;
	/**
	 * 最大页码数
	 */
	private int maxPageSize;
	/**
	 * 标识是否执行过getMaxPage方法
	 */
	private boolean isGetMaxPageExecuted = false;
	/**
	 * BaseImpl引用，使用前必须调用{@link com.bbs.tool.Pagination#init(BaseImpl)}
	 */
	private BaseImpl baseImpl;

	public Pagination init(BaseImpl baseImpl){
		this.baseImpl = baseImpl;
		return this;
	}
	
	/**
	 * 根据指定的页码，指定页面大小，指定的表名，指定的限制条件，计算出起始页，最大页码数<br/>
	 * 调用此方法前，请务必先调用{@link com.bbs.tool.Pagination#init(BaseImpl)}，否则可能会出现
	 * NullPointerException
	 * @param index
	 * @param pageSize
	 * @param tableName
	 * @param limit
	 */
	public void caculate(int index,int pageSize,String tableName,String limit) {
		if(!isGetMaxPageExecuted){
			this.getMaxPageSize(pageSize, tableName, limit);
		}
		
		this.index = index > this.maxPageSize ? this.maxPageSize : index;
		this.index = this.index <= 0 ? 1:this.index;
		if(this.index <= 0){
			this.index = 1;
		}
		start = (this.index - 1) * pageSize;
		
		//System.out.println(this.start +","+ this.index +"," +pageSize+","+count+","+maxPageSize);
	}
	
	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public BaseImpl getBaseImpl() {
		return baseImpl;
	}

	public void setBaseImpl(BaseImpl baseImpl) {
		this.baseImpl = baseImpl;
	}

	/**
	 * 获取指定表明，指定页面大小，指定限制条件的最大页码数量<br/>
	 * 使用前，请先调用{@link com.bbs.tool.Pagination#init(BaseImpl)}，否则可能会出现
	 * NullPointerException
	 * @param pageSize
	 * @param tableName
	 * @param limit
	 * @return int 最大页码数
	 */
	public int getMaxPageSize(int pageSize,String tableName,String limit) {
		if(pageSize <= 0){
			pageSize = 1;
		}
		this.pageSize = pageSize;
		if(limit == null ){
			this.count = this.baseImpl.getTableSize(tableName);
		}else{
			this.count = this.baseImpl.getTableSize(tableName, limit);
		}
		maxPageSize = (int) Math.ceil(count/(pageSize+0.0));
		//System.out.println("count: " + count + "pageSize: " + pageSize);
		isGetMaxPageExecuted = true;
		return maxPageSize;
	}

	public void setMaxPageSize(int maxPageSize) {
		this.maxPageSize = maxPageSize;
	}

}
