package com.alijian.front.model;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 聊天列表
 * @author Administrator
 *
 */
@Entity
@Table(name = "chatlist")
public class ChatList {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public int id;
	
	@Column
	public int targetId;//对方id
	
	@Column
	public int myid;//我的ID
	
	@Transient
	public UserModel targetModel;//聊天对象
	
	@Column
	public Date update_time = new Date();

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTargetId() {
		return targetId;
	}

	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}

	public int getMyid() {
		return myid;
	}

	public void setMyid(int myid) {
		this.myid = myid;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public UserModel getTargetModel() {
		return targetModel;
	}

	public void setTargetModel(UserModel targetModel) {
		this.targetModel = targetModel;
	}


}
