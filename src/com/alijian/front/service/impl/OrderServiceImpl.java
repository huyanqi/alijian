package com.alijian.front.service.impl;

import java.math.BigDecimal;
import java.text.DecimalFormat;
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
import com.alijian.front.dao.OrderDao;
import com.alijian.front.model.CommentModel;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.PageModel;
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

	@Override
	public OrdersModel saveOrUpdateOrder(OrdersModel model,UserModel buyer) {
		GoodsModel goods = adminDao.getGoodsById(model.getGood_id());
		if(goods == null) return null;
		//���ɶ�����
		model.setOrders_no(Tools.newOrderNo(model.getGood_id(), model.getAmout(), goods.getUser().getId(), buyer.getId()));
		//���㶩���ܶ�
		DecimalFormat df = new DecimalFormat("######0.00");
		model.setPrices(new BigDecimal(Double.valueOf(df.format(model.getAmout() * goods.getPrice()))));
		//�������ID
		model.setBuyer(buyer.getId());
		//��������ID
		model.setSaller(goods.getUser().getId());
		//���ö�������ʱ��
		model.setCreate_time(new Date());
		
		return orderDao.saveOrUpdateOrder(model);
	}

	/**
	 * ����֧������������
	 * @param model
	 * @param force_pc �Ƿ�ǿ��ʹ��PC�˸���
	 * @return
	 */
	@Override
	public String createALiPayOrder(OrdersModel model,boolean force_pc) {
		//֧������
		String payment_type = "1";
		//��������޸�
		//�������첽֪ͨҳ��·��
		String notify_url = LOCAL+"change_order_state";//notify_url.jsp
		//��http://��ʽ������·�������ܼ�?id=123�����Զ������
		//ҳ����תͬ��֪ͨҳ��·��
		String return_url = LOCAL+"return_url.jsp";
		//��http://��ʽ������·�������ܼ�?id=123�����Զ������������д��http://localhost/
		//�̻�������
		String out_trade_no = new String(model.getOrders_no());
		//�̻���վ����ϵͳ��Ψһ�����ţ�����
		//��������
		String subject = new String(model.getOrders_no());//��ʱ�ö�����
		//����
		//������
		double price = model.getPrices().setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();  
		String total_fee = new String(price+"");
		//����
		//��������
		String body = new String(model.getRemark());
		//��Ʒչʾ��ַ
		String show_url = new String(LOCAL+"pc/goods.jsp?id="+model.getGood_id());
		//����http://��ͷ������·�������磺http://www.�̻���ַ.com/myorder.html

		//������ʱ���
		String anti_phishing_key = "";
		//��Ҫʹ����������ļ�submit�е�query_timestamp����

		//�ͻ��˵�IP��ַ
		String exter_invoke_ip = "";
		//�Ǿ�����������IP��ַ���磺221.0.0.1
		//������������������
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
		
		//��������
		String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","ȷ��");
		return sHtmlText;
	}

	@Override
	public String changeOrderState(HttpServletRequest request,String out_trade_no, String trade_no,String trade_status) {
		//��ȡ֧����POST����������Ϣ
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
			//����������δ����ڳ�������ʱʹ�á����mysign��sign�����Ҳ����ʹ����δ���ת��
			//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}
		if(AlipayNotify.verify(params)){//��֤�ɹ�
			OrdersModel order = orderDao.getOrderByOutTradeNo(out_trade_no);
			if(order == null) return "FAIL";
			order.setTrade_no(trade_no);
			if("TRADE_SUCCESS".equals(trade_status)){
				order.setState(1);
			}else if("TRADE_FINISHED".equals(trade_status)){
				order.setState(2);
			}
			//������ҡ����һ���
			//orderDao.addCredit(0,order);
			if(orderDao.saveOrUpdateOrder(order) != null){
				return "SUCCESS";
			}
		}
		return "FAIL";
	}

	@Override
	public PageModel getMySell(int id,int pageNum) {
		PageModel model = orderDao.getMySell(id,pageNum);
		for(Object order:model.getModels()){
			((OrdersModel) order).setGoods(baseService.getGoodsModelById(((OrdersModel) order).getGood_id()));
		}
		return model;
	}

	@Override
	public OrdersModel getOrderById(String orderid) {
		OrdersModel model = orderDao.getOrderById(orderid);
		model.setGoods(baseService.getGoodsModelById(model.getGood_id()));
		return model;
	}

	@Override
	public String fahuo(String no, String cnumber) {
		try{
			OrdersModel model = getOrderById(no);
			model.setCnumber(cnumber);
			model.setState(4);
			orderDao.saveOrUpdateOrder(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public PageModel getMyBy(int id, int pageNum) {
		PageModel model = orderDao.getMyBy(id,pageNum);
		for(Object order:model.getModels()){
			((OrdersModel) order).setGoods(baseService.getGoodsModelById(((OrdersModel) order).getGood_id()));
		}
		return model;
	}

	@Override
	public String querenshouhuo(String no) {
		try{
			OrdersModel model = getOrderById(no);
			model.setState(2);
			orderDao.saveOrUpdateOrder(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public OrdersModel getOrderByOrderId(int orderid) {
		OrdersModel model = orderDao.getOrderByOrderId(orderid);
		model.setGoods(baseService.getGoodsModelById(model.getGood_id()));
		return model;
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
	

}
