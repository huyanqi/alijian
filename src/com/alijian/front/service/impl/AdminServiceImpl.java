package com.alijian.front.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alijian.front.dao.AdminDao;
import com.alijian.front.dao.BaseDao;
import com.alijian.front.model.BusinessModel;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.TypeModel;
import com.alijian.front.model.UserModel;
import com.alijian.front.service.AdminService;

@Service("adminService")
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private BaseDao baseDao;
	
	@Override
	public boolean saveOrUpdateTypeModel(TypeModel model) {
		return adminDao.saveOrUpdateTypeModel(model);
	}

	@Override
	public List<TypeModel> getTypeModelByType(int type) {
		return adminDao.getTypeModelByType(type);
	}

	@Override
	public TypeModel getTypeById(int id) {
		return adminDao.getTypeById(id);
	}

	@Override
	public String removeTypeById(int id) {
		return adminDao.removeTypeById(id);
	}

	@Override
	public String insertLecturer(LecturerModel model) {
		return adminDao.insertLecturer(model);
	}

	@Override
	public List<LecturerModel> getAllLecturers() {
		return adminDao.getAllLecturers();
	}

	@Override
	public String removeLecturerById(int id) {
		LecturerModel model = adminDao.getLecturerById(id);
		if(model != null){
			return adminDao.removeLecturerById(model);
		}
		return "该讲师信息不存在";
	}

	@Override
	public List<UserModel> getAllUser(int type, int status) {
		return adminDao.getAllUser(type,status);
	}

	@Override
	public String supplierPass(int uid) {
		UserModel user = adminDao.getUserById(uid);
		if(user == null) return "没有此用户";
		user.setStatus(1);
		return baseDao.saveOrUpdateUser(user);
	}

	@Override
	public String insertGoods(GoodsModel model) {
		return adminDao.insertGoods(model);
	}

	@Override
	public PageModel getMyGoods(int uid, int pageNum) {
		return adminDao.getMyGoods(uid,pageNum);
	}

	@Override
	public String removeGoodsById(int id) {
		GoodsModel model = adminDao.getGoodsById(id);
		if(model == null){
			return "商品不存在";
		}
		return adminDao.removeGoods(model);
	}

	@Override
	public String updateUser(UserModel user) {
		UserModel model = adminDao.getUserById(user.getId());
		model.setName(user.getName());
		model.setAddress(user.getAddress());
		model.setMobile(user.getMobile());
		model.setDescription(user.getDescription());
		model.setThum(user.getThum());
		model.setTypes(user.getTypes());
		model.setWork_type(user.getWork_type());
		model.setCommission(user.getCommission());
		return baseDao.saveOrUpdateUser(model);
	}

	@Override
	public String insertOrUpdateModel(Object object) {
		return adminDao.insertOrUpdateModel(object);
	}

	@Override
	public String removeBusinessById(int id) {
		BusinessModel model = baseDao.getBusinessById(id);
		if(model == null) return "无此对象";
		return adminDao.removeObject(model);
	}

}
