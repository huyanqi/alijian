package com.alijian.front.dao.impl;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.alijian.front.dao.AdminDao;
import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.TypeModel;
import com.alijian.front.model.UserModel;
import com.alijian.util.Tools;

@Repository("adminDao")
public class AdminDaoImpl extends HibernateDaoSupport implements AdminDao {

	private final int PAGE_SIZE = 20;
	
	@Override
	public boolean saveOrUpdateTypeModel(TypeModel model) {
		try{
			getHibernateTemplate().saveOrUpdate(model);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<TypeModel> getTypeModelByType(int type) {
		return (List<TypeModel>) getHibernateTemplate().find("FROM TypeModel model WHERE model.type = ?", type);
	}

	@Override
	public TypeModel getTypeById(int id) {
		List<TypeModel> models = (List<TypeModel>) getHibernateTemplate().find("FROM TypeModel model WHERE model.id = ?", id);
		if(models.size() > 0){
			return models.get(0);
		}
		return null;
	}

	@Override
	public String removeTypeById(int id) {
		try{
			getHibernateTemplate().delete(getTypeById(id));
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public String insertLecturer(LecturerModel model) {
		try{
			getHibernateTemplate().saveOrUpdate(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public List<LecturerModel> getAllLecturers() {
		List<LecturerModel> models = (List<LecturerModel>) getHibernateTemplate().find("FROM LecturerModel");
		for(LecturerModel model : models){
			String[] types = model.types.split(",");
			for(String type : types){
				model.typeList.add(getTypeById(Integer.parseInt(type)));
			}
		}
		return models;
	}

	@Override
	public String removeLecturerById(LecturerModel model) {
		try{
			getHibernateTemplate().delete(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public LecturerModel getLecturerById(int id) {
		List<LecturerModel> models = (List<LecturerModel>) getHibernateTemplate().find("FROM LecturerModel model WHERE model.id = ?", id);
		if(models.size() > 0){
			return models.get(0);
		}
		return null;
	}

	@Override
	public List<UserModel> getAllUser(int type, int status) {
		List<UserModel> models = (List<UserModel>) getHibernateTemplate().find("FROM UserModel model WHERE model.type = ? AND model.status = ?", type,status);
		return models;
	}

	@Override
	public UserModel getUserById(int uid) {
		List<UserModel> models = (List<UserModel>) getHibernateTemplate().find("FROM UserModel model WHERE model.id = ?", uid);
		if(models.size() > 0)
			return models.get(0);
		return null;
	}

	@Override
	public String insertGoods(GoodsModel model) {
		try{
			getHibernateTemplate().saveOrUpdate(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public PageModel getMyGoods(final int uid, int pageNum) {
		final PageModel model = new PageModel();
		final int starts = (pageNum-1)*PAGE_SIZE;
		String hql = "SELECT COUNT(*) FROM GoodsModel model WHERE model.user.id = "+uid;
		long total = ((Long)getHibernateTemplate().iterate(hql).next()).intValue();
		model.setPageCount(Tools.getPageCount(total, PAGE_SIZE));
		final String queryString = "FROM GoodsModel model WHERE model.user.id = "+uid+" ORDER BY model.update_time DESC";
		return getHibernateTemplate().execute(new HibernateCallback<PageModel>() {
			@Override
			public PageModel doInHibernate(Session session) throws HibernateException {
				model.setModels(session.createQuery(queryString).setFirstResult(starts).setMaxResults(PAGE_SIZE).list());
				return model;
			}
		});
	}

	@Override
	public GoodsModel getGoodsById(int id) {
		List<GoodsModel> models = (List<GoodsModel>) getHibernateTemplate().find("FROM GoodsModel model WHERE model.id = ?", id);
		if(models.size() > 0){
			return models.get(0);
		}
		return null;
	}

	@Override
	public String removeGoods(GoodsModel model) {
		try{
			getHibernateTemplate().delete(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public List<GoodsModel> getGoods(int pageNum,final int pageSize,final String types,final String keyword,final int type,final int supplier_id) {
		final int size = Tools.getPageSize(pageSize);
		final int starts = (pageNum-1)*pageSize;
		return (List<GoodsModel>) getHibernateTemplate().execute(new HibernateCallback<List<GoodsModel>>() {
			@Override
			public List<GoodsModel> doInHibernate(Session session) throws HibernateException {
				String[] typesArray = types.split(",");
				String findSql = "";
				boolean hasWhere = false;
				for(String type:typesArray){
					if("".equals(type)) break;
					findSql += " find_in_set("+type+", types) AND ";
				}
				if(!"".equals(findSql)){
					findSql = findSql.substring(0, findSql.length()-3);
				}
				hasWhere = findSql.length() > 0;
				String sql = "";
				if(type == 0){
					//默认搜索，需要竞价
					//规则：先查询出拥有竞价条件的商户个数
					String supplierSql = supplier_id != 0 ? (" AND g.user = "+supplier_id) : "";
					sql = "SELECT * FROM (SELECT g.* FROM goods g LEFT JOIN user ON g.user = user.id WHERE user.rank != 0 AND g.name LIKE '%"+keyword+"%' "+supplierSql+" AND g.status = 0 ORDER BY user.rank DESC, g.update_time DESC) AS t1 GROUP BY user";
					
					List<GoodsModel> list =  session.createSQLQuery(sql).addEntity(GoodsModel.class).setFirstResult(starts).setMaxResults(size).list();
					Collections.reverse(list);
					if(list.size() < pageSize){
						//竞价排名商品不够pageSize,则用普通查询填充剩下个数
						int newpageSize = pageSize-list.size();
						sql = "SELECT * FROM goods g WHERE g.name LIKE '%"+keyword+"%' "+supplierSql+" AND g.status = 0 ORDER BY g.update_time DESC";
						list.addAll(session.createSQLQuery(sql).addEntity(GoodsModel.class).setFirstResult(starts).setMaxResults(newpageSize).list());
					}
					return list;
				}else{
					String supplierSql = supplier_id != 0 ? (" AND user = "+supplier_id) : "";
					String orderby = Tools.getOrderBySQL(type);
					sql = "SELECT * FROM goods g "+(hasWhere ? "WHERE":"")+ findSql+" "+ (hasWhere ? "AND ":"WHERE ")+"name LIKE '%"+keyword+"%'"+" AND g.status = 0 " +supplierSql+" "+orderby;
					List<GoodsModel> list = session.createSQLQuery(sql).addEntity(GoodsModel.class).setFirstResult(starts).setMaxResults(size).list();;
					return list;
				}
			}
		});
	}

	@Override
	public String insertOrUpdateModel(Object object) {
		try{
			getHibernateTemplate().saveOrUpdate(object);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public String removeObject(Object obj) {
		try{
			getHibernateTemplate().delete(obj);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

}
