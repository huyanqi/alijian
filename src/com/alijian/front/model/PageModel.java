package com.alijian.front.model;

import java.util.List;


/**
 * @author Frankie
 *
 * ��ҳģ��
 */
public class PageModel {

	private List<?> models;
	
	private long pageCount;//��ҳ��ҳ��

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
