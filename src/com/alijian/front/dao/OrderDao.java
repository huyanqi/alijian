package com.alijian.front.dao;

import org.springframework.stereotype.Component;

import com.alijian.front.model.OrdersModel;

@Component
public interface OrderDao {

	OrdersModel saveOrUpdateOrder(OrdersModel model);

	OrdersModel getOrderByOutTradeNo(String out_trade_no);

	void addCredit(int i, OrdersModel order);


}
