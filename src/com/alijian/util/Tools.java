package com.alijian.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import com.alijian.front.model.UserModel;

public class Tools {

	public static String generateRandomFilename(){    
        String RandomFilename = "";    
        Random rand = new Random();//���������    
        int random = rand.nextInt();    
            
        Calendar calCurrent = Calendar.getInstance();    
        int intDay = calCurrent.get(Calendar.DATE);    
        int intMonth = calCurrent.get(Calendar.MONTH) + 1;    
        int intYear = calCurrent.get(Calendar.YEAR);    
        String now = String.valueOf(intYear) + "_" + String.valueOf(intMonth) + "_" + String.valueOf(intDay) + "_";    
            
        RandomFilename = now + String.valueOf(random > 0 ? random : ( -1) * random);    
            
        return RandomFilename;
    } 
	
	public static String getFilePath(String fileName,HttpServletRequest request){
		return request.getContextPath() + "/" + "images"+ "/" +fileName;
	}
	
	public static long getPageCount(Long total,int pageSize){
		long page = 1;
		if(total%pageSize == 0){
			page = total/pageSize;
		}else{
			page = (total/pageSize)+1;
		}
		return page;
	}
	
	public static int getPageSize(int pageSize){
		if(pageSize > 20)
			pageSize = 20;
		return pageSize;
	}
	
	/**
	 * ���ɶ����Ź���:
	 * "ALJ"+��ǰʱ��+"-"+��ƷID+"-"+��������+"-"+����ID+"-"+���ID
	 * @return
	 */
	public static String newOrderNo(int goodsid,int amount,int seller,int buyer){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		StringBuffer orderNo = new StringBuffer("ALJ");
		orderNo.append(sdf.format(new Date()));
		orderNo.append("-");
		orderNo.append(goodsid);
		orderNo.append("-");
		orderNo.append(amount);
		orderNo.append("-");
		orderNo.append(seller);
		orderNo.append("-");
		orderNo.append(buyer);
		return orderNo.toString();
	}
	
	/**
	 * ��װ��Ʒ������sql
	 * @param type ��������:0 Ĭ�� 1���۸�ӵ͵��� 2���۸�Ӹߵ��� 3�������Ӹߵ���
	 * @return
	 */
	public static String getOrderBySQL(int type){
		String sql = "";
		switch (type) {
		case 0:
			sql = "ORDER BY update_time DESC";
			break;
		case 1:
			sql = "ORDER BY price DESC";
			break;
		case 2:
			sql = "ORDER BY price ASC";
			break;
		case 3:
			sql = "ORDER BY sales_volume DESC";
			break;
		}
		return sql;
	}
	
	public static String getChatName(UserModel user){
		//��name����name,û������username
		if(!"".equals(user.getName())){
			return user.getName();
		}
		return user.getUsername();
	}
	
	/*
	 * ��ȡ��¼����
	 */
	public static String getAccessToken() {
	    String base = "abcdefghijklmnopqrstuvwxyz0123456789";   
	    Random random = new Random();   
	    StringBuffer sb = new StringBuffer();   
	    for (int i = 0; i < 20; i++) {   
	        int number = random.nextInt(base.length());   
	        sb.append(base.charAt(number));   
	    }   
	    return sb.toString();   
	 } 
	
	/**
     * ��SHA1�㷨���ɰ�ȫǩ��
     * @param token Ʊ��
     * @param timestamp ʱ���
     * @param nonce ����ַ���
     * @param encrypt ����
     * @return ��ȫǩ��
     * @throws NoSuchAlgorithmException 
     * @throws AesException 
     */
	public static String getSHA1(String token, String timestamp, String nonce)
			throws NoSuchAlgorithmException {
		String[] array = new String[] { token, timestamp, nonce };
		StringBuffer sb = new StringBuffer();
		// �ַ�������
		Arrays.sort(array);
		for (int i = 0; i < 3; i++) {
			sb.append(array[i]);
		}
		String str = sb.toString();
		// SHA1ǩ������
		MessageDigest md = MessageDigest.getInstance("SHA-1");
		md.update(str.getBytes());
		byte[] digest = md.digest();

		StringBuffer hexstr = new StringBuffer();
		String shaHex = "";
		for (int i = 0; i < digest.length; i++) {
			shaHex = Integer.toHexString(digest[i] & 0xFF);
			if (shaHex.length() < 2) {
				hexstr.append(0);
			}
			hexstr.append(shaHex);
		}
		return hexstr.toString();
	}
	
}
