package com.alijian.front.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.alijian.front.dao.AdminDao;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.TypeModel;
import com.alijian.front.model.UserModel;

@Repository("adminDao")
public class AdminDaoImpl extends HibernateDaoSupport implements AdminDao {

	@Override
	public boolean saveOrUpdateTypeModel(TypeModel model) {
		try{
			getHibernateTemplate().saveOrUpdate(model);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<TypeModel> getTypeModelByType(int type) {
		return (List<TypeModel>) getHibernateTemplate().find("FROM TypeModel model WHERE model.type = ?", type);
	}

	@Override
	public TypeModel getTypeById(int id) {
		List<TypeModel> models = (List<TypeModel>) getHibernateTemplate().find("FROM TypeModel model WHERE model.id = ?", id);
		if(models.size() > 0){
			return models.get(0);
		}
		return null;
	}

	@Override
	public String removeTypeById(int id) {
		try{
			getHibernateTemplate().delete(getTypeById(id));
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public String insertLecturer(LecturerModel model) {
		try{
			getHibernateTemplate().saveOrUpdate(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public List<LecturerModel> getAllLecturers() {
		List<LecturerModel> models = (List<LecturerModel>) getHibernateTemplate().find("FROM LecturerModel");
		for(LecturerModel model : models){
			String[] types = model.types.split(",");
			for(String type : types){
				model.typeModels.add(getTypeById(Integer.parseInt(type)));
			}
		}
		return models;
	}

	@Override
	public String removeLecturerById(LecturerModel model) {
		try{
			getHibernateTemplate().delete(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public LecturerModel getLecturerById(int id) {
		List<LecturerModel> models = (List<LecturerModel>) getHibernateTemplate().find("FROM LecturerModel model WHERE model.id = ?", id);
		if(models.size() > 0){
			return models.get(0);
		}
		return null;
	}

	@Override
	public List<UserModel> getAllUser(int type, int status) {
		List<UserModel> models = (List<UserModel>) getHibernateTemplate().find("FROM UserModel model WHERE model.type = ? AND model.status = ?", type,status);
		return models;
	}

	@Override
	public UserModel getUserById(int uid) {
		List<UserModel> models = (List<UserModel>) getHibernateTemplate().find("FROM UserModel model WHERE model.id = ?", uid);
		if(models.size() > 0)
			return models.get(0);
		return null;
	}

	@Override
	public String insertGoods(GoodsModel model) {
		try{
			getHibernateTemplate().save(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

}
