package com.alijian.util;

import java.util.Calendar;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

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
	
}
