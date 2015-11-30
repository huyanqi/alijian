package com.alijian.front.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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
import com.alijian.front.model.UserModel;
import com.alijian.front.service.BaseService;
import com.alijian.util.BaseData;
import com.alijian.util.HttpRequestDeviceUtils;
import com.alijian.util.MD5Util;
import com.alijian.util.Tools;

@Controller
@RequestMapping
public class BaseController extends BaseData {

	@Autowired
	private BaseService baseService;

	@RequestMapping(value = "/fileupload")
	public ModelAndView fileupload(@RequestParam("upload") MultipartFile file,
			HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		File newFile = null;
		String fileName = null;

		if (!file.isEmpty()) {
			if (file.getSize() > Integer.MAX_VALUE) {
				obj.put(RESULT, NO);
				obj.put(DATA, "文件太大,请压缩后上传.");
				view.addObject(DATA, obj);
				return view;
			}

			fileName = file.getOriginalFilename();
			String suffix = fileName.substring(fileName.lastIndexOf("."),
					fileName.length());
			fileName = Tools.generateRandomFilename() + suffix;

			String directory = request.getSession().getServletContext()
					.getRealPath("images");

			// 确定写出文件的目录位置
			System.out.println(directory);
			newFile = new File(directory, fileName);
			if (!newFile.exists()) {// 判断文件目录是否存在
				newFile.mkdirs();
			}
			try {
				file.transferTo(newFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}

		obj.put(RESULT, OK);
		obj.put(DATA, Tools.getFilePath(fileName, request));
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/ckfileupload")
	public void ckfileupload(@RequestParam("upload") MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) {
		File newFile = null;
		String fileName = null;

		if (!file.isEmpty()) {

			fileName = file.getOriginalFilename();
			String suffix = fileName.substring(fileName.lastIndexOf("."),
					fileName.length());
			fileName = Tools.generateRandomFilename() + suffix;

			String directory = request.getSession().getServletContext()
					.getRealPath("images");

			// 确定写出文件的目录位置
			newFile = new File(directory, fileName);
			if (!newFile.exists()) {// 判断文件目录是否存在
				newFile.mkdirs();
			}
			try {
				file.transferTo(newFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}

		String callback = request.getParameter("CKEditorFuncNum");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out;
		try {
			out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("window.parent.CKEDITOR.tools.callFunction(" + callback
					+ ",'" + Tools.getFilePath(fileName, request) + "','')"); // 相对路径用于显示图片
			out.println("</script>");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/getLecturerModelById")
	public ModelAndView getLecturerModelById(int id) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		LecturerModel model = baseService.getLecturerModelById(id);
		if (model != null) {
			obj.put(RESULT, OK);
			obj.put(DATA, model);
		} else {
			obj.put(RESULT, NO);
			obj.put(DATA, "获取信息失败，请联系管理员");
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/login")
	public ModelAndView login(@RequestBody UserModel model,
			HttpServletResponse response, HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		model = baseService.login(model.getUsername(), model.getPassword());
		if (model != null) {
			obj.put(RESULT, OK);
			obj.put(DATA, model);
			model.setAccesstoken(Tools.getAccessToken());
			// 清除残留cookie
			Cookie[] cookies = request.getCookies();
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = new Cookie(cookies[i].getName(), null);
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}

			//set cookie's age to 120 days: 120 * 24 * 60 * 60 * 60 seconds
			int cookieTime = 120 * 24 * 60 * 60 * 60;
			Cookie tokenCookie = new Cookie("accesstoken",model.getAccesstoken());
			tokenCookie.setMaxAge(cookieTime);
			Cookie cookie = new Cookie("uid", model.getId() + "");
			cookie.setMaxAge(cookieTime);
			Cookie roleCookie = new Cookie("role", model.getType() + "");
			roleCookie.setMaxAge(cookieTime);
			try {
				Cookie usernameCookie = new Cookie("username", URLEncoder.encode(model.getUsername(), "utf-8"));
				usernameCookie.setMaxAge(cookieTime);
				Cookie nameCookie = new Cookie("name",model.getName() != null ? URLEncoder.encode(model.getName(), "utf-8") : URLEncoder.encode(model.getUsername(), "utf-8"));
				nameCookie.setMaxAge(cookieTime);
				response.addCookie(usernameCookie);
				response.addCookie(nameCookie);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			response.addCookie(tokenCookie);
			response.addCookie(cookie);
			response.addCookie(roleCookie);

			baseService.saveOrUpdateUser(model);

			request.getSession().setAttribute(SESSION_USER, model);
		} else {
			obj.put(RESULT, NO);
			obj.put(DATA, "该用户不存在或密码错误");
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpServletResponse response,
			HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		request.getSession().removeAttribute("user");
		Cookie[] cookies = request.getCookies();
		for (Cookie cookie : cookies) {
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}

		JSONObject obj = new JSONObject();
		obj.put(RESULT, OK);
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/regUser")
	public ModelAndView regUser(@RequestBody UserModel model) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		String result = baseService.saveOrUpdateUser(model);
		if ("".equals(result)) {
			obj.put(RESULT, OK);
		} else {
			obj.put(RESULT, NO);
			obj.put(DATA, result);
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/getSession")
	public ModelAndView getSession(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();

		UserModel user = (UserModel) request.getSession().getAttribute("user");
		if (user != null) {
			obj.put(RESULT, OK);
			obj.put(DATA, user);
		} else {
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/getGoodsModelById")
	public ModelAndView getGoodsModelById(int id) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		GoodsModel goods = baseService.getGoodsModelById(id);
		if (goods != null) {
			obj.put(RESULT, OK);
			obj.put(DATA, goods);
		} else {
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS, obj);
		return view;
	}

	/**
	 * 
	 * @param pageNum
	 *            当前页数
	 * @param pageSize
	 *            每页大小
	 * @param types
	 *            商品分类(,隔开)
	 * @param keyword
	 *            搜索关键字
	 * @param type
	 *            搜索类型:0 默认 1：价格从低到高 2：价格从高到低 3：销量从高到低
	 * @param supplier_id
	 *            商家ID号
	 * @return
	 */
	@RequestMapping(value = "/getGoods")
	public ModelAndView getGoods(int pageNum, int pageSize, String types,String keyword, int type, int supplierid) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		List<GoodsModel> goods = baseService.getGoods(pageNum, pageSize, types,
				keyword, type, supplierid);
		if (goods != null) {
			obj.put(RESULT, OK);
			obj.put(DATA, goods);
		} else {
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/getUsers")
	public ModelAndView getUsers(int pageSize, int type, int status) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		List<UserModel> users = baseService.getUsers(pageSize, type, status);
		if (users != null) {
			obj.put(RESULT, OK);
			obj.put(DATA, users);
		} else {
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/getUserById")
	public ModelAndView getUserById(int uid) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		UserModel user = baseService.getUserById(uid);
		if (user != null) {
			obj.put(RESULT, OK);
			obj.put(DATA, user);
		} else {
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/getBusinessModels")
	public ModelAndView getBusinessModels(int pageNum, int pageSize,
			String types, String keyword) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		List<BusinessModel> models = baseService.getBusinessModels(pageNum,
				pageSize, types, keyword);
		if (models.size() > 0) {
			obj.put(RESULT, OK);
			obj.put(DATA, models);
		} else {
			obj.put(RESULT, NO);
			obj.put(DATA, "无数据");
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/getBusinessById")
	public ModelAndView getBusinessById(int id) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		BusinessModel model = baseService.getBusinessById(id);
		if (model != null) {
			obj.put(RESULT, OK);
			obj.put(DATA, model);
		} else {
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS, obj);
		return view;
	}

	/**
	 * 搜索商家
	 * 
	 * @param pageSize
	 *            每页大小
	 * @param types
	 *            包含类型
	 * @return
	 */
	@RequestMapping(value = "/getSuppliers")
	public ModelAndView getSuppliers(int pageNum, int pageSize, String types,
			String keyword) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		List<UserModel> models = baseService.getSuppliers(pageNum, pageSize,
				types, keyword);
		if (models.size() > 0) {
			jObj.put(RESULT, OK);
			jObj.put(DATA, models);
		} else {
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS, jObj);
		return view;
	}

	@RequestMapping(value = "/getLecturers")
	public ModelAndView getLecturers(int pageNum, int pageSize, String types,
			String keyword) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		List<LecturerModel> models = baseService.getLecturers(pageNum,
				pageSize, types, keyword);
		if (models.size() > 0) {
			jObj.put(RESULT, OK);
			jObj.put(DATA, models);
		} else {
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS, jObj);
		return view;
	}

	@RequestMapping(value = "/getSupplierById")
	public ModelAndView getSupplierById(int uid) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		UserModel user = baseService.getSupplierById(uid);
		if (user != null) {
			obj.put(RESULT, OK);
			obj.put(DATA, user);
		} else {
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/getKeyWords")
	public ModelAndView getKeyWords(int pageNum) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		List<KeywordsModel> keywords = baseService.getKeyWords(pageNum);
		if (keywords.size() > 0) {
			obj.put(RESULT, OK);
			obj.put(DATA, keywords);
		} else {
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/getLinks")
	public ModelAndView getLinks() {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		List<LinkModel> links = baseService.getLinks();
		if (links.size() > 0) {
			obj.put(RESULT, OK);
			obj.put(DATA, links);
		} else {
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS, obj);
		return view;
	}

	@RequestMapping(value = "/insertBuyModel")
	public ModelAndView insertBuyModel(@RequestBody BuyModel model) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = baseService.insertBuyModel(model);
		if (result.equals("")) {
			jObj.put(RESULT, OK);
		} else {
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS, jObj);
		return view;
	}

	@RequestMapping(value = "/getBuyModels")
	public ModelAndView getBuyModels(int pageNum) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		List<BuyModel> models = baseService.getBuyModels(pageNum);
		if (models.size() > 0) {
			jObj.put(RESULT, OK);
			jObj.put(DATA, models);
		} else {
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS, jObj);
		return view;
	}

	@RequestMapping(value = "/genSig")
	public ModelAndView genSig(HttpServletRequest request, String timestamp,
			String username) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		System.out.println(username + "请求登录IM.");
		String sig = YUNTONGXUN_IM_APPID + username + timestamp
				+ YUNTONGXUN_IM_APPTOKEN;
		sig = MD5Util.MD5(sig);
		jObj.put("code", 000000);
		jObj.put("sig", sig);
		view.addObject(MODELS, jObj);
		return view;
	}

	@RequestMapping(value = "/getWXSignature")
	public ModelAndView getWXSignature(String host,Long timestamp,String noncestr) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String ticket = baseService.getWXSignature(host,timestamp,noncestr);
		jObj.put(DATA, ticket);
		view.addObject(MODELS, jObj);
		return view;
	}
	
	/**
	 * 保存聊天记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/savechathistory")
	public ModelAndView savechathistory(@RequestBody ChatModel model,HttpSession session,HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(MODELS, "welcome");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		model.setMyid(user.getId());
		model.setTime(new Date(model.getSentTime()));
		boolean result = baseService.saveOrUpdate(model);
		if(result){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "后台异常，请联系开发者");
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getchathistory")
	public ModelAndView getchathistory(HttpSession session,HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(MODELS, "welcome");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		List<ChatModel> result = baseService.getchathistory(user.getId());
		if(result != null){
			jObj.put(RESULT, OK);
			jObj.put(DATA, result);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "后台异常，请联系开发者");
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getIMToken")
	public ModelAndView getIMToken(HttpSession session,HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(DATA, "请先登录再使用聊天功能");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		//先在本地数据库查询IMToken
		if(user.getImToken() != null && !"".equals(user.getImToken())){
			//有IMToken，直接返回
			jObj.put(RESULT, OK);
			jObj.put(DATA, user.getImToken());
			view.addObject(MODELS, jObj);
			return view;
		}
		
		HttpResponse response = baseService.getIMToken(user);
		JSONObject result;
		try {
			result = JSONObject.fromObject(EntityUtils.toString(response.getEntity()));
			if(response != null && response.getStatusLine().getStatusCode() == 200){
				String token = result.optString("token");
				jObj.put(RESULT, OK);
				jObj.put(DATA, token);
				user.setImToken(token);
				baseService.saveOrUpdateUser(user);
			}else{
				jObj.put(RESULT, NO);
				jObj.put(DATA, result.optString("errorMessage"));
			}
		} catch (ParseException | IOException e) {
			e.printStackTrace();
			jObj.put(RESULT, NO);
			jObj.put(DATA, e.getMessage());
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	/**
	 * 保存聊天列表
	 * @param session
	 * @param request
	 * @param userid 聊天对象ID
	 * @return
	 */
	@RequestMapping(value = "/saveUserList")
	public ModelAndView saveUserList(HttpSession session,HttpServletRequest request,int userid) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(MODELS, "用户失效，请重新登录");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		ChatList targetList = baseService.getChatListByIDs(userid,user.getId());
		if(targetList != null){
			jObj.put(RESULT, NO);
			view.addObject(MODELS, jObj);
			return view;
		}
		
		ChatList chatList = new ChatList();
		chatList.setTargetId(userid);
		chatList.setMyid(user.getId());
		boolean result = baseService.saveOrUpdateModel(chatList);
		if(result){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	/**
	 * 获取聊天列表
	 * @param session
	 * @param request
	 * @param userid
	 * @return
	 */
	@RequestMapping(value = "/getUserList")
	public ModelAndView getUserList(HttpSession session,HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(MODELS, "用户失效，请重新登录");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		List<ChatList> targetList = baseService.getUserList(user.getId());
		if(targetList != null){
			jObj.put(RESULT, OK);
			jObj.put(DATA, targetList);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	@RequestMapping(value = "/insertComments")
	public ModelAndView insertComments(@RequestBody CommentsModel commentsModel,HttpSession session,HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
		}
		
		if(user != null)
			commentsModel.fromuser = user.getId();
		
		boolean result = baseService.saveOrUpdateModel(commentsModel);
		if(result){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	@RequestMapping(value = "/getMyComments")
	public ModelAndView getMyComments(HttpSession session,HttpServletRequest request,int pageNum) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(MODELS, "用户失效，请重新登录");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		PageModel pageModel = baseService.getMyComments(user.getId(),pageNum);
		if(pageModel != null && pageModel.getModels().size() > 0){
			jObj.put(RESULT, OK);
			jObj.put(DATA, pageModel.getModels());
			jObj.put("pageCount", pageModel.getPageCount());
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "无数据");
		}
		
		view.addObject(MODELS,jObj);
		return view;
	}
	
	/**
	 * 下架或上架商品
	 * @param goodsid
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/downOrUpGoods")
	public ModelAndView downOrUpGoods(int goodsid,HttpSession session,HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(MODELS, "用户失效，请重新登录");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		String result = baseService.downOrUpGoods(goodsid,user.getId());
		if("".equals(result)){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS, jObj);
		return view;
	}

	
	@RequestMapping(value = "/goods/{id}")
	public ModelAndView goodsView(HttpServletRequest request ,@PathVariable("id") int id) {
		ModelAndView view = new ModelAndView("/pc/goods");
		if(HttpRequestDeviceUtils.isMobileDevice(request)){
			view = new ModelAndView("/mobile/goods_m");
		}
		
		
		GoodsModel model = baseService.getGoodsModelById(id);
		view.addObject("goods", model);
		return view;
	}
	
	@RequestMapping(value = "/buy/{id}")
	public ModelAndView buy(@PathVariable("id") String id) {
		ModelAndView view = new ModelAndView("/pc/buy");
		String[] ids = id.split(",");
		List<GoodsModel> goods = new ArrayList<GoodsModel>();
		for(String idstr:ids){
			if("".equals(idstr)) continue;
			goods.add(baseService.getGoodsModelById(Integer.parseInt(idstr)));
		}
		view.addObject("goods", goods);
		return view;
	}
	
	@RequestMapping(value = "/setdianzhao")
	public ModelAndView setdianzhao(HttpSession session,HttpServletRequest request,String path) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(DATA, "用户失效，请重新登录");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		String result = baseService.setdianzhao(path,user.getId());
		if("".equals(result)){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	@RequestMapping(value = "/getMine")
	public ModelAndView getMine(HttpSession session,HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(DATA, "用户失效，请重新登录");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		user = baseService.getUserById(user.getId());
		if(user != null){
			jObj.put(RESULT, OK);
			jObj.put(DATA, user);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "用户不存在");
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	/*
	 * 删除店招
	 */
	@RequestMapping(value = "/removeDZ")
	public ModelAndView removeDZ(HttpSession session,HttpServletRequest request,int index) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(DATA, "用户失效，请重新登录");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		String result = baseService.removeDZ(user.getId(),index);
		if("".equals(result)){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	@RequestMapping(value = "/insertOrUpdateMyType")
	public ModelAndView insertOrUpdateMyType(HttpSession session,HttpServletRequest request,@RequestBody MyTypeModel model) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(DATA, "用户失效，请重新登录");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		model.setUserid(user.getId());
		boolean result = baseService.saveOrUpdateModel(model);
		if(result){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	@RequestMapping(value = "/getMyTypeByUid")
	public ModelAndView getMyTypeByUid(int uid) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		List<MyTypeModel> list = baseService.getMyTypeByUid(uid);
		if(list != null){
			jObj.put(RESULT, OK);
			jObj.put(DATA, list);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	@RequestMapping(value = "/getMyTypeById")
	public ModelAndView getMyTypeById(int id) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		MyTypeModel result = baseService.getMyTypeById(id);
		if(result != null){
			jObj.put(RESULT, OK);
			jObj.put(DATA, result);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	@RequestMapping(value = "/removeMyTypeById")
	public ModelAndView removeMyTypeById(HttpSession session,HttpServletRequest request,int id) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//用户失效
				jObj.put(RESULT, NO);
				jObj.put(DATA, "用户失效，请重新登录");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		
		String result = baseService.removeMyTypeById(id,user.getId());
		if("".equals(result)){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
	@RequestMapping(value = "/getGoodsByMyType")
	public ModelAndView getGoodsByMyType(HttpSession session,HttpServletRequest request,int mytype,int pageNum,int pageSize) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		List<GoodsModel> result = baseService.getGoodsByMyType(mytype,pageNum,pageSize);
		if(result.size() > 0){
			jObj.put(RESULT, OK);
			jObj.put(DATA, result);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "无数据");
		}
		view.addObject(MODELS, jObj);
		return view;
	}
	
}
