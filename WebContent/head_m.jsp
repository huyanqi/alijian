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
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"></meta>
<title>阿里健 - 淘资源</title>

<!-- Set render engine for 360 browser -->
<meta name="renderer" content="webkit"></meta>

<!-- No Baidu Siteapp-->
<meta http-equiv="Cache-Control" content="no-siteapp" /></meta>

<link rel="icon" type="image/png" href="font/amazeui/i/favicon.png"></link>

<!-- Add to homescreen for Chrome on Android -->
<meta name="mobile-web-app-capable" content="yes"></meta>
<link rel="icon" sizes="192x192"
	href="font/amazeui/i/app-icon72x72@2x.png"></link>

<!-- Add to homescreen for Safari on iOS -->
<meta name="apple-mobile-web-app-capable" content="yes"></meta>
<meta name="apple-mobile-web-app-status-bar-style" content="black"></meta>
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="apple-touch-icon-precomposed"
	href="font/amazeui/i/app-icon72x72@2x.png"></link>

<!-- Tile icon for Win8 (144x144 + tile color) -->
<meta name="msapplication-TileImage"
	content="font/amazeui/i/app-icon72x72@2x.png"></meta>
<meta name="msapplication-TileColor" content="#0e90d2"></meta>

<link rel="stylesheet" href="font/amazeui/css/amazeui.min.css"></link>
<link rel="stylesheet" href="font/amazeui/css/app.css"></link>

</head>
<body>

	<header data-am-widget="header" class="am-header am-header-default am-header-fixed">
		<div class="am-header-left am-header-nav">
			<a href="#left-link" class=""> <i
				class="am-header-icon am-icon-home"></i>
			</a>
		</div>
	
		<h1 class="am-header-title">阿里健</h1>
	
		<div class="am-header-right am-header-nav">
			<a href="#user-link" class="" id="userinfo"> <font id="login_user">登录</font><i id="icon_user" class="am-header-icon am-icon-user"></i></a> 
			<a href="#doc-oc-demo1" data-am-offcanvas="{target: '#doc-oc-demo1', effect: 'push'}"> <i class="am-header-icon am-icon-bars"></i>
			</a>
		</div>
	</header>
	
	<!-- 侧边栏内容 -->
	<div id="doc-oc-demo1" class="am-offcanvas">
	  <div class="am-offcanvas-bar">
	    <div class="am-offcanvas-content">
	      <p>
	        我不愿让你一个人 <br/>
	        承受这世界的残忍 <br/>
	        我不愿眼泪陪你到 永恒
	      </p>
	    </div>
	  </div>
	</div>

	<script src="font/amazeui/js/jquery.min.js"></script>
	<script src="font/amazeui/js/amazeui.min.js"></script>
	<script>
	$(document).ready(function(){
		getSession();
	});
	
	function getSession() { 
		$.ajax({
			type : 'POST',
			dataType : "json",
			contentType : "application/json ; charset=utf-8",
			url : "<%=basePath%>getSession",
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					//已登录
					$("#userinfo").attr("href","supplier/supplier_controller_m.jsp");
					$("#login_user").hide();
					$("#icon_user").show();
				}else{
					//未登录
					$("#userinfo").attr("href","login.jsp");
					$("#login_user").show();
					$("#icon_user").hide();
				}
			}
		});
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