package com.alijian.front.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.alijian.front.model.BusinessModel;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.TypeModel;
import com.alijian.front.model.UserModel;

@Component
public interface AdminDao {

	boolean saveOrUpdateTypeModel(TypeModel model);

	List<TypeModel> getTypeModelByType(int type);

	TypeModel getTypeById(int id);

	String removeTypeById(int id);

	String insertLecturer(LecturerModel model);

	List<LecturerModel> getAllLecturers();

	String removeLecturerById(LecturerModel model);

	LecturerModel getLecturerById(int id);

	List<UserModel> getAllUser(int type, int status);

	UserModel getUserById(int uid);

	String insertGoods(GoodsModel model);

	PageModel getMyGoods(int uid, int pageNum);

	GoodsModel getGoodsById(int id);

	String removeGoods(GoodsModel model);

	List<GoodsModel> getGoods(int pageNum,int pageSize,String types, String keyword);

	String insertOrUpdateModel(Object object);

	String removeObject(Object obj);

}
