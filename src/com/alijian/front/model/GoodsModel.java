package com.alijian.front.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

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
	public String price;	//����
	
	@Column
	public String units;	//��λ
	
	@Column
	public String freight;	//�˷ѷ�ʽ
	
	@Column
	public String thum;
	
	@Column
	public String description;
	
	@ManyToOne
    @JoinColumn(name="user")//����һ����Ϊ���
	public UserModel user;

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

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getUnits() {
		return units;
	}

	public void setUnits(String units) {
		this.units = units;
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
	
}
