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
	private int goods_id;//��������Ʒ��(ֻ��������Ʒ)
	
	@Column
	private String goods_type;//��Ʒ���ͣ��磺��ɫ����ɫ
	
	@Column
	private int amout;//��������
	
	@Column
	private BigDecimal prices;//�����ܶ�
	
	@Column
	private Date update_time = new Date();//������ʱ��
	
	@Transient
	private String remark;//��ע
	
	@Column
	private int comment_id;//����ID
	
	@ManyToOne
	@JoinColumn(name = "set_id")
	private OrdersSetModel orderSetModel;
	
	@Transient
	private GoodsModel goodsModel;
	
	@Transient
	private String address;//�ʼĵ�ַ
	
	@Transient
	private String mobile;//��ϵ���ֻ���
	
	@Transient
	private String name;//��ϵ������
	
	@Column
	private int state = 0;//����״̬ 0:������ 1:�������(����Ѹ���ȴ����ҷ����������˿�) 2:�������(���ȷ���ջ����޷��˿������) 3:���˿� 4:�����ѷ������ȴ����ȷ��

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
