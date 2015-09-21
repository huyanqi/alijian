package com.alijian.front.dao.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.alijian.front.dao.OrderDao;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.UserModel;

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

	/**
	 * type
	 * 0:������һ���
	 * 1:�������һ���
	 */
	@Override
	public void addCredit(int type, OrdersModel order) {
		if(type == 0){
			//��ѯ�������Ϣ
			List<UserModel> list = (List<UserModel>) getHibernateTemplate().find("FROM UserModel model WHERE model.id = ?", order.getBuyer());
			if(list.size() > 0){
				UserModel user = list.get(0);
				//������һ���
				user.setCredit_buyer(user.getCredit_buyer().add(new BigDecimal(order.getPrices())));
				getHibernateTemplate().update(user);
			}
		}else if(type == 1){
			//��ѯ��������Ʒ
			String[] ids = order.getGoods_ids().split(",");
			for(String goodId:ids){
				List<GoodsModel> goods = (List<GoodsModel>)getHibernateTemplate().find("FROM GoodsModel model WHERE model.id = ?", goodId);
				if(goods.size() > 0){
					GoodsModel goodsModel = goods.get(0);
					//���
					�ȰѼ۸������������������˹���
				}
			}
		}
	}
}
