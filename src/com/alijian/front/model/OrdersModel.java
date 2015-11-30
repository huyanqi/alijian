package com.alijian.front.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 订单
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
	private int goods_id;//包含的商品号(只允许单个商品)
	
	@Column
	private String goods_type;//商品类型，如：白色、黑色
	
	@Column
	private int amout;//购买数量
	
	@Column
	private BigDecimal prices;//订单总额
	
	@Column
	private Date update_time = new Date();//最后更新时间
	
	@Transient
	private String remark;//备注
	
	@Column
	private int comment_id;//评论ID
	
	@ManyToOne
	@JoinColumn(name = "set_id")
	private OrdersSetModel orderSetModel;
	
	@Transient
	private GoodsModel goodsModel;
	
	@Transient
	private String address;//邮寄地址
	
	@Transient
	private String mobile;//联系人手机号
	
	@Transient
	private String name;//联系人名字
	
	@Column
	private int state = 0;//订单状态 0:待付款 1:付款完成(买家已付款、等待卖家发货，可以退款) 2:交易完成(买家确定收货、无法退款、可提现) 3:已退款 4:卖家已发货，等待买家确定

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}

	public String getGoods_type() {
		return goods_type;
	}

	public void setGoods_type(String goods_type) {
		this.goods_type = goods_type;
	}

	public int getAmout() {
		return amout;
	}

	public void setAmout(int amout) {
		this.amout = amout;
	}

	public BigDecimal getPrices() {
		return prices;
	}

	public void setPrices(BigDecimal prices) {
		this.prices = prices;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public int getComment_id() {
		return comment_id;
	}

	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}

	public OrdersSetModel getOrderSetModel() {
		return orderSetModel;
	}

	public void setOrderSetModel(OrdersSetModel orderSetModel) {
		this.orderSetModel = orderSetModel;
	}

	public GoodsModel getGoodsModel() {
		return goodsModel;
	}

	public void setGoodsModel(GoodsModel goodsModel) {
		this.goodsModel = goodsModel;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	
}
