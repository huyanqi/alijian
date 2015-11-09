package com.alijian.front.model;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 
 * @author Frankie
 *
 * 价格区间
 */
@Entity
@Table(name = "price")
public class PriceModel {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public int id;
	
	@Column
	public String startCount;//开始数量,隔开
	
	@Column
	public String endCount;//结束数量,隔开
	
	@Column
	public String price;//价格,隔开
	
	@Transient
	public int start;
	
	@Transient
	public int end;
	
	@Transient
	public BigDecimal modelprice;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStartCount() {
		return startCount;
	}

	public void setStartCount(String startCount) {
		this.startCount = startCount;
	}

	public String getEndCount() {
		return endCount;
	}

	public void setEndCount(String endCount) {
		this.endCount = endCount;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public BigDecimal getModelprice() {
		return modelprice;
	}

	public void setModelprice(BigDecimal modelprice) {
		this.modelprice = modelprice;
	}

}
