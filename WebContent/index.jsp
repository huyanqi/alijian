<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
  <meta name="description" content=""></meta>
  <meta name="keywords" content=""></meta>
  <meta name="viewport"  content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"></meta>
  <title>阿里健 - 淘资源</title>

  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit"></meta>

  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/></meta>

  <link rel="icon" type="image/png" href="font/amazeui/i/favicon.png"></link>

  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes"></meta>
  <link rel="icon" sizes="192x192" href="font/amazeui/i/app-icon72x72@2x.png"></link>

  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes"></meta>
  <meta name="apple-mobile-web-app-status-bar-style" content="black"></meta>
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="font/amazeui/i/app-icon72x72@2x.png"></link>

  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="font/amazeui/i/app-icon72x72@2x.png"></meta>
  <meta name="msapplication-TileColor" content="#0e90d2"></meta>

  <link rel="stylesheet" href="font/amazeui/css/amazeui.min.css"></link>
	  <link rel="stylesheet" href="font/amazeui/css/app.css"></link>
	
	<style>
	
	.my_at {
		border-bottom: 4px solid #0E90D2;
	}
	
	.my_at font {
		color: #0E90D2;
		font-size: 20px;
	}
	
	.my_at font a {
		font-size: 25px;
	}
	
	.my_at .am-topbar-right {
		margin-top: 5px;
	}
	
	.item{
		margin-left:10px;
		margin-top:10px;
		float: left;
		width: 220px;
		height: 220px;
		background: white;
		overflow: hidden;
		border: solid 1px #04aeda;
	}
	
	.item .lecturer_img{
		width: 180px;
		height: 220px;
		float: left;
	}
	.item .supplier_name{
		width: 220px;
		height: 40px;
		display: block;
		text-align: center;
		line-height: 40px;
	}
	
	.item .supplier_img{
		width: 220px;
		height: 180px;
	}
	
	.footer p {
	    color: #7f8c8d;
	    margin: 0;
	    padding: 15px 0;
	    text-align: center;
	    margin-top: 30px;
	}
</style>
	
