package com.alijian.front.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ����
 * @author Frankie
 *
 */
@Entity
@Table(name = "orders")
public class OrdersModel {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column
	private String orders_no;//������
	
	@Column
	private String trade_no;//֧�������׺�
	
	@Column
	private String goods_ids;//��������Ʒ�� ,����
	
	@Column
	private int amout;//��������
	
	@Column
	private Double prices;//�����ܶ�
	
	@Column
	private int buyer;//���ID
	
	@Column
	private String address;//�ʼĵ�ַ
	
	@Column
	private String mobile;//��ϵ���ֻ���
	
	@Column
	private String name;//��ϵ������
	
	@Column
	private String remark;//��ע
	
	@Column
	private Date create_time;//��������ʱ��
	
	@Column
	private Date update_time = new Date();//������ʱ��
	
	@Column
	private int state = 0;//����״̬ 0:������ 1:�������(�����˿�) 2:�������(�޷��˿�) 3:���˿� 

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOrders_no() {
		return orders_no;
	}

	public void setOrders_no(String orders_no) {
		this.orders_no = orders_no;
	}

	public String getGoods_ids() {
		return goods_ids;
	}

	public void setGoods_ids(String goods_ids) {
		this.goods_ids = goods_ids;
	}

	public Double getPrices() {
		return prices;
	}

	public void setPrices(Double prices) {
		this.prices = prices;
	}

	public int getBuyer() {
		return buyer;
	}

	public void setBuyer(int buyer) {
		this.buyer = buyer;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getAmout() {
		return amout;
	}

	public void setAmout(int amout) {
		this.amout = amout;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getTrade_no() {
		return trade_no;
	}

	public void setTrade_no(String trade_no) {
		this.trade_no = trade_no;
	}

	@Override
	public String toString() {
		return "OrdersModel [id=" + id + ", orders_no=" + orders_no
				+ ", trade_no=" + trade_no + ", goods_ids=" + goods_ids
				+ ", amout=" + amout + ", prices=" + prices + ", buyer="
				+ buyer + ", address=" + address + ", mobile=" + mobile
				+ ", name=" + name + ", remark=" + remark + ", create_time="
				+ create_time + ", update_time=" + update_time + ", state="
				+ state + "]";
	}
	
}
