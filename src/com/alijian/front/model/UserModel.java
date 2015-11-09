package com.alijian.front.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "user")
public class UserModel implements Serializable{
	
	private static final long serialVersionUID = 974967453615145826L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column
	private String username;
	
	@Column
	private String password;
	
	@Column
	private String name;		//名称
	
	@Column
	private String address;
	
	@Column
	private String mobile;
	
	@Column
	private int type = 2;		//账户类型:0 平台管理员 1供应商 2采购商(默认)
	
	@Column
	private int status = 0;		//如果type=1才判断此字段，0:待审核 1:审核通过
	
	@Column
	private String description;	//描述
	
	@Column
	private String thum;
	
	@Column
	private Date update_time = new Date();
	
	@Column
	private String types;
	
	@Column
	private BigDecimal credit_supplier;
	
	@Column
	private BigDecimal credit_buyer;
	
	@Column
	private Integer work_type = 0;		//0:供货商 1:阿里健自营(商品标题会显示"自营")
	
	@Column
	private Double commission;		//佣金比例
	
	@Column
	private String accesstoken;//登录令牌
	
	@Column
	private String yyzz;//营业执照
	
	@Column
	private String sfzzm;//身份证正面
	
	@Column
	private String sfzfm;//身份证反面
	
	@Column
	private String jyms;//经营模式
	
	@Column
	private String ppmc;//品牌名称
	
	@Column
	private String nyye;//年营业额
	
	@Column
	private String xsqy;//销售区域
	
	@Column
	private String khqt;//客户群体
	
	@Column
	private String zcd;//注册地
	
	@Column
	private String fddb;//法定代表
	
	@Column
	private String ygrs;//员工人数
	
	@Column
	private String zycp;//主营产品
	
	@Column
	private String contact_name;//联系人名字
	
	@Column
	private String contact_tel;//联系人座机号
	
	@Column
	private int rank;//竞价排名
	
	@Column
	private String imToken;//IM聊天服务器的token
	
	@Transient
	private List<TypeModel> typeList;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getThum() {
		return thum;
	}

	public void setThum(String thum) {
		this.thum = thum;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	public Integer getWork_type() {
		return work_type;
	}

	public void setWork_type(Integer work_type) {
		this.work_type = work_type;
	}

	public Double getCommission() {
		return commission;
	}

	public void setCommission(Double commission) {
		this.commission = commission;
	}

	public List<TypeModel> getTypeList() {
		return typeList;
	}

	public void setTypeList(List<TypeModel> typeList) {
		this.typeList = typeList;
	}

	public BigDecimal getCredit_supplier() {
		return credit_supplier;
	}

	public void setCredit_supplier(BigDecimal credit_supplier) {
		this.credit_supplier = credit_supplier;
	}

	public BigDecimal getCredit_buyer() {
		return credit_buyer;
	}

	public void setCredit_buyer(BigDecimal credit_buyer) {
		this.credit_buyer = credit_buyer;
	}

	public String getAccesstoken() {
		return accesstoken;
	}

	public void setAccesstoken(String accesstoken) {
		this.accesstoken = accesstoken;
	}

	public String getYyzz() {
		return yyzz;
	}

	public void setYyzz(String yyzz) {
		this.yyzz = yyzz;
	}

	public String getSfzzm() {
		return sfzzm;
	}

	public void setSfzzm(String sfzzm) {
		this.sfzzm = sfzzm;
	}

	public String getSfzfm() {
		return sfzfm;
	}

	public void setSfzfm(String sfzfm) {
		this.sfzfm = sfzfm;
	}

	public String getJyms() {
		return jyms;
	}

	public void setJyms(String jyms) {
		this.jyms = jyms;
	}

	public String getPpmc() {
		return ppmc;
	}

	public void setPpmc(String ppmc) {
		this.ppmc = ppmc;
	}

	public String getNyye() {
		return nyye;
	}

	public void setNyye(String nyye) {
		this.nyye = nyye;
	}

	public String getXsqy() {
		return xsqy;
	}

	public void setXsqy(String xsqy) {
		this.xsqy = xsqy;
	}

	public String getKhqt() {
		return khqt;
	}

	public void setKhqt(String khqt) {
		this.khqt = khqt;
	}

	public String getZcd() {
		return zcd;
	}

	public void setZcd(String zcd) {
		this.zcd = zcd;
	}

	public String getFddb() {
		return fddb;
	}

	public void setFddb(String fddb) {
		this.fddb = fddb;
	}

	public String getYgrs() {
		return ygrs;
	}

	public void setYgrs(String ygrs) {
		this.ygrs = ygrs;
	}

	public String getZycp() {
		return zycp;
	}

	public void setZycp(String zycp) {
		this.zycp = zycp;
	}

	public String getContact_name() {
		return contact_name;
	}

	public void setContact_name(String contact_name) {
		this.contact_name = contact_name;
	}

	public String getContact_tel() {
		return contact_tel;
	}

	public void setContact_tel(String contact_tel) {
		this.contact_tel = contact_tel;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getImToken() {
		return imToken;
	}

	public void setImToken(String imToken) {
		this.imToken = imToken;
	}

}
