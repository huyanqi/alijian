package com.alijian.front.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alijian.front.dao.AdminDao;
import com.alijian.front.dao.BaseDao;
import com.alijian.front.model.BusinessModel;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.TypeModel;
import com.alijian.front.model.UserModel;
import com.alijian.front.service.BaseService;

@Service("baseService")
@Transactional(rollbackFor = Exception.class)
public class BaseServiceImpl implements BaseService {

	@Autowired
	private BaseDao baseDao;
	
	@Autowired
	private AdminDao adminDao;

	@Override
	public LecturerModel getLecturerModelById(int id) {
		LecturerModel model = baseDao.getLecturerModelById(id);
		String[] types = model.getTypes().split(",");
		List<TypeModel> typeList = new ArrayList<TypeModel>();
		for(String type:types){
			TypeModel typeModel = adminDao.getTypeById(Integer.parseInt(type));
			if(typeModel != null)
				typeList.add(typeModel);
		}
		model.setTypeModels(typeList);
		return model;
	}

	@Override
	public String saveOrUpdateUser(UserModel model) {
		UserModel user = baseDao.getUserByUsername(model.getUsername());
		if(user == null)
			return baseDao.saveOrUpdateUser(model);
		else
			return "该用户名已被占用，请重新选择";
	}

	@Override
	public UserModel login(String username, String password) {
		return baseDao.login(username,password);
	}

	@Override
	public GoodsModel getGoodsModelById(int id) {
		GoodsModel model = adminDao.getGoodsById(id);
		String[] types = model.types.split(",");
		List<TypeModel> typeList = new ArrayList<TypeModel>();
		for(String type:types){
			TypeModel typeModel = adminDao.getTypeById(Integer.parseInt(type));
			if(typeModel != null)
				typeList.add(typeModel);
		}
		model.setTypeList(typeList);
		return model;
	}

	@Override
	public List<GoodsModel> getGoods(int pageNum,int pageSize,String types) {
		return adminDao.getGoods(pageNum,pageSize,types);
	}

	@Override
	public List<UserModel> getUsers(int pageSize, int type, int status) {
		return baseDao.getUsers(pageSize,type,status);
	}

	@Override
	public UserModel getUserById(int uid) {
		return baseDao.getUserById(uid);
	}

	@Override
	public List<BusinessModel> getBusinessModels(int pageNum, int pageSize,String types) {
		List<BusinessModel> models = baseDao.getBusinessModels(pageNum,pageSize,types);
		for(BusinessModel model:models){
			String[] types1 = model.getTypes().split(",");
			List<TypeModel> typeList = new ArrayList<TypeModel>();
			for(String type:types1){
				TypeModel typeModel = adminDao.getTypeById(Integer.parseInt(type));
				if(typeModel != null)
					typeList.add(typeModel);
			}
			model.setTypeModels(typeList);
		}
		return baseDao.getBusinessModels(pageNum,pageSize,types);
	}

	@Override
	public BusinessModel getBusinessById(int id) {
		return baseDao.getBusinessById(id);
	}

	@Override
	public List<UserModel> getSuppliers(int pageNum,int pageSize, String types) {
		return baseDao.getSuppliers(pageNum,pageSize,types);
	}

	@Override
	public List<LecturerModel> getLecturers(int pageNum, int pageSize,String types) {
		List<LecturerModel> models = baseDao.getLecturers(pageNum,pageSize,types);
		for(LecturerModel model:models){
			String[] types1 = model.getTypes().split(",");
			List<TypeModel> typeList = new ArrayList<TypeModel>();
			for(String type:types1){
				TypeModel typeModel = adminDao.getTypeById(Integer.parseInt(type));
				if(typeModel != null)
					typeList.add(typeModel);
			}
			model.setTypeModels(typeList);
		}
		return models;
	}

	@Override
	public UserModel getSupplierById(int uid) {
		UserModel model = baseDao.getSupplierById(uid);
		String[] types = model.getTypes().split(",");
		List<TypeModel> typeList = new ArrayList<TypeModel>();
		for(String type:types){
			TypeModel typeModel = adminDao.getTypeById(Integer.parseInt(type));
			if(typeModel != null)
				typeList.add(typeModel);
		}
		model.setTypeList(typeList);
		return model;
	}
	
}
