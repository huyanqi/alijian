package com.alijian.front.service;

import org.springframework.stereotype.Component;

import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.UserModel;

@Component
public interface BaseService {

	LecturerModel getLecturerModelById(int id);

	String saveOrUpdateUser(UserModel model);

	UserModel login(String username, String password);

}
