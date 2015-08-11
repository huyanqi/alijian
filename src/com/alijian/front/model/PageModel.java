package com.alijian.front.model;

import java.util.List;


/**
 * @author Frankie
 *
 * 分页模型
 */
public class PageModel {

	private List<?> models;
	
	private long pageCount;//分页总页数

	public List<?> getModels() {
		return models;
	}

	public void setModels(List<?> models) {
		this.models = models;
	}

	public long getPageCount() {
		return pageCount;
	}

	public void setPageCount(long pageCount) {
		this.pageCount = pageCount;
	}
	
}
