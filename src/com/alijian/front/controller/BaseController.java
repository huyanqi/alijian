package com.alijian.front.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

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

import com.alijian.front.model.LecturerModel;
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
		model = baseService.login(model.username,model.password);
		if(model != null){
			obj.put(RESULT, OK);
			obj.put(DATA, model);
			Cookie cookie = new Cookie("uid", model.id+"");
			Cookie roleCookie = new Cookie("role", model.type+"");
			Cookie usernameCookie = new Cookie("username", model.username);
			Cookie nameCookie;
			try {
				nameCookie = new Cookie("name", URLEncoder.encode(model.name, "utf-8"));
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
	
}
