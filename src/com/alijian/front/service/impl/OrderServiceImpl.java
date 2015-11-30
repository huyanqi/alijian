package com.alijian.front.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alijian.front.dao.AdminDao;
import com.alijian.front.dao.BaseDao;
import com.alijian.front.dao.OrderDao;
import com.alijian.front.model.CommentModel;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.OrdersSetModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.PayOrder;
import com.alijian.front.model.PriceModel;
import com.alijian.front.model.UserModel;
import com.alijian.front.service.BaseService;
import com.alijian.front.service.OrderService;
import com.alijian.util.BaseData;
import com.alijian.util.Tools;
import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipayNotify;
import com.alipay.util.AlipaySubmit;

@Service("orderService")
@Transactional(rollbackFor = Exception.class)
public class OrderServiceImpl extends BaseData implements OrderService {

	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private BaseService baseService;
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private BaseDao baseDao;

	@Override
	public OrdersModel saveOrUpdateOrder(OrdersModel model,UserModel buyer) {
		return null;
		/*GoodsModel goods = adminDao.getGoodsById(model.getGood_id());
		if(goods == null) return null;
		//生成订单号
		model.setOrders_no(Tools.newOrderNo(model.getGood_id(), model.getAmout(), goods.getUser().getId(), buyer.getId()));
		//计算订单总额
		
		//获取购买总额
		int amount = model.getAmout();
		double totalprice = -1;
		//获取批发价对象
		if(goods.getPrice_id() != 0){
			//有批发价,查询批发价对象
			PriceModel priceModel = baseDao.getPriceModelById(goods.getPrice_id());
			//计算批发价，查询出这个范围的批发单价
			String[] startCount = priceModel.startCount.split(",");
			String[] endCount = priceModel.endCount.split(",");
			String[] prices = priceModel.price.split(",");
			for(int i=0;i<prices.length;i++){
				String start = "";
				String end = "";
				if(i <= startCount.length-1){
					start = startCount[i];
				}
				if(i <= endCount.length-1){
					end = endCount[i];
				}
				
				int startNum = 0;
				int endNum;
				if("".equals(start)) startNum = 0;
				else startNum = Integer.valueOf(start);
				if("".equals(end)) endNum = 999999999;
				else endNum = Integer.valueOf(endCount[i]);
				if(startNum <= amount && amount <= endNum){
					totalprice = Double.parseDouble(prices[i]) * amount;
					break;
				}
			}
			
			if(totalprice == -1){
				totalprice = model.getAmout() * goods.getPrice();
			}
			
		}else{
			totalprice = model.getAmout() * goods.getPrice();
		}
		
		DecimalFormat df = new DecimalFormat("######0.00");
		model.setPrices(new BigDecimal(totalprice));
		System.out.println(new BigDecimal(totalprice));
		System.out.println("totalprice:"+totalprice);
		
		//设置买家ID
		model.setBuyer(buyer.getId());
		//设置卖家ID
		model.setSaller(goods.getUser().getId());
		//设置订单生成时间
		model.setCreate_time(new Date());
		
		return orderDao.saveOrUpdateOrder(model);*/
	}

	/**
	 * 创建支付宝付款链接
	 * @param model
	 * @param force_pc 是否强制使用PC端付款
	 * @return
	 */
	@Override
	public String createALiPayOrder(OrdersModel model,boolean force_pc) {
		return null;
		/*//支付类型
		String payment_type = "1";
		//必填，不能修改
		//服务器异步通知页面路径
		String notify_url = LOCAL+"change_order_state";//notify_url.jsp
		//需http://格式的完整路径，不能加?id=123这类自定义参数
		//页面跳转同步通知页面路径
		String return_url = LOCAL+"return_url.jsp";
		//需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/
		//商户订单号
		String out_trade_no = new String(model.getOrders_no());
		//商户网站订单系统中唯一订单号，必填
		//订单名称
		String subject = new String(model.getOrders_no());//临时用订单号
		//必填
		//付款金额
		double price = model.getPrices().setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();  
		String total_fee = new String(price+"");
		//必填
		//订单描述
		String body = new String(model.getRemark());
		//商品展示地址
		String show_url = new String(LOCAL+"pc/goods.jsp?id="+model.getGood_id());
		//需以http://开头的完整路径，例如：http://www.商户网址.com/myorder.html

		//防钓鱼时间戳
		String anti_phishing_key = "";
		//若要使用请调用类文件submit中的query_timestamp函数

		//客户端的IP地址
		String exter_invoke_ip = "";
		//非局域网的外网IP地址，如：221.0.0.1
		//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		String service = "";
		if(force_pc){
			service = "create_direct_pay_by_user";
		}else{
			service = model.getIs_mobile() == 0 ? "create_direct_pay_by_user" : "alipay.wap.create.direct.pay.by.user";
		}
		sParaTemp.put("service", service);
        sParaTemp.put("partner", AlipayConfig.partner);
        sParaTemp.put("seller_id", AlipayConfig.seller_id);
        sParaTemp.put("seller_email", AlipayConfig.seller_email);
        sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("payment_type", payment_type);
		sParaTemp.put("notify_url", notify_url);
		sParaTemp.put("return_url", return_url);
		sParaTemp.put("out_trade_no", out_trade_no);
		sParaTemp.put("subject", subject);
		sParaTemp.put("total_fee", total_fee);
		sParaTemp.put("body", body);
		sParaTemp.put("show_url", show_url);
		sParaTemp.put("anti_phishing_key", anti_phishing_key);
		sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
		
		//建立请求
		String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
		return sHtmlText;*/
	}

