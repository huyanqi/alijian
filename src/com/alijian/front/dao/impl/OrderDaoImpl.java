package com.alijian.front.dao.impl;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.alijian.front.dao.OrderDao;
import com.alijian.front.model.CommentModel;
import com.alijian.front.model.OrdersModel;
import com.alijian.front.model.OrdersSetModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.PayOrder;
import com.alijian.util.Tools;

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
	public OrdersSetModel getOrderSetByOutTradeNo(String out_trade_no) {
		List<OrdersSetModel> list = (List<OrdersSetModel>) getHibernateTemplate().find("FROM OrdersSetModel model WHERE model.orders_no = ?", out_trade_no);
		if(list.size() > 0)
			return list.get(0);
		return null;
	}

	/**
	 * type
	 * 0:增加买家积分
	 * 1:增加卖家积分
	 */
	@Override
	public void addCredit(int type, OrdersModel order) {
		return;
		/*if(type == 0){
			//查询出买家信息
			List<UserModel> list = (List<UserModel>) getHibernateTemplate().find("FROM UserModel model WHERE model.id = ?", order.getBuyer());
			if(list.size() > 0){
				UserModel user = list.get(0);
				//更新买家积分
				user.setCredit_buyer(user.getCredit_buyer().add(order.getPrices()));
				getHibernateTemplate().update(user);
			}
		}else if(type == 1){
			//查询出所买商品
			String[] ids = order.getGoods_ids().split(",");
			for(String goodId:ids){
				List<GoodsModel> goods = (List<GoodsModel>)getHibernateTemplate().find("FROM GoodsModel model WHERE model.id = ?", goodId);
				if(goods.size() > 0){
					GoodsModel goodsModel = goods.get(0);
					//获得
					//先把价格区间做出来，再做此功能
				}
			}
		}*/
	}

	@Override
	public PageModel getMySell(int id,int pageNum) {
		final PageModel model = new PageModel();
		final int starts = (pageNum-1)*20;
		String hql = "SELECT COUNT(*) FROM OrdersModel model WHERE model.saller = "+id+" AND model.status = 0 OR model.status = 1";
		long total = ((Long)getHibernateTemplate().iterate(hql).next()).intValue();
		model.setPageCount(Tools.getPageCount(total, 20));
		final String queryString = "FROM OrdersModel model WHERE model.saller = "+id+" AND model.status = 0 ORDER BY model.update_time DESC";
		return getHibernateTemplate().execute(new HibernateCallback<PageModel>() {
			@Override
			public PageModel doInHibernate(Session session) throws HibernateException {
				model.setModels(session.createQuery(queryString).setFirstResult(starts).setMaxResults(20).list());
				return model;
			}
		});
	}

	@Override
	public OrdersModel getOrderById(String orderid) {
		List<OrdersModel> list = (List<OrdersModel>) getHibernateTemplate().find("FROM OrdersModel model WHERE model.orders_no = ?", orderid);
		if(list.size() > 0)
			return list.get(0);
		return null;
	}

	@Override
	public PageModel getMyBy(int id, int pageNum) {
		final PageModel model = new PageModel();
		final int starts = (pageNum-1)*20;
		String hql = "SELECT COUNT(*) FROM OrdersSetModel model WHERE model.buyer = "+id +" AND model.status = 0 ";
		long total = ((Long)getHibernateTemplate().iterate(hql).next()).intValue();
		model.setPageCount(Tools.getPageCount(total, 20));
		final String queryString = "FROM OrdersSetModel model WHERE model.buyer = "+id+" AND model.status = 0 ORDER BY model.update_time DESC";
		return getHibernateTemplate().execute(new HibernateCallback<PageModel>() {
			@Override
			public PageModel doInHibernate(Session session) throws HibernateException {
				model.setModels(session.createQuery(queryString).setFirstResult(starts).setMaxResults(20).list());
				return model;
			}
		});
	}

	@Override
	public OrdersSetModel getOrderSetById(int orderid) {
		List<OrdersSetModel> list = (List<OrdersSetModel>) getHibernateTemplate().find("FROM OrdersSetModel model WHERE model.id = ?", orderid);
		if(list.size() > 0)
			return list.get(0);
		return null;
	}

	@Override
	public CommentModel saveOrUpdateComment(CommentModel model) {
		getHibernateTemplate().saveOrUpdate(model);
		return model;
	}

	@Override
	public PageModel getComment(int goods_id, int pageNum) {
		final PageModel model = new PageModel();
		final int starts = (pageNum-1)*20;
		String hql = "SELECT COUNT(*) FROM CommentModel model WHERE model.good_id = "+goods_id;
		long total = ((Long)getHibernateTemplate().iterate(hql).next()).intValue();
		model.setPageCount(Tools.getPageCount(total, 20));
		final String queryString = "FROM CommentModel model WHERE model.good_id = "+goods_id+" ORDER BY model.update_time DESC";
		return getHibernateTemplate().execute(new HibernateCallback<PageModel>() {
			@Override
			public PageModel doInHibernate(Session session) throws HibernateException {
				model.setModels(session.createQuery(queryString).setFirstResult(starts).setMaxResults(20).list());
				return model;
			}
		});
	}

	@Override
	public String shanchu(int ordersetid) {
		try{
			OrdersSetModel ordersModel = getOrderSetById(ordersetid);
			ordersModel.setStatus(1);
			saveOrUpdateModel(ordersModel);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public PayOrder getPayOrderByOutTradeNo(String out_trade_no) {
		List<PayOrder> list = (List<PayOrder>) getHibernateTemplate().find("FROM PayOrder model WHERE model.orders_no = ?", out_trade_no);
		if(list.size() > 0)
			return list.get(0);
		return null;
	}

	@Override
	public void saveOrUpdateModel(Object object) {
		getHibernateTemplate().saveOrUpdate(object);
	}

	@Override
	public OrdersSetModel getOrdersSetByOrderNo(String orderno) {
		List<OrdersSetModel> list = (List<OrdersSetModel>) getHibernateTemplate().find("FROM OrdersSetModel model WHERE model.orders_no = ?", orderno);
		if(list.size() > 0)
			return list.get(0);
		return null;
	}

}
