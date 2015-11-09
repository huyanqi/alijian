package com.alijian.front.model;

import java.util.Date;
import java.util.List;

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
 * ��Ʒ
 * @author Frankie
 *
 */
@Entity
@Table(name = "goods")
public class GoodsModel {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public int id;
	
	@Column
	public String name;
	
	@Column
	public double price;	//����
	
	@Column
	public String units;	//��λ
	
	@Column
	public String types;	//��������
	
	@Column
	public String freight;	//�˷ѷ�ʽ
	
	@Column
	public String thum;
	
	@Column
	public String thums;//���Ÿ�ͼ,����
	
	@Column
	public String description;
	
	@Column
	public Date update_time = new Date();
	
	@Column
	public int sales_volume = 0;//����
	
	@Transient
	public List<TypeModel> typeList;
	
	@ManyToOne
    @JoinColumn(name="user")//����һ����Ϊ���
	public UserModel user;
	
	@Transient
	public String startsCount;//�����ۿ�ʼ��Χ,����
	
	@Transient
	public String endsCount;//�����۽�����Χ,����
	
	@Transient
	public String prices;//������,����
	
	@Transient
	public PriceModel priceModel;
	
	@Column
	public int price_id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getUnits() {
		return units;
	}

	public void setUnits(String units) {
		this.units = units;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	public String getFreight() {
		return freight;
	}

	public void setFreight(String freight) {
		this.freight = freight;
	}

	public String getThum() {
		return thum;
	}

	public void setThum(String thum) {
		this.thum = thum;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public UserModel getUser() {
		return user;
	}

	public void setUser(UserModel user) {
		this.user = user;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public List<TypeModel> getTypeList() {
		return typeList;
	}

	public void setTypeList(List<TypeModel> typeList) {
		this.typeList = typeList;
	}

	public int getSales_volume() {
		return sales_volume;
	}

	public void setSales_volume(int sales_volume) {
		this.sales_volume = sales_volume;
	}

	public int getPrice_id() {
		return price_id;
	}

	public void setPrice_id(int price_id) {
		this.price_id = price_id;
	}

	public String getStartsCount() {
		return startsCount;
	}

	public void setStartsCount(String startsCount) {
		this.startsCount = startsCount;
	}

	public String getEndsCount() {
		return endsCount;
	}

	public void setEndsCount(String endsCount) {
		this.endsCount = endsCount;
	}

	public String getPrices() {
		return prices;
	}

	public void setPrices(String prices) {
		this.prices = prices;
	}

	public PriceModel getPriceModel() {
		return priceModel;
	}

	public void setPriceModel(PriceModel priceModel) {
		this.priceModel = priceModel;
	}

	public String getThums() {
		return thums;
	}

	public void setThums(String thums) {
		this.thums = thums;
	}

}
