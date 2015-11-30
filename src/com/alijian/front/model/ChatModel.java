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
 * 聊天记录
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
	public String targetid;//对方ID
	
	@Column
	public int type;//消息类型
	
	@Column
	public int myid;//我的ID
	
	@Column
	public int ismy;//是否为我的消息 0:别人发给我的消息 1:我发给别人的消息
	
	@Column
	public Long sentTime;//消息发送时间
	
	@Column
	public Date time;
	
	@Column
	public String content;//消息内容

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
