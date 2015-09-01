package com.alijian.front.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.alijian.front.model.BusinessModel;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.KeywordsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.UserModel;

@Component
public interface BaseService {

	LecturerModel getLecturerModelById(int id);

	String saveOrUpdateUser(UserModel model);

	UserModel login(String username, String password);

	GoodsModel getGoodsModelById(int id);

	List<GoodsModel> getGoods(int pageNum,int pageSize,String types, String keyword);

	List<UserModel> getUsers(int pageSize, int type, int status);

	UserModel getUserById(int uid);

	List<BusinessModel> getBusinessModels(int pageNum, int pageSize,String types, String keyword);

	BusinessModel getBusinessById(int id);

	List<UserModel> getSuppliers(int pageNum,int pageSize, String types, String keyword);

	List<LecturerModel> getLecturers(int pageNum, int pageSize, String types, String keyword);

	UserModel getSupplierById(int uid);

	List<KeywordsModel> getKeyWords(int pageNum);

}
