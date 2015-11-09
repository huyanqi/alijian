package com.alijian.front.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.springframework.stereotype.Component;

import com.alijian.front.model.BusinessModel;
import com.alijian.front.model.BuyModel;
import com.alijian.front.model.ChatList;
import com.alijian.front.model.ChatModel;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.KeywordsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.LinkModel;
import com.alijian.front.model.UserModel;

@Component
public interface BaseService {

	LecturerModel getLecturerModelById(int id);

	String saveOrUpdateUser(UserModel model);

	UserModel login(String username, String password);

	GoodsModel getGoodsModelById(int id);

	List<GoodsModel> getGoods(int pageNum,int pageSize,String types, String keyword,int type,int supplier_id);

	List<UserModel> getUsers(int pageSize, int type, int status);

	UserModel getUserById(int uid);
	
	UserModel getUserByUsernameAndToken(HttpServletRequest request);

	List<BusinessModel> getBusinessModels(int pageNum, int pageSize,String types, String keyword);

	BusinessModel getBusinessById(int id);

	List<UserModel> getSuppliers(int pageNum,int pageSize, String types, String keyword);

	List<LecturerModel> getLecturers(int pageNum, int pageSize, String types, String keyword);

	UserModel getSupplierById(int uid);

	List<KeywordsModel> getKeyWords(int pageNum);

	List<LinkModel> getLinks();

	String insertBuyModel(BuyModel model);

	List<BuyModel> getBuyModels(int pageNum);

	String getWXSignature(String host, Long timestamp, String noncestr);

	boolean saveOrUpdate(ChatModel model);

	HttpResponse getIMToken(UserModel user);

	boolean saveOrUpdateModel(Object object);

	ChatList getChatListByIDs(int userid, int id);

	List<ChatList> getUserList(int userid);

	List<ChatModel> getchathistory(int id);

}
