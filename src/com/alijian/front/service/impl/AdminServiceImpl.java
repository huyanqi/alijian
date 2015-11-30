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
import com.alijian.front.model.LinkModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.PriceModel;
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
		if(!"".equals(model.startsCount)){
			//有设置价格区间
			PriceModel priceModel = new PriceModel();
			priceModel.startCount = model.startsCount;
			priceModel.endCount = model.endsCount;
			priceModel.price = model.prices;
			baseDao.saveOrUpdateModel(priceModel);
			model.price_id = priceModel.id;
		}
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
		model.setJyms(user.getJyms());
		model.setPpmc(user.getPpmc());
		model.setNyye(user.getNyye());
		model.setXsqy(user.getXsqy());
		model.setKhqt(user.getKhqt());
		model.setZcd(user.getZcd());
		model.setFddb(user.getFddb());
		model.setYgrs(user.getYgrs());
		model.setZycp(user.getZycp());
		model.setGold(user.getGold());
		
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

	@Override
	public List<TypeModel> getAllTypeModel() {
		return baseDao.getAllTypeModel();
	}

	@Override
	public String linkInsertOrUpdate(LinkModel model) {
		return baseDao.linkInsertOrUpdate(model);
	}

	@Override
	public LinkModel getLinkById(int id) {
		return baseDao.getLinkById(id);
	}

	@Override
	public String removeLinkById(int id) {
		return baseDao.removeLinkById(id);
	}

}
