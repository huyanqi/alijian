package com.alijian.front.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "user")
public class UserModel implements Serializable{
	
	private static final long serialVersionUID = 974967453615145826L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public int id;
	
	@Column
	public String username;
	
	@Column
	public String password;
	
	@Column
	public String name;		//名称
	
	@Column
	public String address;
	
	@Column
	public String mobile;
	
	@Column
	public int type = 2;		//账户类型:0 平台管理员 1供应商 2采购商(默认)
	
	@Column
	public int status = 0;		//如果type=1才判断此字段，0:待审核 1:审核通过

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
	
}
