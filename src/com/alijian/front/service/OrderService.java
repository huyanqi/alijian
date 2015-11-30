package com.alijian.front.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.alijian.front.model.CommentModel;
import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.OrdersSetModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.PayOrder;
import com.alijian.front.model.UserModel;

@Component
public interface OrderService {

	OrdersModel saveOrUpdateOrder(OrdersModel model,UserModel buyer);

	String createALiPayOrder(OrdersModel model,boolean force_pc);

	String changeOrderState(HttpServletRequest request,String out_trade_no, String trade_no, String trade_status);

	PageModel getMySell(int id,int pageNum);

	OrdersModel getOrderById(String orderid);

	String fahuo(String no, String cnumber);

	PageModel getMyBuy(int id, int pageNum);

	String querenshouhuo(String no);

	OrdersModel getOrderByOrderId(int orderid);

	CommentModel saveOrUpdateComment(CommentModel model);

	PageModel getComment(int goods_id, int pageNum);

	String shanchu(int orderid);

	PayOrder createOrder(List<OrdersModel> orders,UserModel buyer,int is_mobile);

	String createALiPayOrder(HttpServletRequest request,String orders_no, String string, double price,
			String remark, String show_url, int is_mobile);

	OrdersSetModel getOrdersSetByOrderNo(String orderno);

	String createWXOrder(HttpServletRequest request, String orders_no, String string, double price, String string2,
			String show_url, int is_mobile);


}
