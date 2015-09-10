package com.alijian.front.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.alijian.front.dao.OrderDao;
import com.alijian.front.model.OrdersModel;

@Repository("orderDao")
public class OrderDaoImpl extends HibernateDaoSupport implements OrderDao {

	@Override
	public OrdersModel saveOrUpdateOrder(OrdersModel model) {
		try{
			getHibernateTemplate().saveOrUpdate(model);
			return model;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public OrdersModel getOrderByOutTradeNo(String out_trade_no) {
		List<OrdersModel> list = (List<OrdersModel>) getHibernateTemplate().find("FROM OrdersModel model WHERE model.orders_no = ?", out_trade_no);
		if(list.size() > 0)
			return list.get(0);
		return null;
	}

}
