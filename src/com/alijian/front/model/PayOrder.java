package com.alijian.front.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * ֧������
 * @author Administrator
 *
 */
@Entity
@Table(name = "pay")
public class PayOrder {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="payorder")
	private List<OrdersSetModel> orderset;
	
	@Column
	private String trade_no;//֧����/΢�Ž��׺�
	
	@Column
	private String orders_no;//���｡������
	
	@Column
	private int is_mobile = 0;//�Ƿ�Ϊ�ֻ�����
	
	@Column
	private int status;//״̬�� 0:��Ч 1:��Ч
	
	@Transient
	private double price;//�����ܽ��
	
	@Column
	private Date update_time = new Date();

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<OrdersSetModel> getOrderset() {
		return orderset;
	}

	public void setOrderset(List<OrdersSetModel> orderset) {
		this.orderset = orderset;
	}

	public String getTrade_no() {
		return trade_no;
	}

	public void setTrade_no(String trade_no) {
		this.trade_no = trade_no;
	}

	public int getIs_mobile() {
		return is_mobile;
	}

	public void setIs_mobile(int is_mobile) {
		this.is_mobile = is_mobile;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getOrders_no() {
		return orders_no;
	}

	public void setOrders_no(String orders_no) {
		this.orders_no = orders_no;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	
}
