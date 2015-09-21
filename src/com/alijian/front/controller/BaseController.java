package com.alijian.front.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alijian.front.model.BusinessModel;
import com.alijian.front.model.BuyModel;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.KeywordsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.LinkModel;
import com.alijian.front.model.UserModel;
import com.alijian.front.service.BaseService;
import com.alijian.util.BaseData;
import com.alijian.util.Tools;

@Controller
@RequestMapping
public class BaseController extends BaseData {

	@Autowired
	private BaseService baseService;

	@RequestMapping(value = "/test")
	public ModelAndView test() {
		ModelAndView view = new ModelAndView("/json");
		System.out.println("test");
		return view;
	}
	
	@RequestMapping(value = "/fileupload")
	public ModelAndView fileupload(@RequestParam("upload") MultipartFile file,HttpServletRequest request) {
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
			String suffix = fileName.substring(fileName.lastIndexOf("."),fileName.length());
			fileName = Tools.generateRandomFilename() + suffix;
			
			String directory = request.getSession().getServletContext().getRealPath("images");
			
			//确定写出文件的目录位置
			System.out.println(directory);
			newFile = new File(directory,fileName);
			if(!newFile.exists()){//判断文件目录是否存在  
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
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/ckfileupload")
	public void ckfileupload(@RequestParam("upload") MultipartFile file,HttpServletRequest request,HttpServletResponse response) {
		File newFile = null;
		String fileName = null;
		
		if (!file.isEmpty()) {
			
			fileName = file.getOriginalFilename();
			String suffix = fileName.substring(fileName.lastIndexOf("."),fileName.length());
			fileName = Tools.generateRandomFilename() + suffix;
			
			String directory = request.getSession().getServletContext().getRealPath("images");
			
			//确定写出文件的目录位置
			newFile = new File(directory,fileName);
			if(!newFile.exists()){//判断文件目录是否存在  
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
		if(model != null){
			obj.put(RESULT, OK);
			obj.put(DATA, model);
		}else{
			obj.put(RESULT, NO);
			obj.put(DATA, "获取信息失败，请联系管理员");
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/login")
	public ModelAndView login(@RequestBody UserModel model,HttpServletResponse response,HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		model = baseService.login(model.getUsername(),model.getPassword());
		if(model != null){
			obj.put(RESULT, OK);
			obj.put(DATA, model);
			Cookie cookie = new Cookie("uid", model.getId()+"");
			Cookie roleCookie = new Cookie("role", model.getType()+"");
			Cookie usernameCookie = new Cookie("username", model.getUsername());
			Cookie nameCookie;
			try {
				nameCookie = new Cookie("name", URLEncoder.encode(model.getName(), "utf-8"));
				response.addCookie(nameCookie);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			cookie.setMaxAge(-1);
			response.addCookie(cookie);
			response.addCookie(roleCookie);
			response.addCookie(usernameCookie);

			request.getSession().setAttribute("user", model);
		}else{
			obj.put(RESULT, NO);
			obj.put(DATA, "该用户不存在或密码错误");
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpServletResponse response,HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		request.getSession().removeAttribute("user");
		Cookie[] cookies=request.getCookies();
		for(Cookie cookie : cookies){
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		JSONObject obj = new JSONObject();
		obj.put(RESULT, OK);
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/regUser")
	public ModelAndView regUser(@RequestBody UserModel model) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		String result = baseService.saveOrUpdateUser(model);
		if("".equals(result)){
			obj.put(RESULT, OK);
		}else{
			obj.put(RESULT, NO);
			obj.put(DATA, result);
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/getSession")
	public ModelAndView getSession(HttpServletRequest request){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		if(user != null){
			obj.put(RESULT, OK);
			obj.put(DATA, user);
		}else{
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/getGoodsModelById")
	public ModelAndView getGoodsModelById(int id){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		GoodsModel goods = baseService.getGoodsModelById(id);
		if(goods != null){
			obj.put(RESULT, OK);
			obj.put(DATA, goods);
		}else{
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	/**
	 * 
	 * @param pageNum 当前页数
	 * @param pageSize 每页大小
	 * @param types 商品分类(,隔开)
	 * @param keyword 搜索关键字
	 * @param type 搜索类型:0 默认 1：价格从低到高 2：价格从高到低 3：销量从高到低
	 * @return
	 */
	@RequestMapping(value = "/getGoods")
	public ModelAndView getGoods(int pageNum,int pageSize,String types,String keyword,int type){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		List<GoodsModel> goods = baseService.getGoods(pageNum,pageSize,types,keyword,type);
		if(goods != null){
			obj.put(RESULT, OK);
			obj.put(DATA, goods);
		}else{
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/getUsers")
	public ModelAndView getUsers(int pageSize,int type,int status){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		List<UserModel> users = baseService.getUsers(pageSize,type,status);
		if(users != null){
			obj.put(RESULT, OK);
			obj.put(DATA, users);
		}else{
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/getUserById")
	public ModelAndView getUserById(int uid){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		UserModel user = baseService.getUserById(uid);
		if(user != null){
			obj.put(RESULT, OK);
			obj.put(DATA, user);
		}else{
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/getBusinessModels")
	public ModelAndView getBusinessModels(int pageNum,int pageSize,String types,String keyword){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		List<BusinessModel> models = baseService.getBusinessModels(pageNum,pageSize,types,keyword);
		if(models.size() > 0){
			obj.put(RESULT, OK);
			obj.put(DATA, models);
		}else{
			obj.put(RESULT, NO);
			obj.put(DATA, "无数据");
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/getBusinessById")
	public ModelAndView getBusinessById(int id){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		BusinessModel model = baseService.getBusinessById(id);
		if(model != null){
			obj.put(RESULT, OK);
			obj.put(DATA, model);
		}else{
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	/**
	 * 搜索厂家
	 * @param pageSize 每页大小
	 * @param types 包含类型
	 * @return
	 */
	@RequestMapping(value = "/getSuppliers")
	public ModelAndView getSuppliers(int pageNum,int pageSize,String types,String keyword) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		List<UserModel> models = baseService.getSuppliers(pageNum,pageSize,types,keyword);
		if(models.size() > 0){
			jObj.put(RESULT, OK);
			jObj.put(DATA, models);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getLecturers")
	public ModelAndView getLecturers(int pageNum,int pageSize,String types,String keyword) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		List<LecturerModel> models = baseService.getLecturers(pageNum,pageSize,types,keyword);
		if(models.size() > 0){
			jObj.put(RESULT, OK);
			jObj.put(DATA, models);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getSupplierById")
	public ModelAndView getSupplierById(int uid){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		UserModel user = baseService.getSupplierById(uid);
		if(user != null){
			obj.put(RESULT, OK);
			obj.put(DATA, user);
		}else{
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/getKeyWords")
	public ModelAndView getKeyWords(int pageNum){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		List<KeywordsModel> keywords = baseService.getKeyWords(pageNum);
		if(keywords.size() > 0){
			obj.put(RESULT, OK);
			obj.put(DATA, keywords);
		}else{
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/getLinks")
	public ModelAndView getLinks(){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		List<LinkModel> links = baseService.getLinks();
		if(links.size() > 0){
			obj.put(RESULT, OK);
			obj.put(DATA, links);
		}else{
			obj.put(RESULT, NO);
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	@RequestMapping(value = "/insertBuyModel")
	public ModelAndView insertBuyModel(@RequestBody BuyModel model){
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = baseService.insertBuyModel(model);
		if(result.equals("")){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getBuyModels")
	public ModelAndView getBuyModels(int pageNum){
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		List<BuyModel> models = baseService.getBuyModels(pageNum);
		if(models.size() > 0){
			jObj.put(RESULT, OK);
			jObj.put(DATA, models);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
}
