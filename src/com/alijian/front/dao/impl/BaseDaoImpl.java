package com.alijian.front.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.alijian.front.dao.BaseDao;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.UserModel;

@Repository("baseDao")
public class BaseDaoImpl extends HibernateDaoSupport implements BaseDao {

	@Override
	public LecturerModel getLecturerModelById(int id) {
		List<LecturerModel> list = (List<LecturerModel>) getHibernateTemplate().find("FROM LecturerModel model WHERE model.id = ?", id);
		if(list.size() > 0)
			return list.get(0);
		return null;
	}

	@Override
	public String saveOrUpdateUser(UserModel model) {
		try{
			getHibernateTemplate().saveOrUpdate(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public UserModel getUserByUsername(String username) {
		List<UserModel> users = (List<UserModel>) getHibernateTemplate().find("FROM UserModel model WHERE model.username = ?", username);
		if(users.size() > 0)
			return users.get(0);
		else
			return null;
	}

	@Override
	public UserModel login(String username, String password) {
		List<UserModel> user = (List<UserModel>) getHibernateTemplate().find("FROM UserModel user WHERE user.username = ? AND user.password = ?", username, password);
		if(user.size() > 0)
			return user.get(0);
		return null;
	}

}
