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
 * 订单集合
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
	private String trade_no;//支付宝订单号
	
	@Column
	private String orders_no;//阿里健订单号
	
	@Column
	private BigDecimal prices = new BigDecimal(0);//订单总额
	
	@Column
	private int buyer;//买家ID
	
	@Column
	private int saller;//卖家ID
	
	@Column
	private String address;//邮寄地址
	
	@Column
	private String mobile;//联系人手机号
	
	@Column
	private String name;//联系人名字
	
	@Column
	private Date create_time;//订单生成时间
	
	@Column
	private Date update_time = new Date();
	
	@Column
	private int state = 0;//订单状态 0:待付款 1:付款完成(买家已付款、等待卖家发货，可以退款) 2:交易完成(买家确定收货、无法退款、可提现) 3:已退款 4:卖家已发货，等待买家确定
	
	@Column
	private String cnumber;//快递单号
	
	@Column
	private int status;//状态码 0:有效 1:无效
	
	@ManyToOne
	@JoinColumn(name="pay_id")//加入一列作为外键
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
