package com.alijian.front.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.UserModel;

@Component
public interface OrderService {

	OrdersModel saveOrUpdateOrder(OrdersModel model,UserModel buyer);

	String createALiPayOrder(OrdersModel model);

	String changeOrderState(HttpServletRequest request,String out_trade_no, String trade_no, String trade_status);


}
