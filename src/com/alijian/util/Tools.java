package com.alijian.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import com.alijian.front.controller.OrderController;

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
	public static String newOrderNo(String goodsid,int amount,int seller,int buyer){
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
	
}
