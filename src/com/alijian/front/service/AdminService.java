package com.alijian.front.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.TypeModel;
import com.alijian.front.model.UserModel;

@Component
public interface AdminService {

	boolean saveOrUpdateTypeModel(TypeModel model);

	List<TypeModel> getTypeModelByType(int type);

	TypeModel getTypeById(int id);

	String removeTypeById(int id);

	String insertLecturer(LecturerModel model);

	List<LecturerModel> getAllLecturers();

	String removeLecturerById(int id);

	List<UserModel> getAllUser(int type, int status);

	String supplierPass(int uid);

	String insertGoods(GoodsModel model);

	PageModel getMyGoods(int uid,int pageNum);

	String removeGoodsById(int id);

	String updateUser(UserModel user);

	String insertOrUpdateModel(Object object);

	String removeBusinessById(int id);

	List<TypeModel> getAllTypeModel();

}
