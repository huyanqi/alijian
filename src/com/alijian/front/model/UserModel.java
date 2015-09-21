package com.alijian.front.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "user")
public class UserModel implements Serializable{
	
	private static final long serialVersionUID = 974967453615145826L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column
	private String username;
	
	@Column
	private String password;
	
	@Column
	private String name;		//名称
	
	@Column
	private String address;
	
	@Column
	private String mobile;
	
	@Column
	private int type = 2;		//账户类型:0 平台管理员 1供应商 2采购商(默认)
	
	@Column
	private int status = 0;		//如果type=1才判断此字段，0:待审核 1:审核通过
	
	@Column
	private String description;	//描述
	
	@Column
	private String thum;
	
	@Column
	private Date update_time = new Date();
	
	@Column
	private String types;
	
	@Column
	private BigDecimal credit_supplier;
	
	@Column
	private BigDecimal credit_buyer;
	
	@Column
	private Integer work_type = 0;		//0:供货商 1:阿里健自营(商品标题会显示"自营")
	
	@Column
	private Double commission;		//佣金比例
	
	@Transient
	private List<TypeModel> typeList;

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

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getThum() {
		return thum;
	}

	public void setThum(String thum) {
		this.thum = thum;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	public Integer getWork_type() {
		return work_type;
	}

	public void setWork_type(Integer work_type) {
		this.work_type = work_type;
	}

	public Double getCommission() {
		return commission;
	}

	public void setCommission(Double commission) {
		this.commission = commission;
	}

	public List<TypeModel> getTypeList() {
		return typeList;
	}

	public void setTypeList(List<TypeModel> typeList) {
		this.typeList = typeList;
	}

	public BigDecimal getCredit_supplier() {
		return credit_supplier;
	}

	public void setCredit_supplier(BigDecimal credit_supplier) {
		this.credit_supplier = credit_supplier;
	}

	public BigDecimal getCredit_buyer() {
		return credit_buyer;
	}

	public void setCredit_buyer(BigDecimal credit_buyer) {
		this.credit_buyer = credit_buyer;
	}

}
