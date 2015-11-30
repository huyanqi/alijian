package com.alijian.util;

import java.math.BigDecimal;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import com.alijian.front.model.GoodsModel;
import com.alijian.front.model.PriceModel;
import com.alijian.front.model.UserModel;

public class Tools {

	public static String generateRandomFilename(){    
        String RandomFilename = "";    
        Random rand = new Random();//生成随机数    
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
	 * 生成订单号规则:
	 * "ALJ"+当前时间+"-"+商品ID+"-"+购买数量+"-"+卖家ID+"-"+买家ID
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
	 * 组装商品的排序sql
	 * @param type 搜索类型:0 默认 1：价格从低到高 2：价格从高到低 3：销量从高到低
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
		//有name就用name,没有则用username
		if(!"".equals(user.getName())){
			return user.getName();
		}
		return user.getUsername();
	}
	
	/*
	 * 获取登录令牌
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
     * 用SHA1算法生成安全签名
     * @param token 票据
     * @param timestamp 时间戳
     * @param nonce 随机字符串
     * @param encrypt 密文
     * @return 安全签名
     * @throws NoSuchAlgorithmException 
     * @throws AesException 
     */
	public static String getSHA1(String token, String timestamp, String nonce)
			throws NoSuchAlgorithmException {
		String[] array = new String[] { token, timestamp, nonce };
		StringBuffer sb = new StringBuffer();
		// 字符串排序
		Arrays.sort(array);
		for (int i = 0; i < 3; i++) {
			sb.append(array[i]);
		}
		String str = sb.toString();
		// SHA1签名生成
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
	
	public static BigDecimal getPrice(int amount,GoodsModel goods,PriceModel priceModel){
		//获取购买总额
			double totalprice = -1;
			//获取批发价对象
			if(priceModel != null){
				//有批发价,查询批发价对象
				//计算批发价，查询出这个范围的批发单价
				String[] startCount = priceModel.startCount.split(",");
				String[] endCount = priceModel.endCount.split(",");
				String[] prices = priceModel.price.split(",");
				for(int i=0;i<prices.length;i++){
					String start = "";
					String end = "";
					if(i <= startCount.length-1){
						start = startCount[i];
					}
					if(i <= endCount.length-1){
						end = endCount[i];
					}
					
					int startNum = 0;
					int endNum;
					if("".equals(start)) startNum = 0;
					else startNum = Integer.valueOf(start);
					if("".equals(end)) endNum = 999999999;
					else endNum = Integer.valueOf(endCount[i]);
					if(startNum <= amount && amount <= endNum){
						totalprice = Double.parseDouble(prices[i]) * amount;
						break;
					}
				}
				
				if(totalprice == -1){
					totalprice = amount * goods.getPrice();
				}
				
			}else{
				totalprice = amount * goods.getPrice();
			}
			
			return new BigDecimal(totalprice);
	}
	
}
