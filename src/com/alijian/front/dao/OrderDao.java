package com.alijian.front.dao;

import org.springframework.stereotype.Component;

import com.alijian.front.model.CommentModel;
import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.OrdersSetModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.PayOrder;

@Component
public interface OrderDao {

	OrdersModel saveOrUpdateOrder(OrdersModel model);

	OrdersSetModel getOrderSetByOutTradeNo(String out_trade_no);

	void addCredit(int i, OrdersModel order);

	PageModel getMySell(int id,int pageNum);

	OrdersModel getOrderById(String orderid);

	PageModel getMyBy(int id, int pageNum);

	OrdersSetModel getOrderSetById(int orderid);

	CommentModel saveOrUpdateComment(CommentModel model);

	PageModel getComment(int goods_id, int pageNum);

	String shanchu(int orderid);

	PayOrder getPayOrderByOutTradeNo(String out_trade_no);

	void saveOrUpdateModel(Object object);

	OrdersSetModel getOrdersSetByOrderNo(String orderno);

}
