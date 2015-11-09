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
	private int goods_id;//��������Ʒ��(ֻ��������Ʒ)
	
	@Column
	private String amouts;//���������,����
	
	@Column
	private int amout;//��������
	
	@Column
	private BigDecimal prices;//�����ܶ�
	
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
	private String remark;//��ע
	
	@Column
	private Date create_time;//��������ʱ��
	
	@Column
	private Date update_time = new Date();//������ʱ��
	
	@Column
	private int state = 0;//����״̬ 0:������ 1:�������(����Ѹ���ȴ����ҷ����������Ƽ�) 2:�������(���ȷ���ջ����޷��˿������) 3:���˿� 4:�����ѷ������ȴ����ȷ��
	
	@Column
	private int is_mobile = 0;//�Ƿ�Ϊ�ֻ�����
	
	@Column
	private String cnumber;//��ݵ���
	
	@Column
	private int comment_id;//����ID
	
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
