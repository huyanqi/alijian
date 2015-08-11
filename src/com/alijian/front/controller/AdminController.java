package com.alijian.front.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alijian.front.model.BusinessModel;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.TypeModel;
import com.alijian.front.model.UserModel;
import com.alijian.front.service.AdminService;
import com.alijian.util.BaseData;

@Controller
@RequestMapping
public class AdminController extends BaseData {

	@Autowired
	private AdminService adminService;
	
	@RequestMapping(value = "/admin_login")
	public ModelAndView adminLogin(HttpServletRequest request,String username,String password) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		if("admin".equals(username) && "password".equals(password)){
			jObj.put(RESULT, OK);
			UserModel admin = new UserModel();
			admin.setId(0);;
			admin.setName("系统管理员");
			admin.setType(0);
			request.getSession().setAttribute(SESSION_USER, admin);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/admin_info")
	public ModelAndView adminInfo(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) request.getSession().getAttribute(SESSION_USER);
		if(user == null) {
			jObj.put(RESULT, NO);
		}else{
			jObj.put(RESULT, OK);
			jObj.put(DATA, user);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/type_insert")
	public ModelAndView typeInsert(@RequestBody TypeModel model) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		
		boolean result = adminService.saveOrUpdateTypeModel(model);
		if(result){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "后台异常，请联系开发者");
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getTypeModelByType")
	public ModelAndView getTypeModelByType(int type) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		
		List<TypeModel> models = adminService.getTypeModelByType(type);
		if(models.size() > 0){
			jObj.put(RESULT, OK);
			jObj.put(DATA, models);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "无数据");
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getTypeById")
	public ModelAndView getTypeById(int id) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		TypeModel model = adminService.getTypeById(id);
		if(model != null){
			jObj.put(RESULT, OK);
			jObj.put(DATA, model);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "无数据");
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/removeTypeById")
	public ModelAndView removeTypeById(int id) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = adminService.removeTypeById(id);
		if(result.equals("")){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/insertLecturer")
	public ModelAndView insertLecturer(@RequestBody LecturerModel model) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = adminService.insertLecturer(model);
		if(result.equals("")){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getAllLecturers")
	public ModelAndView getAllLecturers() {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		List<LecturerModel> models = adminService.getAllLecturers();
		if(models.size() > 0){
			jObj.put(RESULT, OK);
			jObj.put(DATA, models);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/removeLecturerById")
	public ModelAndView removeLecturerById(int id) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = adminService.removeLecturerById(id);
		if(result.equals("")){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getAllUser")
	public ModelAndView getAllUser(int type,int status) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		List<UserModel> models = adminService.getAllUser(type,status);
		if(models.size() > 0){
			jObj.put(RESULT, OK);
			jObj.put(DATA, models);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/supplierPass")
	public ModelAndView supplierPass(int uid) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = adminService.supplierPass(uid);
		if("".equals(result)){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/insertGoods")
	public ModelAndView insertGoods(HttpSession session, @RequestBody GoodsModel model) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			jObj.put(RESULT, NO);
			jObj.put(DATA, "未登录");
			view.addObject(MODELS,jObj);
			return view;
		}
		model.setUser(user);
		String result = adminService.insertGoods(model);
		if(result.equals("")){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getMyGoods")
	public ModelAndView getMyGoods(HttpSession session,int pageNum){
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			jObj.put(RESULT, NO);
			jObj.put(DATA, "未登录");
		}else{
			PageModel pageModel = adminService.getMyGoods(user.getId(),pageNum);
			if(pageModel != null && pageModel.getModels().size() > 0){
				jObj.put(RESULT, OK);
				jObj.put(DATA, pageModel.getModels());
				jObj.put("pageCount", pageModel.getPageCount());
			}else{
				jObj.put(RESULT, NO);
				jObj.put(DATA, "无数据");
			}
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	
	@RequestMapping(value = "/removeGoodsById")
	public ModelAndView removeGoodsById(int id) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = adminService.removeGoodsById(id);
		if(result.equals("")){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/updateUser")
	public ModelAndView updateUser(@RequestBody UserModel user) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = adminService.updateUser(user);
		if(result.equals("")){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/insertOrUpdateBusiness")
	public ModelAndView insertOrUpdateBusiness(@RequestBody BusinessModel model,HttpSession session) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute(SESSION_USER);
		if(user == null){
			jObj.put(RESULT, NO);
			jObj.put(DATA, "未登录");
			view.addObject(MODELS,jObj);
			return view;
		}
		model.setUser(user);
		String result = adminService.insertOrUpdateModel(model);
		if(result.equals("")){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/removeBusinessById")
	public ModelAndView removeBusinessById(int id) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = adminService.removeBusinessById(id);
		if(result.equals("")){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
}
