package com.alijian.front.service.impl;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alijian.front.dao.AdminDao;
import com.alijian.front.dao.OrderDao;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.UserModel;
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
	private AdminDao adminDao;

	@Override
	public OrdersModel saveOrUpdateOrder(OrdersModel model,UserModel buyer) {
		GoodsModel goods = adminDao.getGoodsById(Integer.parseInt(model.getGoods_ids()));
		if(goods == null) return null;
		//生成订单号
		model.setOrders_no(Tools.newOrderNo(model.getGoods_ids(), model.getAmout(), goods.getUser().getId(), buyer.getId()));
		//计算订单总额
		DecimalFormat df = new DecimalFormat("######0.00");
		model.setPrices(Double.valueOf(df.format(model.getAmout() * goods.getPrice())));
		//设置买家ID
		model.setBuyer(buyer.getId());
		//设置订单生成时间
		model.setCreate_time(new Date());
		
		return orderDao.saveOrUpdateOrder(model);
	}

	@Override
	public String createALiPayOrder(OrdersModel model) {
		//支付类型
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
		String total_fee = new String(model.getPrices()+"");
		//必填
		//订单描述
		String body = new String(model.getRemark());
		//商品展示地址
		String show_url = new String(LOCAL+"pc/goods.jsp?id="+model.getGoods_ids());
		//需以http://开头的完整路径，例如：http://www.商户网址.com/myorder.html

		//防钓鱼时间戳
		String anti_phishing_key = "";
		//若要使用请调用类文件submit中的query_timestamp函数

		//客户端的IP地址
		String exter_invoke_ip = "";
		//非局域网的外网IP地址，如：221.0.0.1
		//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "create_direct_pay_by_user");
        sParaTemp.put("partner", AlipayConfig.partner);
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
		return sHtmlText;
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
			OrdersModel order = orderDao.getOrderByOutTradeNo(out_trade_no);
			if(order == null) return "FAIL";
			order.setTrade_no(trade_no);
			if("TRADE_SUCCESS".equals(trade_status)){
				order.setState(1);
			}else if("TRADE_FINISHED".equals(trade_status)){
				order.setState(2);
			}
			if(orderDao.saveOrUpdateOrder(order) != null){
				return "SUCCESS";
			}
		}
		return "FAIL";
	}
	

}
