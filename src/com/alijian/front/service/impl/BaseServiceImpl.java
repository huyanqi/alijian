package com.alijian.front.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alijian.front.dao.BaseDao;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.UserModel;
import com.alijian.front.service.BaseService;

@Service("baseService")
@Transactional(rollbackFor = Exception.class)
public class BaseServiceImpl implements BaseService {

	@Autowired
	private BaseDao baseDao;

	@Override
	public LecturerModel getLecturerModelById(int id) {
		return baseDao.getLecturerModelById(id);
	}

	@Override
	public String saveOrUpdateUser(UserModel model) {
		UserModel user = baseDao.getUserByUsername(model.username);
		if(user == null)
			return baseDao.saveOrUpdateUser(model);
		else
			return "该用户名已被占用，请重新选择";
	}

	@Override
	public UserModel login(String username, String password) {
		return baseDao.login(username,password);
	}
	
}