</head>
<body class="am-with-topbar-fixed-top">
	<header class="am-topbar am-topbar-fixed-top">
	  <div class="am-container">
	    <h1 class="am-topbar-brand">
	      <a href="#">阿里健 - 淘资源</a>
	    </h1>
	
	    <div class="am-collapse am-topbar-collapse" id="collapse-head">
	
		<div class="am-topbar-right" id="username_ly">
	        	<a href="#" id="username" target="_blank" style="line-height: 50px;"></a>
	        	<a href="javascript:logout();" style="line-height: 50px;color: #04aeda;font-size: 14px;">安全退出</a>
	      </div>
	
	      <div class="am-topbar-right" id="reg">
	        <button class="am-btn am-btn-secondary am-topbar-btn am-btn-sm" onclick="javascript:window.location.href='user_reg.jsp'"><span class="am-icon-pencil"></span> 采购商注册</button>
	      </div>
	
	      <div class="am-topbar-right" id="login">
	        <button class="am-btn am-btn-primary am-topbar-btn am-btn-sm" onclick="javascript:window.location.href='login.jsp'"><span class="am-icon-user"></span> 登录</button>
	      </div>

			<div class="am-topbar-right" id="supplierJoin">
				<button class="am-btn am-btn-success am-topbar-btn am-btn-sm" onclick="javascript:window.location.href='supplier_join.jsp'">
					<span class="am-icon-angellist"></span> 供货商入驻
				</button>
			</div>
		</div>
	  </div>
	</header>
	
	<div class="am-container" style="padding-top: 20px;padding-bottom: 20px;">
		<img src="font/logo.png" alt="logo"/>
	</div>
	
	<div class="am-container" style="background: #DDDDDD;height: 1px;"/>
	
	<!-- 搜索框 -->
	<div class="am_container" style="margin-top: 15px;">
		<div class="am-g">
			<div class="am-u-lg-6" style="padding:  0;">
				<div class="am-input-group" style="width: 500px;">
					<span class="am-input-group-btn">
						<button class="am-btn am-btn-default" type="button">
							<span class="am-icon-search"></span>
						</button>
					</span> 
					<input type="text" class="am-form-field" placeholder="输入关键字搜索" />
					<span class="am-input-group-btn">
						<button class="am-btn am-btn-default" type="button">搜索</button>
					</span>
				</div>
			</div>
			<a target="_blank"
				style="margin-left: 100px;"
				href="tencent://message/?uin=375377612&Site=阿里健&Menu=yes"
				class="content-btn" title="在线咨询"> <img border="0"
				src="http://wpa.qq.com/pa?p=2:375377612:42" alt="点击这里给我发消息"
				title="点击这里给我发消息"></a>
			<a target="_blank"
				style="margin-left: 10px;"
				href="tencent://message/?uin=375377612&Site=阿里健&Menu=yes"
				class="content-btn" title="在线咨询"> <img border="0"
				src="http://wpa.qq.com/pa?p=2:375377612:42" alt="点击这里给我发消息"
				title="点击这里给我发消息"></a>
		</div>
		
		<!-- 多选框 -->
		<div class="am-form-group" style="margin-top: 20px;">
		  <label>产品 ></label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck checked>不限</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>养老</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>保健品</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>包装</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>材料</input>
		  </label>
		</div>
		
		<div class="am-form-group" style="margin-top: 10px;">
		  <label>厂家 ></label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck checked>不限</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>养老</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>保健品</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>包装</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>材料</input>
		  </label>
		</div>
		
		<div class="am-form-group" style="margin-top: 10px;">
		  <label>讲师 ></label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck checked>不限</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>养老</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>保健品</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>医院</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>药店</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>美容</input>
		  </label>
		</div>
		
		<div class="am-form-group" style="margin-top: 10px;">
		  <label>模式 ></label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck checked>不限</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>养老</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>保健品</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>医院</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>药店</input>
		  </label>
		  <label class="am-checkbox-inline">
		    <input type="checkbox"  value="" data-am-ucheck>美容</input>
		  </label>
		</div>
		
		<!-- 各种列表 -->
		<div class="my_at">
			<font>1F <a>产品</a></font>
			<div class="am-topbar-right">
		        <a class="am-badge am-badge-primary am-radius">更多</a>
		    </div>
		</div>
		<div id="container" style="width:100%;  margin-left: auto;margin-right: auto;" align="center">
		    <div class="item">
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    	<a class="supplier_name">哈药集团</a>
		    </div>
		    <div class="item"></div>
		    <div class="item"></div>
		    <div class="item"></div>
		    <div class="item">
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    	<a class="supplier_name">哈药集团</a>
		    </div>
		    <div class="item"></div>
		    <div class="item"></div>
		    <div class="item"></div>
		</div>		
		
		<div style="clear:both;"></div>
		
		<div class="my_at">
			<font>2F <a>厂家</a></font>
			<div class="am-topbar-right">
		        <a class="am-badge am-badge-primary am-radius">更多</a>
		    </div>
		</div>
		<div id="container" style="width:100%;  margin-left: auto;margin-right: auto;" align="center">
		    <div class="item">
		    	<a class="supplier_name">哈药集团</a>
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    </div>
		    <div class="item">
		    	<a class="supplier_name">哈药集团</a>
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    </div>
		    <div class="item">
		    	<a class="supplier_name">哈药集团</a>
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    </div>
		    <div class="item">
		    	<a class="supplier_name">哈药集团</a>
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    </div>
		    <div class="item">
		    	<a class="supplier_name">哈药集团</a>
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    </div>
		    <div class="item">
		    	<a class="supplier_name">哈药集团</a>
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    </div>
		    <div class="item">
		    	<a class="supplier_name">哈药集团</a>
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    </div>
		    <div class="item">
		    	<a class="supplier_name">哈药集团</a>
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    </div>
		</div>		
		
		<div style="clear:both;"></div>
		
		<div class="my_at">
			<font>3F <a>讲师</a></font>
			<div class="am-topbar-right">
		        <a class="am-badge am-badge-primary am-radius">更多</a>
		    </div>
		</div>
		<div id="container" style="width:100%;  margin-left: auto;margin-right: auto;" align="center">
		    <div class="item">
		    	<img class="lecturer_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    	<font>张<br/>靖<br/>豪</font>
		    </div>
		    <div class="item"></div>
		    <div class="item"></div>
		    <div class="item"></div>
		    <div class="item">
		    	<img class="lecturer_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    	<font>张<br/>靖<br/>豪</font>
		    </div>
		    <div class="item"></div>
		    <div class="item"></div>
		    <div class="item"></div>
		</div>		
		
		<div style="clear:both;"></div>
		
		<div class="my_at">
			<font>4F <a>模式</a></font>
			<div class="am-topbar-right">
		        <a class="am-badge am-badge-primary am-radius">更多</a>
		    </div>
		</div>
		
		<div id="container" style="width:100%;  margin-left: auto;margin-right: auto;" align="center">
		    <div class="item">
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    	<a class="supplier_name">哈药集团</a>
		    </div>
		    <div class="item"></div>
		    <div class="item"></div>
		    <div class="item"></div>
		    <div class="item">
		    	<img class="supplier_img" src="/ALiJian/images/2015_7_30_1049014064.jpg" alt="" />
		    	<a class="supplier_name">哈药集团</a>
		    </div>
		    <div class="item"></div>
		    <div class="item"></div>
		    <div class="item"></div>
		</div>		
		
		<div style="clear:both;"></div>
		
	</div>
	
	<footer class="footer">
	  <p>© 2015 <a href="#" target="_blank">阿里健 - 淘资源.</a> Powered by Frankie.</p>
	</footer>
	
<script src="font/amazeui/js/jquery.min.js"></script>
<script src="font/amazeui/js/amazeui.min.js"></script>
<script>
var uid;
	$(document).ready(function(){
		uid = getCookie("uid");
		if(uid != null){
			//已登录
			$("#supplierJoin").hide();
			$("#login").hide();
			$("#reg").hide();
			$("#username_ly").show();
			var role = "";
			var cookieRole = getCookie("role");
			if(cookieRole == "1"){
				role = "供应商";
				$("#username").attr("href","supplier/supplier_controller.jsp");
			}else if(cookieRole == "2"){
				role = "采购商";
				$("#username").attr("href","user_controller.jsp");
			}
			$("#username").html(getCookie("username")+"("+role+")");
		}else{
			$("#supplierJoin").show();
			$("#login").show();
			$("#reg").show();
			$("#username_ly").hide();
		}
	});
	
	function getCookie(name) { 
	    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	 
	    if(arr=document.cookie.match(reg))
	 
	        return unescape(arr[2]); 
	    else 
	        return null; 
	}
	
	function logout(){
		$.ajax({
			type : 'POST',
			dataType : "json",
			contentType : "application/json ; charset=utf-8",
			url : "<%=basePath%>logout",
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					$("#supplierJoin").show();
					$("#login").show();
					$("#reg").show();
					$("#username_ly").hide();
				}
			},
			dataType : "json"
		});
	}
</script>
</body>
</html>