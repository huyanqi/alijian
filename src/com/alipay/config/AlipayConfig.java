package com.alipay.config;

/* *
 *������AlipayConfig
 *���ܣ�����������
 *��ϸ�������ʻ��й���Ϣ������·��
 *�汾��3.3
 *���ڣ�2012-08-10
 *˵����
 *���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���վ����Ҫ�����ռ����ĵ���д,����һ��Ҫʹ�øô��롣
 *�ô������ѧϰ���о�֧�����ӿ�ʹ�ã�ֻ���ṩһ���ο���
	
 *��ʾ����λ�ȡ��ȫУ����ͺ��������ID
 *1.������ǩԼ֧�����˺ŵ�¼֧������վ(www.alipay.com)
 *2.������̼ҷ���(https://b.alipay.com/order/myOrder.htm)
 *3.�������ѯ���������(PID)��������ѯ��ȫУ����(Key)��

 *��ȫУ����鿴ʱ������֧�������ҳ��ʻ�ɫ��������ô�죿
 *���������
 *1�������������ã������������������������
 *2���������������ԣ����µ�¼��ѯ��
 */

public class AlipayConfig {
	
	//�����������������������������������Ļ�����Ϣ������������������������������
	// ���������ID����2088��ͷ��16λ��������ɵ��ַ���
	public static String partner = "2088021313669461";
	
	// �տ�֧�����˺�
	public static String seller_email = "2925508720@qq.com";
	// �̻���˽Կ
	public static String key = "i5y64hxelnrbpbxp3ifzqkgdmsj38g2f";

	//�����������������������������������Ļ�����Ϣ������������������������������
	
	//WAP������
	// �տ�֧�����˺ţ���2088��ͷ��16λ��������ɵ��ַ���
	public static String seller_id = partner;
	// �̻���˽Կ
	public static String private_key = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAOlPTnBBlFoUVr7TYsU59oGYVpFiz9iGTI4Bop1L7yF7BMlHN/Mp7Xdcsq05X0vyuBU4sC8sZHCfYvLyH+kp8Q2fvpuXWAneQxWEV2NhR/SD+Yu+OfRRKU8enQKM4KIZSw4Wwx/if/bfIfbEGlR+vsYB353vvU5Ndk01Jsrvc+IrAgMBAAECgYAPkyrCVa5ooQj1bjkev3LUTe4hgH4tjzGXHUbUx1fsXUEBis6SXg8rM7X92GGjOU3OpN0mGQmPdyRs4Xr93r3nsUv0u8+vajtq+GTnm2JqvNaQV6dmUiyCSw0tKCt54/VeCZDjOa1bzH0eMwc1kcSOm69Xc+WZG43O1klgzauxUQJBAPXAxo0uubJ1gINHpVg1/Cc3YR2mvSi7DLiT4yagpf2wIks9LnkNVIMUVsctPfkrFCWixwTG91mKjNJmkmdBNxkCQQDzCbV0ogPQls0DaM0OgrhVMUZKsPEzJhV8PlvEEd88H7+t3GF+ArogFLky+Cu0jncKDqnoCJiJ1uXFVbg1FB/jAkBqZ8WQa6LLukSikursfrNm53uNMxzD/flMEfxQRU6ZwSGYIi11DGiDONM5+kTTFevrP8ecMen3Qx4mG3NYccxBAkAcFXIfYR1ZvCNCkpinZZmRVplNxjaI94yiB76o4HvQQcbvezjUy9HgJSTla+H5AkFlKx6dDmk5/FgevnIDyCiLAkEA5Qkn7iSuSy+A/mTdkGlubebWkAVO+ZSgY7mAIPqKTBTAhZzQpnbboZoUS06aDlzw5yt9ayPbZCY1oS+wwBRz5A==";
	
	// ֧�����Ĺ�Կ�������޸ĸ�ֵ
	public static String ali_public_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB";
	

	// �����ã�����TXT��־�ļ���·��
	public static String log_path = "D:\\";

	// �ַ������ʽ Ŀǰ֧�� gbk �� utf-8
	public static String input_charset = "utf-8";
	
	// ǩ����ʽ �����޸�
	public static String sign_type = "MD5";

}
