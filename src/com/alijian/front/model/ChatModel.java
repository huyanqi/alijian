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
 * �����¼
 * @author Administrator
 *
 */
@Entity
@Table(name = "chatmodel")
public class ChatModel {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public int id;
	
	@Column
	public String targetid;//�Է�ID
	
	@Column
	public int type;//��Ϣ����
	
	@Column
	public int myid;//�ҵ�ID
	
	@Column
	public int ismy;//�Ƿ�Ϊ�ҵ���Ϣ 0:���˷����ҵ���Ϣ 1:�ҷ������˵���Ϣ
	
	@Column
	public Long sentTime;//��Ϣ����ʱ��
	
	@Column
	public Date time;
	
	@Column
	public String content;//��Ϣ����

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTargetid() {
		return targetid;
	}

	public void setTargetid(String targetid) {
		this.targetid = targetid;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getMyid() {
		return myid;
	}

	public void setMyid(int myid) {
		this.myid = myid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getIsmy() {
		return ismy;
	}

	public void setIsmy(int ismy) {
		this.ismy = ismy;
	}

	public Long getSentTime() {
		return sentTime;
	}

	public void setSentTime(Long sentTime) {
		this.sentTime = sentTime;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}
	
}
