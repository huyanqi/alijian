package com.alijian.front.dao;

import org.springframework.stereotype.Component;

import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.UserModel;

@Component
public interface BaseDao {

	LecturerModel getLecturerModelById(int id);

	String saveOrUpdateUser(UserModel model);

	UserModel getUserByUsername(String username);

	UserModel login(String username, String password);

}
