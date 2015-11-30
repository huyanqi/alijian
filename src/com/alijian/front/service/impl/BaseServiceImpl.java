package com.alijian.front.service.impl;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alijian.front.dao.AdminDao;
import com.alijian.front.dao.BaseDao;
import com.alijian.front.model.BusinessModel;
import com.alijian.front.model.BuyModel;
import com.alijian.front.model.ChatList;
import com.alijian.front.model.ChatModel;
import com.alijian.front.model.CommentsModel;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.KeywordsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.LinkModel;
import com.alijian.front.model.MyTypeModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.PriceModel;
import com.alijian.front.model.TypeModel;
import com.alijian.front.model.UserModel;
import com.alijian.front.service.BaseService;
import com.alijian.util.BaseData;
import com.alijian.util.MD5Util;
import com.alijian.util.SHA1;

@Service("baseService")
@Transactional(rollbackFor = Exception.class)
public class BaseServiceImpl implements BaseService {

	@Autowired
	private BaseDao baseDao;
	
	@Autowired
	private AdminDao adminDao;

	@Override
	public LecturerModel getLecturerModelById(int id) {
		LecturerModel model = baseDao.getLecturerModelById(id);
		String[] types = model.getTypes().split(",");
		List<TypeModel> typeList = new ArrayList<TypeModel>();
		for(String type:types){
			TypeModel typeModel = adminDao.getTypeById(Integer.parseInt(type));
			if(typeModel != null)
				typeList.add(typeModel);
		}
		model.setTypeModels(typeList);
		return model;
	}

	@Override
	public String saveOrUpdateUser(UserModel model) {
		UserModel user = baseDao.getUserByUsername(model.getUsername());
		if(user == null){
			if(model.getName() == null)
				model.setName(model.getUsername());
			model.setPassword(MD5Util.MD5(model.getPassword()));
			return baseDao.saveOrUpdateUser(model);
		}
		else
			return "该用户名已被占用，请重新选择";
	}

	@Override
	public UserModel login(String username, String password) {
		//MD5加密处理
		password = MD5Util.MD5(password);
		return baseDao.login(username,password);
	}

	@Override
	public GoodsModel getGoodsModelById(int id) {
		GoodsModel model = adminDao.getGoodsById(id);
		if(model == null) return model;
		String[] types = model.types.split(",");
		List<TypeModel> typeList = new ArrayList<TypeModel>();
		for(String type:types){
			TypeModel typeModel = adminDao.getTypeById(Integer.parseInt(type));
			if(typeModel != null)
				typeList.add(typeModel);
		}
		model.setTypeList(typeList);
		if(model.getPrice_id() != 0){
			//有价格区间
			PriceModel price = baseDao.getPriceModelById(model.getPrice_id());
			model.priceModel = price;
		}
		return model;
	}

	@Override
	public List<GoodsModel> getGoods(int pageNum,int pageSize,String types,String keyword,int type,int supplier_id) {
		List<GoodsModel> goodsList = adminDao.getGoods(pageNum,pageSize,types,keyword,type,supplier_id);
		//如果有批发价，则把price改为批发价，方便显示
		for(GoodsModel model : goodsList){
			if(model.price_id == 0) continue;
			PriceModel priceModel = baseDao.getPriceModelById(model.price_id);
			List<Double> tempList = new ArrayList<Double>();
			for(String price : priceModel.price.split(",")){
				tempList.add(Double.parseDouble(price));
			}
			model.show_price = Collections.min(tempList);
		}
		return goodsList;
	}

	@Override
	public List<UserModel> getUsers(int pageSize, int type, int status) {
		return baseDao.getUsers(pageSize,type,status);
	}

	@Override
	public UserModel getUserById(int uid) {
		return baseDao.getUserById(uid);
	}

	@Override
	public List<BusinessModel> getBusinessModels(int pageNum, int pageSize,String types,String keyword) {
		List<BusinessModel> models = baseDao.getBusinessModels(pageNum,pageSize,types,keyword);
		for(BusinessModel model:models){
			String[] types1 = model.getTypes().split(",");
			List<TypeModel> typeList = new ArrayList<TypeModel>();
			for(String type:types1){
				TypeModel typeModel = adminDao.getTypeById(Integer.parseInt(type));
				if(typeModel != null)
					typeList.add(typeModel);
			}
			model.setTypeModels(typeList);
		}
		return baseDao.getBusinessModels(pageNum,pageSize,types,keyword);
	}

