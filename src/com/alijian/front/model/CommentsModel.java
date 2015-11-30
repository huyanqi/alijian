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
 * ���԰�
 * @author Frankie
 *
 */
@Entity
@Table(name = "comments")
public class CommentsModel {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public int id;
	
	@Column
	public String content;//��������
	
	@Column
	public int touser;//�������Ե��û�/�̻�ID
	
	@Column
	public int fromuser;//�������Ե��û�ID
	
	@Column
	public Date update_time = new Date();
	
	@Transient
	public UserModel userModel;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getTouser() {
		return touser;
	}

	public void setTouser(int touser) {
		this.touser = touser;
	}

	public int getFromuser() {
		return fromuser;
	}

	public void setFromuser(int fromuser) {
		this.fromuser = fromuser;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public UserModel getUserModel() {
		return userModel;
	}

	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}
	
}
