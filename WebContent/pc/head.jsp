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

  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit"></meta>

  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/></meta>

  <link rel="icon" type="image/png" href="font/amazeui/i/favicon.png"></link>

  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes"></meta>
  <link rel="icon" sizes="192x192" href="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></link>

  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes"></meta>
  <meta name="apple-mobile-web-app-status-bar-style" content="black"></meta>
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></link>

  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="font/amazeui/i/app-icon72x72@2x.png"></meta>
  <meta name="msapplication-TileColor" content="#0e90d2"></meta>

  <link rel="stylesheet" href="<%=basePath%>font/amazeui/css/amazeui.min.css"></link>
  <link rel="stylesheet" href="<%=basePath%>font/amazeui/css/app.css"></link>
	
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
	      <a href="#">阿里健 - 大健康产业链</a>
	    </h1>
	
	    <div class="am-collapse am-topbar-collapse" id="collapse-head">
	
		<div class="am-topbar-right" id="username_ly" style="display: none;">
	        	<a href="#" id="username" target="_blank" style="line-height: 50px;"></a>
	        	<a href="javascript:logout();" style="line-height: 50px;color: #04aeda;font-size: 14px;">安全退出</a>
	      </div>
	
	      <div class="am-topbar-right" id="reg">
	        <button class="am-btn am-btn-secondary am-topbar-btn am-btn-sm" onclick="javascript:window.location.href='<%=basePath%>user_reg.jsp'"><span class="am-icon-pencil"></span> 采购商注册</button>
	      </div>
	
	      <div class="am-topbar-right" id="login">
	        <button class="am-btn am-btn-primary am-topbar-btn am-btn-sm" onclick="javascript:window.location.href='<%=basePath%>login.jsp'"><span class="am-icon-user"></span> 登录</button>
	      </div>

			<div class="am-topbar-right" id="supplierJoin">
				<button class="am-btn am-btn-success am-topbar-btn am-btn-sm" onclick="javascript:window.location.href='<%=basePath%>supplier_join.jsp'">
					<span class="am-icon-angellist"></span> 我要开店
				</button>
			</div>
		</div>
	  </div>
	</header>
	
	<div class="am-container" style="padding-top: 20px;padding-bottom: 20px;">
		<img src="<%=basePath%>font/logo.png" width="50" height="50" alt="logo"/>
	</div>
	
<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
<script>
	$(document).ready(function(){
		getSession();
	});
	
	function getSession() {
		
		var cookie = $.AMUI.utils.cookie;
		if(cookie.get("accesstoken") != null){
			//已登录
			$("#supplierJoin").hide();
			$("#login").hide();
			$("#reg").hide();
			$("#username_ly").show();
			var role = "";
			var cookieRole = cookie.get("role");
			if(cookieRole == "1"){
				role = "供应商";
			}else if(cookieRole == "2"){
				role = "采购商";
			}
			$("#username").attr("href","<%=basePath%>supplier/supplier_controller_new.jsp");
			$("#username").html(cookie.get("name")+""+"("+role+")");
		}else{
			//未登录
			$("#supplierJoin").show();
			$("#login").show();
			$("#reg").show();
			$("#username_ly").hide();
		}
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