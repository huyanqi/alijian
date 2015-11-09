package com.alijian.front.dao;

import org.springframework.stereotype.Component;

import com.alijian.front.model.CommentModel;
import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.PageModel;

@Component
public interface OrderDao {

	OrdersModel saveOrUpdateOrder(OrdersModel model);

	OrdersModel getOrderByOutTradeNo(String out_trade_no);

	void addCredit(int i, OrdersModel order);

	PageModel getMySell(int id,int pageNum);

	OrdersModel getOrderById(String orderid);

	PageModel getMyBy(int id, int pageNum);

	OrdersModel getOrderByOrderId(int orderid);

	CommentModel saveOrUpdateComment(CommentModel model);

	PageModel getComment(int goods_id, int pageNum);

}
