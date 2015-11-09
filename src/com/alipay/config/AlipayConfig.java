package com.alipay.config;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *版本：3.3
 *日期：2012-08-10
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
	
 *提示：如何获取安全校验码和合作身份者ID
 *1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
 *2.点击“商家服务”(https://b.alipay.com/order/myOrder.htm)
 *3.点击“查询合作者身份(PID)”、“查询安全校验码(Key)”

 *安全校验码查看时，输入支付密码后，页面呈灰色的现象，怎么办？
 *解决方法：
 *1、检查浏览器配置，不让浏览器做弹框屏蔽设置
 *2、更换浏览器或电脑，重新登录查询。
 */

public class AlipayConfig {
	
	//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	// 合作身份者ID，以2088开头由16位纯数字组成的字符串
	public static String partner = "2088021313669461";
	
	// 收款支付宝账号
	public static String seller_email = "2925508720@qq.com";
	// 商户的私钥
	public static String key = "i5y64hxelnrbpbxp3ifzqkgdmsj38g2f";

	//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	
	//WAP版配置
	// 收款支付宝账号，以2088开头由16位纯数字组成的字符串
	public static String seller_id = partner;
	// 商户的私钥
	public static String private_key = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAOlPTnBBlFoUVr7TYsU59oGYVpFiz9iGTI4Bop1L7yF7BMlHN/Mp7Xdcsq05X0vyuBU4sC8sZHCfYvLyH+kp8Q2fvpuXWAneQxWEV2NhR/SD+Yu+OfRRKU8enQKM4KIZSw4Wwx/if/bfIfbEGlR+vsYB353vvU5Ndk01Jsrvc+IrAgMBAAECgYAPkyrCVa5ooQj1bjkev3LUTe4hgH4tjzGXHUbUx1fsXUEBis6SXg8rM7X92GGjOU3OpN0mGQmPdyRs4Xr93r3nsUv0u8+vajtq+GTnm2JqvNaQV6dmUiyCSw0tKCt54/VeCZDjOa1bzH0eMwc1kcSOm69Xc+WZG43O1klgzauxUQJBAPXAxo0uubJ1gINHpVg1/Cc3YR2mvSi7DLiT4yagpf2wIks9LnkNVIMUVsctPfkrFCWixwTG91mKjNJmkmdBNxkCQQDzCbV0ogPQls0DaM0OgrhVMUZKsPEzJhV8PlvEEd88H7+t3GF+ArogFLky+Cu0jncKDqnoCJiJ1uXFVbg1FB/jAkBqZ8WQa6LLukSikursfrNm53uNMxzD/flMEfxQRU6ZwSGYIi11DGiDONM5+kTTFevrP8ecMen3Qx4mG3NYccxBAkAcFXIfYR1ZvCNCkpinZZmRVplNxjaI94yiB76o4HvQQcbvezjUy9HgJSTla+H5AkFlKx6dDmk5/FgevnIDyCiLAkEA5Qkn7iSuSy+A/mTdkGlubebWkAVO+ZSgY7mAIPqKTBTAhZzQpnbboZoUS06aDlzw5yt9ayPbZCY1oS+wwBRz5A==";
	
	// 支付宝的公钥，无需修改该值
	public static String ali_public_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB";
	

	// 调试用，创建TXT日志文件夹路径
	public static String log_path = "D:\\";

	// 字符编码格式 目前支持 gbk 或 utf-8
	public static String input_charset = "utf-8";
	
	// 签名方式 不需修改
	public static String sign_type = "MD5";

}
