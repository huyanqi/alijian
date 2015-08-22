package com.alijian.front.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.alijian.front.model.BusinessModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.TypeModel;
import com.alijian.front.model.UserModel;

@Component
public interface BaseDao {

	LecturerModel getLecturerModelById(int id);

	String saveOrUpdateUser(UserModel model);

	UserModel getUserByUsername(String username);

	UserModel login(String username, String password);

	List<UserModel> getUsers(int pageSize, int type, int status);

	UserModel getUserById(int uid);

	List<BusinessModel> getBusinessModels(int pageNum, int pageSize,String types);

	BusinessModel getBusinessById(int id);

	List<UserModel> getSuppliers(int pageNum,int pageSize, String types);

	List<LecturerModel> getLecturers(int pageNum, int pageSize, String types);

	UserModel getSupplierById(int uid);

	List<TypeModel> getAllTypeModel();

}
