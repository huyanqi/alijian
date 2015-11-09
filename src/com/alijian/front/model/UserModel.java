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
	private String name;		//����
	
	@Column
	private String address;
	
	@Column
	private String mobile;
	
	@Column
	private int type = 2;		//�˻�����:0 ƽ̨����Ա 1��Ӧ�� 2�ɹ���(Ĭ��)
	
	@Column
	private int status = 0;		//���type=1���жϴ��ֶΣ�0:����� 1:���ͨ��
	
	@Column
	private String description;	//����
	
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
	private Integer work_type = 0;		//0:������ 1:���｡��Ӫ(��Ʒ�������ʾ"��Ӫ")
	
	@Column
	private Double commission;		//Ӷ�����
	
	@Column
	private String accesstoken;//��¼����
	
	@Column
	private String yyzz;//Ӫҵִ��
	
	@Column
	private String sfzzm;//���֤����
	
	@Column
	private String sfzfm;//���֤����
	
	@Column
	private String jyms;//��Ӫģʽ
	
	@Column
	private String ppmc;//Ʒ������
	
	@Column
	private String nyye;//��Ӫҵ��
	
	@Column
	private String xsqy;//��������
	
	@Column
	private String khqt;//�ͻ�Ⱥ��
	
	@Column
	private String zcd;//ע���
	
	@Column
	private String fddb;//��������
	
	@Column
	private String ygrs;//Ա������
	
	@Column
	private String zycp;//��Ӫ��Ʒ
	
	@Column
	private String contact_name;//��ϵ������
	
	@Column
	private String contact_tel;//��ϵ��������
	
	@Column
	private int rank;//��������
	
	@Column
	private String imToken;//IM�����������token
	
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
