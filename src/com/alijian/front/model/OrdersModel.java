package com.alijian.front.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
	private String orders_no;//订单号
	
	@Column
	private String trade_no;//支付宝交易号
	
	@Column
	private int goods_id;//包含的商品号(只允许单个商品)
	
	@Column
	private String amouts;//购买的数量,隔开
	
	@Column
	private int amout;//购买数量
	
	@Column
	private BigDecimal prices;//订单总额
	
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
	private String remark;//备注
	
	@Column
	private Date create_time;//订单生成时间
	
	@Column
	private Date update_time = new Date();//最后更新时间
	
	@Column
	private int state = 0;//订单状态 0:待付款 1:交易完成(买家已付款、等待卖家发货，可以推荐) 2:交易完成(买家确定收货、无法退款、可提现) 3:已退款 4:卖家已发货，等待买家确定
	
	@Column
	private int is_mobile = 0;//是否为手机订单
	
	@Column
	private String cnumber;//快递单号
	
	@Column
	private int comment_id;//评论ID
	
	public int getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}

	public String getCnumber() {
		return cnumber;
	}

	public void setCnumber(String cnumber) {
		this.cnumber = cnumber;
	}

	@Transient
	private GoodsModel goods;

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

	public int getGood_id() {
		return goods_id;
	}

	public void setGood_id(int good_id) {
		this.goods_id = good_id;
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

	public String getAmouts() {
		return amouts;
	}

	public void setAmouts(String amouts) {
		this.amouts = amouts;
	}

	public int getIs_mobile() {
		return is_mobile;
	}

	public void setIs_mobile(int is_mobile) {
		this.is_mobile = is_mobile;
	}

	public int getSaller() {
		return saller;
	}

	public void setSaller(int saller) {
		this.saller = saller;
	}

	public GoodsModel getGoods() {
		return goods;
	}

	public void setGoods(GoodsModel goods) {
		this.goods = goods;
	}

	public int getComment_id() {
		return comment_id;
	}

	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}

}
