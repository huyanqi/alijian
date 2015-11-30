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
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"></meta>

<!-- Set render engine for 360 browser -->
<meta name="renderer" content="webkit"></meta>

<!-- No Baidu Siteapp-->
<meta http-equiv="Cache-Control" content="no-siteapp" /></meta>

<link rel="icon" type="image/png" href="<%=basePath%>font/amazeui/i/favicon.png"></link>

<!-- Add to homescreen for Chrome on Android -->
<meta name="mobile-web-app-capable" content="yes"></meta>
<link rel="icon" sizes="192x192" href="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></link>

<!-- Add to homescreen for Safari on iOS -->
<meta name="apple-mobile-web-app-capable" content="yes"></meta>
<meta name="apple-mobile-web-app-status-bar-style" content="black"></meta>
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="apple-touch-icon-precomposed" href="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></link>

<!-- Tile icon for Win8 (144x144 + tile color) -->
<meta name="msapplication-TileImage" content="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></meta>
<meta name="msapplication-TileColor" content="#0e90d2"></meta>

<link rel="stylesheet" href="<%=basePath%>font/amazeui/css/amazeui.min.css"></link>
<link rel="stylesheet" href="<%=basePath%>font/amazeui/css/app.css"></link>

</head>
<body>

	<header data-am-widget="header" class="am-header am-header-default am-header-fixed">
		<div class="am-header-left am-header-nav">
			<a href="index_m.jsp" class=""> 首页
			</a>
			
			<a href="<%=basePath%>supplier_join.jsp" class="" style="font-size: 12px;" id="supplier_join">我要开店</a>
		</div>
	
		<h1 class="am-header-title">阿里健</h1>
	
		<div class="am-header-right am-header-nav">
			<a href="#user-link" class="" id="userinfo"> <font id="login_user">登录</font></a> 
			<a href="search_m.jsp" target="_blank" > <i class="am-header-icon am-icon-search"></i>
			</a>
		</div>
	</header>
	
	<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
	<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
	<script src="<%=basePath%>font/amazeui/js/amazeui.lazyload.js"></script> 
	<script>
	
	getSession();
	
	function getSession() {
		var cookie = $.AMUI.utils.cookie;
		if(cookie.get("accesstoken") != null){
			//已登录
			$("#userinfo").attr("href","<%=basePath%>supplier/supplier_controller_new.jsp");
			$("#login_user").html("个人中心");
			$("#supplier_join").hide();//"我要开店"按钮
		}else{
			//未登录
			$("#userinfo").attr("href","<%=basePath%>login.jsp");
			$("#login_user").html("未登录");
			$("#supplier_join").show();
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