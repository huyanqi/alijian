package com.alijian.front.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * ��������
 * @author Administrator
 *
 */
@Entity
@Table(name = "orders_set")
public class OrdersSetModel {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column
	private String trade_no;//֧����������
	
	@Column
	private String orders_no;//���｡������
	
	@Column
	private BigDecimal prices = new BigDecimal(0);//�����ܶ�
	
	@Column
	private int buyer;//���ID
	
	@Column
	private int saller;//����ID
	
	@Column
	private String address;//�ʼĵ�ַ
	
	@Column
	private String mobile;//��ϵ���ֻ���
	
	@Column
	private String name;//��ϵ������
	
	@Column
	private Date create_time;//��������ʱ��
	
	@Column
	private Date update_time = new Date();
	
	@Column
	private int state = 0;//����״̬ 0:������ 1:�������(����Ѹ���ȴ����ҷ����������˿�) 2:�������(���ȷ���ջ����޷��˿������) 3:���˿� 4:�����ѷ������ȴ����ȷ��
	
	@Column
	private String cnumber;//��ݵ���
	
	@Column
	private int status;//״̬�� 0:��Ч 1:��Ч
	
	@ManyToOne
	@JoinColumn(name="pay_id")//����һ����Ϊ���
	private PayOrder payorder;
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "orderSetModel")
	@OrderBy("id")
	private List<OrdersModel> goods = new ArrayList<OrdersModel>();
	
	@Transient
	private List<OrdersModel> goodsList;
	
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

	public BigDecimal getPrices() {
		return prices;
	}

	public void setPrices(BigDecimal prices) {
		this.prices = prices;
	}

	public int getBuyer() {
		return buyer;
	}

	public void setBuyer(int buyer) {
		this.buyer = buyer;
	}

	public int getSaller() {
		return saller;
	}

	public void setSaller(int saller) {
		this.saller = saller;
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

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getCnumber() {
		return cnumber;
	}

	public void setCnumber(String cnumber) {
		this.cnumber = cnumber;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public PayOrder getPayorder() {
		return payorder;
	}

	public void setPayorder(PayOrder payorder) {
		this.payorder = payorder;
	}

	public List<OrdersModel> getGoods() {
		return goods;
	}

	public void setGoods(List<OrdersModel> goods) {
		this.goods = goods;
	}

	public String getTrade_no() {
		return trade_no;
	}

	public void setTrade_no(String trade_no) {
		this.trade_no = trade_no;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public List<OrdersModel> getGoodsList() {
		return goodsList;
	}

	public void setGoodsList(List<OrdersModel> goodsList) {
		this.goodsList = goodsList;
	}

}
