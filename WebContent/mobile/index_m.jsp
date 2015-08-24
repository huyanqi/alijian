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
<style>
.title_name {
	max-height: 50px;
	display: inline-block;
	overflow: hidden;
}

.base_info {
	font-weight: bold;
}
</style>
</head>
<body>

	<jsp:include page="head_m.jsp" flush="true" />

	<div data-am-widget="list_news"
		class="am-list-news am-list-news-default">
		<!--列表标题-->
		<div class="am-list-news-hd am-cf">
			<!--带更多链接-->
			<a href="###" class="">
				<h2>1F 产品</h2> <span class="am-list-news-more am-fr">更多&raquo;</span>
			</a>
		</div>

		<div class="am-list-news-bd">
			<ul class="am-list" id="goods_ly">
				<!--缩略图在标题左边-->
			</ul>
		</div>

	</div>

	<div data-am-widget="list_news"
		class="am-list-news am-list-news-default">
		<!--列表标题-->
		<div class="am-list-news-hd am-cf">
			<!--带更多链接-->
			<a href="###" class="">
				<h2>2F 厂家</h2> <span class="am-list-news-more am-fr">更多&raquo;</span>
			</a>
		</div>

		<div class="am-list-news-bd">
			<ul class="am-list" id="supplier_ly">
				<!--缩略图在标题下方居右-->
			</ul>
		</div>

	</div>

	<div data-am-widget="list_news"
		class="am-list-news am-list-news-default">
		<!--列表标题-->
		<div class="am-list-news-hd am-cf">
			<!--带更多链接-->
			<a href="###" class="">
				<h2>3F 讲师</h2> <span class="am-list-news-more am-fr">更多
					&raquo;</span>
			</a>
		</div>

		<div class="am-list-news-bd">
			<ul class="am-list" id="lecturer_ly">
				<!--缩略图在标题右边-->
				
			</ul>
		</div>

	</div>

	<div data-am-widget="list_news"
		class="am-list-news am-list-news-default">
		<!--列表标题-->
		<div class="am-list-news-hd am-cf">
			<!--带更多链接-->
			<a href="###" class="">
				<h2>4F 热门模式</h2> <span class="am-list-news-more am-fr">更多&raquo;</span>
			</a>
		</div>

		<div class="am-list-news-bd">
			<ul class="am-list" id="business_ly">
				<!--缩略图在标题上方-->
				
			</ul>
		</div>

	</div>

	<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
	<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
	<script src="<%=basePath%>font/amazeui/js/amazeui.lazyload.js"></script>
	<script>
		$(document).ready(function() {
			getGoods("");
			getSupplier("");
			getLecturer("");
			getBusiness("");
		});
		
		function getGoods(types){
			$.AMUI.progress.start();
			$.ajax({
				type : 'POST',
				url : "<%=basePath%>getGoods",
				data : {"pageNum":1,"pageSize":8,"types":types},
				success : function(result) {
					$.AMUI.progress.done();
					$("#goods_ly").empty();
					if (result.result == "ok") {
						$.each(result.data, function(n, value) {
							var url = "goods_m.jsp?id="+value.id;
							$("#goods_ly").append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' alt='"+value.name+"' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+value.price+"元/"+value.units+"</div></div></li>");
						});
						$("img.lazy").lazyload({effect: "fadeIn"});
					}
				},
				dataType : "json"
			});
		}
		
		function getSupplier(types){
			$.AMUI.progress.start();
			$.ajax({
				type : 'POST',
				url : "<%=basePath%>getSuppliers",
				data : {"pageNum":1,"pageSize":8,"types":types},
				success : function(result) {
					$.AMUI.progress.done();
					$("#supplier_ly").empty();
					if (result.result == "ok") {
						$.each(result.data, function(n, value) {
							var url = "supplier_m.jsp?id="+value.id;
							$('#supplier_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-bottom-right'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class=''>"+value.name+"</a></h3><div class=' am-u-sm-8 am-list-main'><div class='am-list-item-text'>"+value.address+"</div></div><div class='am-list-thumb am-u-sm-4'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' alt='"+value.name+"' /></a></div></li>")
						});
						$("img.lazy").lazyload({effect: "fadeIn"});
					}
				},
				dataType : "json"
			});
		}
		
		function getLecturer(types){
			$.AMUI.progress.start();
			$.ajax({
				type : 'POST',
				url : "<%=basePath%>getLecturers",
				data : {"pageNum":1,"pageSize":8,"types":types},
				success : function(result) {
					$.AMUI.progress.done();
					$("#lecturer_ly").empty();
					if (result.result == "ok") {
						$.each(result.data, function(n, value) {
							var url = "lecturer_m.jsp?id="+value.id;
							var types = "";
							$.each(value.typeModels, function(n, value2) {
								types += value2.name+",";
							});
							if(types.length > 0)
								types = types.substring(0, types.length-1);
							$('#lecturer_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' alt='"+value.name+"' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+"擅长领域:"+types+"</div></div></li>");
						});
						$("img.lazy").lazyload({effect: "fadeIn"});
					}
				},
				dataType : "json"
			});
		}
		
		function getBusiness(types){
			$.AMUI.progress.start();
			$.ajax({
				type : 'POST',
				url : "<%=basePath%>getBusinessModels",
						data : {
							"pageNum" : 1,
							"pageSize" : 8,
							"types" : types
						},
						success : function(result) {
							$.AMUI.progress.done();
							$("#business_ly").empty();
							if (result.result == "ok") {
								$.each(result.data,function(n, value) {
									var url = "business_m.jsp?id="+value.id;
									var types = "";
									$.each(value.typeModels, function(n, value2) {
										types += value2.name+",";
									});
									if(types.length > 0)
										types = types.substring(0, types.length-1);
									$('#business_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-top'><div class='am-list-thumb am-u-sm-12'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' alt='"+value.name+"' /></a></div><div class=' am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class=''>"+value.name+"</a></h3><div class='am-list-item-text'>"+"所属分类:"+types+"</div></div></li>");
								});
								$("img.lazy").lazyload({effect: "fadeIn"});
							}
						},
						dataType : "json"
					});
		}
	</script>
</body>
</html>