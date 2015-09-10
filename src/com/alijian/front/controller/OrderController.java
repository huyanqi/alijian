package com.alijian.front.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.UserModel;
import com.alijian.front.service.OrderService;
import com.alijian.util.BaseData;

@Controller
@RequestMapping
public class OrderController extends BaseData {

	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value = "/create_order")
	public ModelAndView create_order(HttpSession session,OrdersModel model) {
		ModelAndView view = new ModelAndView("/json");
		UserModel buyer = (UserModel) session.getAttribute("user");
		JSONObject jObj = new JSONObject();
		if(buyer == null){
			//没有登录
			jObj.put(RESULT, NO);
			jObj.put(MODELS, "welcome");
			view.addObject(MODELS,jObj);
			return view;
		}
		model = orderService.saveOrUpdateOrder(model,buyer);
		if(model != null){
			jObj.put(RESULT, OK);
			String html = orderService.createALiPayOrder(model);//返回付款url
			jObj.put(DATA, html);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	/**
	 * 改变订单支付状态
	 * @param out_trade_no 阿里健订单号
	 * @param trade_no 支付宝订单号
	 * @param trade_status 最新支付状态
	 * @return 0状态保存失败 1成功
	 */
	@RequestMapping(value = "/change_order_state")
	public @ResponseBody String changeOrderState(HttpServletRequest request,String out_trade_no,String trade_no,String trade_status) {
		return orderService.changeOrderState(request,out_trade_no,trade_no,trade_status);
	}
	
}