	@Override
	public BusinessModel getBusinessById(int id) {
		return baseDao.getBusinessById(id);
	}

	@Override
	public List<UserModel> getSuppliers(int pageNum,int pageSize, String types, String keyword) {
		return baseDao.getSuppliers(pageNum,pageSize,types,keyword);
	}

	@Override
	public List<LecturerModel> getLecturers(int pageNum, int pageSize,String types,String keyword) {
		List<LecturerModel> models = baseDao.getLecturers(pageNum,pageSize,types,keyword);
		for(LecturerModel model:models){
			String[] types1 = model.getTypes().split(",");
			List<TypeModel> typeList = new ArrayList<TypeModel>();
			for(String type:types1){
				TypeModel typeModel = adminDao.getTypeById(Integer.parseInt(type));
				if(typeModel != null)
					typeList.add(typeModel);
			}
			model.setTypeModels(typeList);
		}
		return models;
	}

	@Override
	public UserModel getSupplierById(int uid) {
		UserModel model = baseDao.getSupplierById(uid);
		String[] types = model.getTypes().split(",");
		List<TypeModel> typeList = new ArrayList<TypeModel>();
		for(String type:types){
			if("".equals(type)) continue;
			TypeModel typeModel = adminDao.getTypeById(Integer.parseInt(type));
			if(typeModel != null)
				typeList.add(typeModel);
		}
		model.setTypeList(typeList);
		model.setMyTypesList(getMyTypeByUid(uid));
		return model;
	}

	@Override
	public List<KeywordsModel> getKeyWords(int pageNum) {
		return baseDao.getKeyWords(pageNum);
	}

	@Override
	public List<LinkModel> getLinks() {
		return baseDao.getLinks();
	}

	@Override
	public String insertBuyModel(BuyModel model) {
		return baseDao.saveOrUpdateModel(model);
	}

	@Override
	public List<BuyModel> getBuyModels(int pageNum) {
		return baseDao.getBuyModels(pageNum);
	}

	@Override
	public UserModel getUserByUsernameAndToken(HttpServletRequest request) {
		//通过username和accesstoen，获取用户信息
		Cookie[] cookies = request.getCookies();
		String username = null;
		String accesstoken = null;
		for (Cookie c : cookies) {
			if(c.getName().equals("username")){
				username = c.getValue();
				continue;
			}
			if(c.getName().equals("accesstoken")){
				accesstoken = c.getValue();
				continue;
			}
		}
		if(username == null || accesstoken == null){
			return null;
		}
		
		return baseDao.getUserByUsernameAndToken(username,accesstoken);
		
	}

