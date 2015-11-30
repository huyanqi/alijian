package com.alijian.front.controller;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alijian.front.model.CommentModel;
import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.OrdersSetModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.PayOrder;
import com.alijian.front.model.UserModel;
import com.alijian.front.service.BaseService;
import com.alijian.front.service.OrderService;
import com.alijian.util.BaseData;
import com.alijian.util.HttpRequestDeviceUtils;

@Controller
@RequestMapping
public class OrderController extends BaseData {

	@Autowired
	private OrderService orderService;
	
	@Autowired
	private BaseService baseService;
	
	/**
	 * ��������
	 * @param request
	 * @param session
	 * @param orders
	 * @param pay_method ֧����ʽ 0:֧���� 1:΢��
	 * @return
	 */
	@RequestMapping(value = "/create_order")
	public ModelAndView create_order(HttpServletRequest request,HttpSession session,@RequestBody List<OrdersModel> orders,int pay_method) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel buyer = (UserModel) session.getAttribute("user");
		if(buyer == null){
			buyer = baseService.getUserByUsernameAndToken(request);
			if(buyer == null){
				//�û�ʧЧ
				jObj.put(RESULT, NO);
				jObj.put(DATA, "�û���Ϣ���ڣ������µ�¼");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		int is_mobile = 0;
		if(HttpRequestDeviceUtils.isMobileDevice(request)){
			is_mobile = 1;
		}
		PayOrder payOrder = orderService.createOrder(orders,buyer,is_mobile);
		String show_url = new String("http://"+request.getServerName()+"/goods/"+1);
		String html = "";
		if(pay_method == 0){
			html = orderService.createALiPayOrder(request,payOrder.getOrders_no(),"���｡-��������",payOrder.getPrice(),"payOrder id:"+payOrder.getId(),show_url,is_mobile);//���ظ���url
		}else{
			html = "";//����΢�Ÿ���url
		}
		jObj.put(RESULT, OK);
		jObj.put(DATA, html);
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getOrderById")
	public ModelAndView getOrderById(String orderid) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		OrdersModel model = orderService.getOrderById(orderid);
		if(model != null){
			jObj.put(RESULT, OK);
			jObj.put(DATA, model);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/getOrderByOrderId")
	public ModelAndView getOrderByOrderId(int orderid) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		OrdersModel model = orderService.getOrderByOrderId(orderid);
		if(model != null){
			jObj.put(RESULT, OK);
			jObj.put(DATA, model);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	/**
	 * �ı䶩��֧��״̬
	 * @param out_trade_no ���｡������
	 * @param trade_no ֧����������
	 * @param trade_status ����֧��״̬
	 * @return 0״̬����ʧ�� 1�ɹ�
	 */
	@RequestMapping(value = "/change_order_state")
	public @ResponseBody String changeOrderState(HttpServletRequest request,String out_trade_no,String trade_no,String trade_status) {
		return orderService.changeOrderState(request,out_trade_no,trade_no,trade_status);
	}
	
	/**
	 * ��ȡ�����۳�ȥ����Ʒ�����б�
	 * @param session
	 * @param pageNum
	 * @return
	 */
	@RequestMapping(value = "/get_my_sell")
	public ModelAndView getMySell(HttpServletRequest request,HttpSession session,int pageNum) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel saller = (UserModel) session.getAttribute("user");
		if(saller == null){
			saller = baseService.getUserByUsernameAndToken(request);
			if(saller == null){
				//�û�ʧЧ
				jObj.put(RESULT, NO);
				jObj.put(DATA, "�û���Ϣ���ڣ������µ�¼");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		PageModel model = orderService.getMySell(saller.getId(),pageNum);
		if(model.getModels().size() > 0){
			jObj.put(RESULT, OK);
			jObj.put(DATA, model.getModels());
			jObj.put("pageCount", model.getPageCount());
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "�޸�������");
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	/**
	 * ��ȡ�ҹ������Ʒ�����б�
	 * @param session
	 * @param pageNum
	 * @return
	 */
	@RequestMapping(value = "/get_my_buy")
	public ModelAndView getMyBuy(HttpServletRequest request,HttpSession session,int pageNum) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute("user");
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//�û�ʧЧ
				jObj.put(RESULT, NO);
				jObj.put(DATA, "�û���Ϣ���ڣ������µ�¼");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		PageModel model = orderService.getMyBuy(user.getId(),pageNum);
		if(model.getModels().size() > 0){
			jObj.put(RESULT, OK);
			JsonConfig config = new JsonConfig();  
			   config.setExcludes(new String[]{//ֻҪ����������飬ָ��������Щ�ֶΡ� 
			     "payorder", 
			     "goods",
			     "orderSetModel"
			     });
			   jObj.put(DATA, JSONArray.fromObject(model.getModels(),config));
			jObj.put("pageCount", model.getPageCount());
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "�޸�������");
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/fahuo")
	public ModelAndView fahuo(String no,String cnumber) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = orderService.fahuo(no,cnumber);
		if("".equals(result)){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/shanchu")
	public ModelAndView shanchu(int orderid) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		String result = orderService.shanchu(orderid);
		if("".equals(result)){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/querenshouhuo")
	public ModelAndView querenshouhuo(HttpServletRequest request, HttpSession session, String no) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute("user");
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//�û�ʧЧ
				jObj.put(RESULT, NO);
				jObj.put(DATA, "�û���Ϣ���ڣ������µ�¼");
				view.addObject(MODELS,jObj);
				return view;
			}
		}
		if(user.getId() != Integer.parseInt(no.split("-")[no.split("-").length-1])){
			//û��ȷ�ϲ���Ȩ��
			jObj.put(RESULT, NO);
			jObj.put(DATA, "�Ƿ�����");
			view.addObject(MODELS,jObj);
			return view;
		}
		String result = orderService.querenshouhuo(no);
		if("".equals(result)){
			jObj.put(RESULT, OK);
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, result);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/jixufukuan")
	public ModelAndView jixufukuan(HttpServletRequest request, String orderno, int pay_method) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		OrdersSetModel payOrder = orderService.getOrdersSetByOrderNo(orderno);
		if(payOrder != null){
			jObj.put(RESULT, OK);
			String html = "";
			int is_mobile = 0;
			if(HttpRequestDeviceUtils.isMobileDevice(request)){
				is_mobile = 1;
			}
			if(pay_method == 0){
				double price = payOrder.getPrices().setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();
				String show_url = new String("http://"+request.getServerName()+"/goods/"+payOrder.getGoods().get(0).getGoods_id());
				html = orderService.createALiPayOrder(request,payOrder.getOrders_no(),"���｡-��������",price,"payOrder id:"+payOrder.getId(),show_url,is_mobile);//���ظ���url
			}else{
				html = "";//����΢�Ÿ���url
			}
			jObj.put(DATA, html);
		}else{
			jObj.put(RESULT, NO);
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/comment")
	public ModelAndView comment(HttpServletRequest request, HttpSession session,@RequestBody CommentModel model){
		ModelAndView view = new ModelAndView("/json");
		JSONObject obj = new JSONObject();
		UserModel user = (UserModel) session.getAttribute("user");
		if(user == null){
			user = baseService.getUserByUsernameAndToken(request);
			if(user == null){
				//�û�ʧЧ
				obj.put(RESULT, NO);
				obj.put(DATA, "�û���Ϣ���ڣ������µ�¼");
				view.addObject(MODELS,obj);
				return view;
			}
		}
		
		if(user.getId() != Integer.parseInt(model.order_id.split("-")[model.order_id.split("-").length-1])){
			//û��ȷ�ϲ���Ȩ��
			obj.put(RESULT, NO);
			obj.put(DATA, "�Ƿ�����");
			view.addObject(MODELS,obj);
			return view;
		}
		model.user_id = user.getId();
		model = orderService.saveOrUpdateComment(model);
		if(model != null){
			obj.put(RESULT, OK);
			obj.put(DATA, model);
		}else{
			obj.put(RESULT, NO);
			obj.put(DATA, "���۷���ʧ��");
		}
		view.addObject(MODELS,obj);
		return view;
	}
	
	/**
	 * ��ȡ��Ʒ�����б�
	 * @param goods_id
	 * @return
	 */
	@RequestMapping(value = "/getComment")
	public ModelAndView getComment(int goods_id,int pageNum) {
		ModelAndView view = new ModelAndView("/json");
		JSONObject jObj = new JSONObject();
		PageModel pageModel = orderService.getComment(goods_id,pageNum);
		if(pageModel.getModels().size() > 0){
			jObj.put(RESULT, OK);
			jObj.put(DATA, pageModel.getModels());
		}else{
			jObj.put(RESULT, NO);
			jObj.put(DATA, "�޸�������");
		}
		view.addObject(MODELS,jObj);
		return view;
	}
	
	@RequestMapping(value = "/cookietest")
	public void cookietest() {
		
	}
	
}
