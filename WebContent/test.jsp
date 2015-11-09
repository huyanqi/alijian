<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>等级测试</title>
<meta name="viewport"  content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"></meta>

</head>
<body>
<jsp:include page="mobile/head_m.jsp" flush="true"/>

<div data-am-widget="slider" class="am-slider am-slider-a5"
	data-am-slider='{&quot;directionNav&quot;:false}'>
	<ul class="am-slides">
		<li><img src="http://s.amazeui.org/media/i/demos/bing-1.jpg"></li>
		<li><img src="http://s.amazeui.org/media/i/demos/bing-2.jpg"></li>
		<li><img src="http://s.amazeui.org/media/i/demos/bing-3.jpg"></li>
		<li><img src="http://s.amazeui.org/media/i/demos/bing-4.jpg"></li>
	</ul>
</div>
</body>
</html>