package com.alijian.front.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 讲师
 * @author Frankie
 *
 */
@Entity
@Table(name = "lecturer")
public class LecturerModel {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public int id;
	
	@Column
	public String name;//讲师名字
	
	@Column
	public String birth;//讲师年龄
	
	@Column
	public String types;//讲师领域分类
	
	@Column
	public String thum;//讲师封面
	
	@Column
	public String description;//讲师简介

	@Transient
	public List<TypeModel> typeModels = new ArrayList<TypeModel>();

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

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
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

	public List<TypeModel> getTypeModels() {
		return typeModels;
	}

	public void setTypeModels(List<TypeModel> typeModels) {
		this.typeModels = typeModels;
	}
	
}