	@Override
	public String getWXSignature(String host, Long timestamp, String noncestr) {
		//先检查之前存的ticket是否已经过期，过期才重新获取
		if(BaseData.WX_Expires_DATE != null){
			Date timeOut = BaseData.WX_Expires_DATE;
			if(timeOut.after(new Date())){
				//没有过期
				String string1 = "jsapi_ticket="+BaseData.WX_Ticket+"&noncestr="+noncestr+"&timestamp="+timestamp+"&url="+host;
				string1 = new SHA1().getDigestOfString(string1.getBytes());
				return string1.toLowerCase();
			}
		}
		String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wxd12014470a8088bc&secret=a02c97d0854bde422b4b4757dd0207de";
		HttpGet request = new HttpGet(url);
		try {
			HttpResponse response = HttpClients.createDefault().execute(request);
			if (response.getStatusLine().getStatusCode() == 200) {
				JSONObject result = JSONObject.fromObject(EntityUtils.toString(response.getEntity()));
				String access_token = result.getString("access_token");
				url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+access_token+"&type=jsapi";
				request = new HttpGet(url);
				response = HttpClients.createDefault().execute(request);
				if (response.getStatusLine().getStatusCode() == 200) {
					result = JSONObject.fromObject(EntityUtils.toString(response.getEntity()));
					String ticket = result.getString("ticket");
					//全局缓存ticket
					BaseData.WX_Ticket = ticket;
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(new Date());
					calendar.add(Calendar.SECOND, result.getInt("expires_in"));
					BaseData.WX_Expires_DATE = calendar.getTime();
					
					String string1 = "jsapi_ticket="+ticket+"&noncestr="+noncestr+"&timestamp="+timestamp+"&url="+host;
					string1 = new SHA1().getDigestOfString(string1.getBytes());
					return string1.toLowerCase();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean saveOrUpdate(ChatModel model) {
		try{
			List<ChatModel> exists = baseDao.getChatModelByIds(model.targetid,model.myid,model.ismy,model.content);
			//存在相同聊天内容，则不保存此次内容
			if(exists.size() > 0) return true;
			
			baseDao.saveOrUpdateModel(model);
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public HttpResponse getIMToken(UserModel user) {
		String url = "https://api.cn.ronghub.com/user/getToken.json";
		String noncestr = (Math.random()*100)+"";//生成随机数
		Long timestamp = new Date().getTime()/1000;
		String temp = "fmOLJHHFve8yx"+noncestr+timestamp;
		String signature = new SHA1().getDigestOfString(temp.getBytes()); 
		
		HttpPost request = new HttpPost(url);
		request.addHeader("App-Key", "n19jmcy59ovm9");
		request.addHeader("Nonce",noncestr);
		request.addHeader("Timestamp",timestamp+"");
		request.addHeader("Signature",signature);
		
		List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2);
		nameValuePairs.add(new BasicNameValuePair("userId", user.getId()+""));
		nameValuePairs.add(new BasicNameValuePair("name", user.getName() != null ? user.getName() : user.getUsername()));
		try {
			request.setEntity(new UrlEncodedFormEntity(nameValuePairs));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		
		try {
			HttpResponse response = HttpClients.createDefault().execute(request);
			return response;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean saveOrUpdateModel(Object object) {
		String result = baseDao.saveOrUpdateModel(object);
		if("".equals(result)) return true;
		return false;
	}

	@Override
	public ChatList getChatListByIDs(int targetid, int id) {
		return baseDao.getChatListByIDs(targetid,id);
	}

	@Override
	public List<ChatList> getUserList(int userid) {
		List<ChatList> list = baseDao.getUserList(userid);
		for(ChatList chat : list){
			UserModel model = baseDao.getUserById(chat.getTargetId());
			chat.setTargetModel(model);
		}
		return list;
	}

	@Override
	public List<ChatModel> getchathistory(int id) {
		return baseDao.getchathistory(id);
	}

	@Override
	public PageModel getMyComments(int uid, int pageNum) {
		PageModel model = baseDao.getMyComments(uid,pageNum);;
		List<CommentsModel> list = (List<CommentsModel>) model.getModels();
		for(CommentsModel models : list){
			if(models.fromuser != 0){
				models.setUserModel(baseDao.getUserById(models.fromuser));
			}
		}
		return model;
	}

	@Override
	public String downOrUpGoods(int goodsid,int userid) {
		GoodsModel goodsModel = getGoodsModelById(goodsid);
		if(goodsModel.user.getId() != userid) return "非法操作";
		goodsModel.setStatus(goodsModel.getStatus() == 1 ? 0 : 1);
		saveOrUpdateModel(goodsModel);
		return "";
	}

	@Override
	public String setdianzhao(String path, int uid) {
		try{
			UserModel user = getUserById(uid);
			user.setDianzhao((user.getDianzhao() != null && !"".equals(user.getDianzhao())) ? (user.getDianzhao() + "," + path) : path);
			saveOrUpdateUser(user);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public String removeDZ(int id, int index) {
		UserModel user = getUserById(id);
		String[] dzs = user.getDianzhao().split(",");
		user.setDianzhao("");
		for(int i=0;i<dzs.length;i++){
			if(index == i) continue;
			user.setDianzhao((user.getDianzhao() != null && !"".equals(user.getDianzhao())) ? user.getDianzhao()+","+dzs[i] : dzs[i]);
		}
		saveOrUpdateUser(user);
		return "";
	}

	@Override
	public List<MyTypeModel> getMyTypeByUid(int uid) {
		return baseDao.getMyTypeByUid(uid);
	}

	@Override
	public MyTypeModel getMyTypeById(int id) {
		return baseDao.getMyTypeById(id);
	}

	@Override
	public String removeMyTypeById(int id, int uid) {
		MyTypeModel model = baseDao.getMyTypeById(id);
		if(model.getUserid() != uid) return "非法操作，你没有删除此分类的权限";
		return baseDao.removeMyTypeById(model);
	}

	@Override
	public List<GoodsModel> getGoodsByMyType(int mytype,int pageNum,int pageSize) {
		return baseDao.getGoodsByMyType(mytype,pageNum,pageSize);
	}
}
