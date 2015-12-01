package com.alijian.util;

import java.io.BufferedReader;
import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;

public class NetTools {

	public String sendGetRequest(String method, HashMap<String,String> params) {  
		String result = "";
		try {
			String urlstr = "http://202.98.133.33:8080/webapi.php?act="+method+"&";  
	        for (Map.Entry<String, String> entry : params.entrySet()) {
	            urlstr += entry.getKey()+"="+entry.getValue()+"&";
	        }
	        urlstr = urlstr.substring(0,urlstr.length()-1).replace("+", "_add_").replace("\n","").replace("\r","");
	        URL url = new URL(urlstr);
	        URI uri = new URI(url.getProtocol(), url.getHost()+":"+url.getPort(), url.getPath(), url.getQuery(), null);
	        
			// 创建HttpClient实例     
	        HttpClient httpclient = new DefaultHttpClient();
	        // 创建Get方法实例     
	        HttpGet httpgets = new HttpGet(uri);
	        
	        HttpResponse response = httpclient.execute(httpgets);
			HttpEntity entity = response.getEntity();
	        if (entity != null) {
	            InputStream instreams = entity.getContent();    
	            result = new String(loadInputStream(instreams));
	            //result = convertStreamToString(instreams);
	            httpgets.abort();
	        }
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}    
        return result;
    }
	
	//HTTP请求器
	public String sendPostRequest(String url, Object xmlObj) {
		String result = "";
        HttpPost httpPost = new HttpPost(url);
        //解决XStream对出现双下划线的bug
        XStream xStreamForRequestPostData = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
        //将要提交给API的数据对象转换成XML格式数据Post给API
        String postDataXML = xStreamForRequestPostData.toXML(xmlObj);
        //得指明使用UTF-8编码，否则到API服务器XML的中文不能被成功识别
        StringEntity postEntity = new StringEntity(postDataXML, "UTF-8");
        httpPost.addHeader("Content-Type", "text/xml");
        httpPost.setEntity(postEntity);
        HttpClient httpclient = new DefaultHttpClient();
        try {
			HttpResponse response = httpclient.execute(httpPost);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, "UTF-8");
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			httpPost.abort();
		}
		
		return result;
    	/*String result = "";
    	List <NameValuePair> params = new ArrayList<NameValuePair>();
        for (Map.Entry<String, String> entry : param.entrySet()) {
        	params.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
        }
    	HttpPost httpRequst = new HttpPost(url);//创建HttpPost对象
    	try {
			httpRequst.setEntity(new UrlEncodedFormEntity(params,HTTP.UTF_8));
			HttpResponse httpResponse = new DefaultHttpClient().execute(httpRequst);
		    if(httpResponse.getStatusLine().getStatusCode() == 200) {
		    	HttpEntity httpEntity = httpResponse.getEntity();
		    	result = EntityUtils.toString(httpEntity);//取出应答字符串
		    }
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			result = e.getMessage().toString();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
			result = e.getMessage().toString();
		} catch (IOException e) {
			e.printStackTrace();
			result = e.getMessage().toString();
		}
    	return result;*/
    }
	
	private static String convertStreamToString(InputStream in) {
		StringBuffer out = new StringBuffer();
		byte[] b = new byte[1024];
		try {
			for (int n; (n = in.read(b)) != -1;) {
				out.append(new String(b, 0, n));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return out.toString();
	}
	
	public static char[] loadInputStream(InputStream in) throws IOException {
		// read text file, auto recognize bom marker or use
		// system default if markers not found.
		BufferedReader reader = null;
		CharArrayWriter writer = null;
		UnicodeReader r = new UnicodeReader(in, null);
		char[] buffer = new char[16 * 1024]; // 16k buffer
		int read;
		try {
			reader = new BufferedReader(r);
			writer = new CharArrayWriter();
			while ((read = reader.read(buffer)) != -1)
			{
				writer.write(buffer, 0, read);
			}
			writer.flush();
			return writer.toCharArray();
		} catch (IOException ex) {
			throw ex;
		} finally {
			try {
				writer.close();
				reader.close();
				r.close();
			} catch (Exception ex) {
			}
		}
	}
	
}