	@Override
	public String changeOrderState(HttpServletRequest request,String out_trade_no, String trade_no,String trade_status) {
		//获取支付宝POST过来反馈信息
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}
		if(AlipayNotify.verify(params)){//验证成功
			if(out_trade_no.startsWith("ALIJIAN")){
				//如果是ALIJIAN开头，说明是批量订单
				PayOrder payOrder = orderDao.getPayOrderByOutTradeNo(out_trade_no);
				//把该订单集合下的订单全部改变状态
				for(OrdersSetModel order : payOrder.getOrderset()){
					if(order == null) return "FAIL";
					order.setTrade_no(trade_no);
					if("TRADE_SUCCESS".equals(trade_status)){
						order.setState(1);
					}else if("TRADE_FINISHED".equals(trade_status)){
						order.setState(2);
					}
					orderDao.saveOrUpdateModel(order);
				}
			}else{
				//这个是单个支付订单
				OrdersSetModel order = orderDao.getOrderSetByOutTradeNo(out_trade_no);
				if(order == null) return "FAIL";
				order.setTrade_no(trade_no);
				if("TRADE_SUCCESS".equals(trade_status)){
					order.setState(1);
				}else if("TRADE_FINISHED".equals(trade_status)){
					order.setState(2);
				}
				orderDao.saveOrUpdateModel(order);
			}
		}
		//这里可以增加积分
		
