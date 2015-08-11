package com.alijian.front.dao.impl;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.alijian.front.dao.BaseDao;
import com.alijian.front.model.BusinessModel;
import com.alijian.front.model.LecturerModel;
import com.alijian.front.model.PageModel;
import com.alijian.front.model.UserModel;
import com.alijian.util.Tools;

@Repository("baseDao")
public class BaseDaoImpl extends HibernateDaoSupport implements BaseDao {

	private int PAGE_SIZE = 20;
	
	@Override
	public LecturerModel getLecturerModelById(int id) {
		List<LecturerModel> list = (List<LecturerModel>) getHibernateTemplate().find("FROM LecturerModel model WHERE model.id = ?", id);
		if(list.size() > 0)
			return list.get(0);
		return null;
	}

	@Override
	public String saveOrUpdateUser(UserModel model) {
		try{
			getHibernateTemplate().saveOrUpdate(model);
			return "";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@Override
	public UserModel getUserByUsername(String username) {
		List<UserModel> users = (List<UserModel>) getHibernateTemplate().find("FROM UserModel model WHERE model.username = ?", username);
		if(users.size() > 0)
			return users.get(0);
		else
			return null;
	}

	@Override
	public UserModel login(String username, String password) {
		List<UserModel> user = (List<UserModel>) getHibernateTemplate().find("FROM UserModel user WHERE user.username = ? AND user.password = ?", username, password);
		if(user.size() > 0)
			return user.get(0);
		return null;
	}

	@Override
	public List<UserModel> getUsers(final int pageSize, int type, int status) {
		final String queryString = "FROM UserModel model WHERE type = "+type+" AND status = "+status+" ORDER BY model.update_time DESC";
		return getHibernateTemplate().execute(new HibernateCallback<List<UserModel>>() {
			@SuppressWarnings("unchecked")
			@Override
			public List<UserModel> doInHibernate(Session session) throws HibernateException {
				List<UserModel> models = session.createQuery(queryString).setMaxResults(pageSize).list();
				return models;
			}
		});
	}

	@Override
	public UserModel getUserById(int uid) {
		List<UserModel> models = (List<UserModel>) getHibernateTemplate().find("FROM UserModel model WHERE model.id = ?", uid);
		if(models.size() > 0){
			return models.get(0);
		}
		return null;
	}

	@Override
	public List<BusinessModel> getBusinessModels(int pageNum, int pageSize,final String types) {
		final int size = Tools.getPageSize(pageSize);
		final int starts = (pageNum-1)*pageSize;
		return (List<BusinessModel>) getHibernateTemplate().execute(new HibernateCallback<List<BusinessModel>>() {
			@Override
			public List<BusinessModel> doInHibernate(Session session) throws HibernateException {
				String[] typesArray = types.split(",");
				String findSql = "";
				for(String type:typesArray){
					if("".equals(type)) break;
					findSql += " find_in_set("+type+", types) AND";
				}
				String sql = "SELECT * FROM business "+ (findSql.length() > 0 ? "WHERE":"") + findSql+" ORDER BY update_time DESC";
				return session.createSQLQuery(sql).addEntity(BusinessModel.class).setFirstResult(starts).setMaxResults(size).list();
			}
		});
	}

	@Override
	public BusinessModel getBusinessById(int id) {
		List<BusinessModel> models = (List<BusinessModel>) getHibernateTemplate().find("FROM BusinessModel model WHERE model.id = ?", id);
		if(models.size() > 0){
			return models.get(0);
		}
		return null;
	}

	@Override
	public List<UserModel> getSuppliers(int pageNum,int pageSize, final String types) {
		final int size = Tools.getPageSize(pageSize);
		final int starts = (pageNum-1)*pageSize;
		return (List<UserModel>) getHibernateTemplate().execute(new HibernateCallback<List<UserModel>>() {
			@Override
			public List<UserModel> doInHibernate(Session session) throws HibernateException {
				String[] typesArray = types.split(",");
				String findSql = "";
				for(String type:typesArray){
					if("".equals(type)) break;
					findSql += " find_in_set("+type+", types) AND";
				}
				String sql = "SELECT * FROM user WHERE "+ findSql+" type = 1 AND status = 1 ORDER BY update_time DESC";
				System.out.println(sql);
				return session.createSQLQuery(sql).addEntity(UserModel.class).setFirstResult(starts).setMaxResults(size).list();
			}
		});
	}

	@Override
	public List<LecturerModel> getLecturers(int pageNum, int pageSize,final String types) {
		final int size = Tools.getPageSize(pageSize);
		final int starts = (pageNum-1)*pageSize;
		return (List<LecturerModel>) getHibernateTemplate().execute(new HibernateCallback<List<LecturerModel>>() {
			@Override
			public List<LecturerModel> doInHibernate(Session session) throws HibernateException {
				String[] typesArray = types.split(",");
				String findSql = "";
				for(String type:typesArray){
					if("".equals(type)) break;
					findSql += " find_in_set("+type+", types) AND";
				}
				String sql = "SELECT * FROM lecturer "+ (findSql.length() > 0 ? "WHERE":"") + findSql+" ORDER BY update_time DESC";
				return session.createSQLQuery(sql).addEntity(LecturerModel.class).setFirstResult(starts).setMaxResults(size).list();
			}
		});
	}

	@Override
	public UserModel getSupplierById(int uid) {
		List<UserModel> models = (List<UserModel>) getHibernateTemplate().find("FROM UserModel model WHERE model.id = ? AND type= 1 AND status = 1", uid);
		if(models.size() > 0){
			return models.get(0);
		}
		return null;
	}

}