		return "1";
	}

	@Override
	public PageModel getMySell(int id,int pageNum) {
		return null;
		/*PageModel model = orderDao.getMySell(id,pageNum);
		for(Object order:model.getModels()){
			((OrdersModel) order).setGoods(baseService.getGoodsModelById(((OrdersModel) order).getGood_id()));
		}
		return model;*/
	}

	@Override
	public OrdersModel getOrderById(String orderid) {
		return null;
		/*OrdersModel model = orderDao.getOrderById(orderid);
		model.setGoods(baseService.getGoodsModelById(model.getGood_id()));
		return model;*/
	}

	@Override
	public String fahuo(String no, String cnumber) {
		return null;
		/*try{
			OrdersModel model = getOrderById(no);
			model.setCnumber(cnumber);
			model.setState(4);
			orderDao.saveOrUpdateOrder(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}*/
	}

	@Override
	public PageModel getMyBuy(int id, int pageNum) {
		PageModel model = orderDao.getMyBy(id,pageNum);
		for(Object order:model.getModels()){
			((OrdersSetModel) order).setGoodsList(((OrdersSetModel) order).getGoods());
			for(OrdersModel ordersModel : ((OrdersSetModel) order).getGoodsList()){
				ordersModel.setGoodsModel(baseService.getGoodsModelById(ordersModel.getGoods_id()));
			}
		}
		return model;
	}

	@Override
	public String querenshouhuo(String no) {
		return null;
		/*try{
			OrdersModel model = getOrderById(no);
			model.setState(2);
			orderDao.saveOrUpdateOrder(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}*/
	}

	@Override
	public OrdersModel getOrderByOrderId(int orderid) {
		return null;
		/*OrdersModel model = orderDao.getOrderByOrderId(orderid);
		model.setGoods(baseService.getGoodsModelById(model.getGood_id()));
		return model;*/
	}

	@Override
	public CommentModel saveOrUpdateComment(CommentModel model) {
		model = orderDao.saveOrUpdateComment(model);
		OrdersModel order = orderDao.getOrderById(model.getOrder_id());
		order.setComment_id(model.getId());
		orderDao.saveOrUpdateOrder(order);
		return model;
	}

	@Override
	public PageModel getComment(int goods_id, int pageNum) {
		PageModel model = orderDao.getComment(goods_id,pageNum);
		for(CommentModel comment:(List<CommentModel>)model.getModels()){
			UserModel user = baseService.getUserById(comment.user_id);
			user.setPassword("");
			comment.setUser(user);
		}
		return model;
	}

	@Override
	public String shanchu(int orderid) {
		return orderDao.shanchu(orderid);
	}

	@Override
	public PayOrder createOrder(List<OrdersModel> orders,UserModel buyer,int is_mobile) {
		List<OrdersSetModel> setList = new ArrayList<OrdersSetModel>();
		PayOrder payOrder = new PayOrder();
		for(OrdersModel order:orders){
			//获取所选商品的GoodsModel对象
			GoodsModel goods = baseService.getGoodsModelById(order.getGoods_id());
			order.setGoodsModel(goods);
			//计算出商品价格(批发价)
			if(goods.getPrice_id() == 0){
				order.setPrices(Tools.getPrice(order.getAmout(), goods, null));
			}else{
				PriceModel priceModel = baseDao.getPriceModelById(goods.getPrice_id());
				order.setPrices(Tools.getPrice(order.getAmout(), goods, priceModel));
			} 
			OrdersSetModel setModel = null;
			for(OrdersSetModel tempSetModel : setList){
				if(tempSetModel.getSaller() == goods.user.getId()){
					setModel = tempSetModel;
					break;
				}
			}
			if(setModel == null) {
				setModel = new OrdersSetModel();
				//组装参数
				setModel.setOrders_no(Tools.newOrderNo(order.getId(), order.getAmout(), goods.getUser().getId(), buyer.getId()));
				setModel.setBuyer(buyer.getId());
				setModel.setSaller(goods.getUser().getId());
				setModel.setAddress(order.getAddress());
				setModel.setMobile(order.getMobile());
				setModel.setName(order.getName());
				setModel.setCreate_time(new Date());
				setModel.setPayorder(payOrder);
				setList.add(setModel);
			}
			setModel.getGoods().add(order);
			setModel.setPrices(new BigDecimal(setModel.getPrices().doubleValue() + order.getPrices().doubleValue()));
			payOrder.setPrice(payOrder.getPrice() + setModel.getPrices().setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue());
			order.setOrderSetModel(setModel);
		}
		
		payOrder.setOrderset(setList);
		payOrder.setIs_mobile(is_mobile);
		payOrder.setOrders_no("ALIJIAN"+new Date().getTime());
		baseDao.saveOrUpdateModel(payOrder);
		return payOrder;
	}

	@Override
	public String createALiPayOrder(HttpServletRequest request, String orders_no, String string,double price, String remark, String show_url, int is_mobile) {
		//支付类型
		String payment_type = "1";
		//必填，不能修改
		//服务器异步通知页面路径 
		String notify_url = "http://"+request.getServerName()+"/change_order_state";//notify_url.jsp
		//需http://格式的完整路径，不能加?id=123这类自定义参数
		//页面跳转同步通知页面路径
		String return_url = "http://"+request.getServerName()+"/return_url.jsp";
		//需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/
		//商户订单号
		String out_trade_no = new String(orders_no);
		//商户网站订单系统中唯一订单号，必填
		//订单名称
		String subject = new String(string);//临时用订单号
		//必填
		//付款金额
		String total_fee = new String(price+"");
		//需以http://开头的完整路径，例如：http://www.商户网址.com/myorder.html

		//防钓鱼时间戳
		String anti_phishing_key = "";
		//若要使用请调用类文件submit中的query_timestamp函数

		//客户端的IP地址
		String exter_invoke_ip = "";
		//非局域网的外网IP地址，如：221.0.0.1
		//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		String service = "";
		if(is_mobile == 0){
			service = "create_direct_pay_by_user";
		}else{
			service = "alipay.wap.create.direct.pay.by.user";
		}
		sParaTemp.put("service", service);
        sParaTemp.put("partner", AlipayConfig.partner);
        sParaTemp.put("seller_id", AlipayConfig.seller_id);
        sParaTemp.put("seller_email", AlipayConfig.seller_email);
        sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("payment_type", payment_type);
		sParaTemp.put("notify_url", notify_url);
		sParaTemp.put("return_url", return_url);
		sParaTemp.put("out_trade_no", out_trade_no);
		sParaTemp.put("subject", subject);
		sParaTemp.put("total_fee", total_fee);
		sParaTemp.put("body", remark);
		sParaTemp.put("show_url", show_url);
		sParaTemp.put("anti_phishing_key", anti_phishing_key);
		sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
		
		//建立请求
		String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
		return sHtmlText;
	}

	@Override
	public OrdersSetModel getOrdersSetByOrderNo(String orderno) {
		return orderDao.getOrdersSetByOrderNo(orderno);
	}

	@Override
	public String createWXOrder(HttpServletRequest request, String orders_no, String string, double price,String string2, String show_url, int is_mobile) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("appid", "wxd12014470a8088bc");
		params.put("body", string);
		params.put("mch_id", "1233504302");
		params.put("nonce_str", Tools.getRandomString(32));
		params.put("notify_url", is_mobile == 1 ? "JSAPI":"");
		params.put("out_trade_no", orders_no);
		params.put("spbill_create_ip", Tools.getIpAddr(request));//用戶的IP地址
		params.put("total_fee", price * 100 +"");
		params.put("sign", Tools.getWXSign(params,"-------------key-------------"));
		
		return null;
	}
	

}
