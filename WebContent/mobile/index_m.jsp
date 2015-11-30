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
<meta name="description" content="阿里健 - 大健康产业链"></meta>
<meta name="keywords" content="阿里健 - 大健康产业链"></meta>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"></meta>
<title>阿里健 - 大健康产业链</title>

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
<meta name="apple-mobile-web-app-title" content="阿里健 - 大健康产业链" />
<link rel="apple-touch-icon-precomposed" href="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></link>

<!-- Tile icon for Win8 (144x144 + tile color) -->
<meta name="msapplication-TileImage" content="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></meta>
<meta name="msapplication-TileColor" content="#0e90d2"></meta>

<link rel="stylesheet" href="<%=basePath%>font/amazeui/css/amazeui.min.css"></link>
<link rel="stylesheet" href="<%=basePath%>font/amazeui/css/app.css"></link>

<link rel="stylesheet" type="text/css" href="<%=basePath%>font/addtohomescreen/addtohomescreen.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>font/xuanfu/index.css">
<style>
.title_name {
	max-height: 50px;
	display: inline-block;
	overflow: hidden;
}

.base_info {
	font-weight: bold;
}
#container{
	margin: 10px 10px 10px 10px;
}
a{
	size: 12px;
}
#keys_ly>a{
	padding: 10px;
	display:inline-block;
	border: 1px solid #E8E8E8;
	background: white;
}
#am-list li:first-child {
	border-top: 0px;
}
#am-list a{
	color: black;
	background: #F1F1F1;
}
#type_selector{
	appearance:none;
	-moz-appearance:none; /* Firefox */
	-webkit-appearance:none; /* Safari 和 Chrome */
}
.am-list-news-more a{
	float: left;
	margin-left: 5px;
}
</style>
</head>
<body>

	<jsp:include page="head_m.jsp" flush="true" />
	<img src="<%=basePath%>font/amazeui/i/favicon.png" width="1" height="1" style="display: none;"/>
	<div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{"controlNav":"","directionNav":false}' id="top_ly">
	  <ul class="am-slides">
		  <li>
	        	<img src="<%=basePath%>font/ad/top2.jpg"/>
	      </li>
	      <li>
	        	<img src="<%=basePath%>font/ad/top1.jpg"/>
	      </li>
	      <li>
	        	<img src="<%=basePath%>font/ad/top0.jpg"/>
	      </li>
	  </ul>
	</div>
	<div id="container" style="display: inline-block;height: 39px;margin-bottom: 0px;">
	<div class="am-form-group am-form-select" style="float: left;border: 0px;border: 1px solid #E6E6E6;height: 39px;line-height: 39px;">
		<select name="select-native-3" id="type_selector" style="border: 0px;background: transparent;">
			<option value="3">产品</option>
			<option value="1">商家</option>
			<option value="2">讲师</option>
			<option value="0">模式</option>
		</select>
		<span class="am-icon-caret-down"></span>
	</div>
	
	<input type="text" id="keyword_et" class="am-form-field" placeholder="输入搜索的关键字" style="float: left;width: 60%;border-color: #E6E6E6;border-left: 0px;"/>
	
	<button type="button" onclick="search('');" class="am-btn am-btn-default" style="float: left;height: 39px;background: transparent;color: black;border: 0px;">搜索</button>
	
	</div>
	
	<div id="search_ly" style="width:100%;display: inline-block;background: #F1F1F1;border: 1px solid #f6f6f6;display: none;">

		<div style="padding: 10px;">
			<div>
				<a style="color: #8F8F8F;float: left;">大家都在搜</a>
				
				<div style="float: right;"><i class="am-icon-refresh"></i><a style="color: #8F8F8F;margin-left: 5px;">换一组</a></div>
			</div>
			<div style="clear: both;"></div>
			<div id="keys_ly" style="margin-top: 10px;">
				
			</div>
			<a style="color: #8F8F8F;margin-top: 10px;display: inline-block;">搜索历史</a>
		</div>
		
		<div data-am-widget="list_news" class="am-list-news am-list-news-default" style="display: inline-block;width: 100%;padding: 10px;margin: 0px;">
			<div class="am-list-news-bd">
				<ul id="am-list" class="am-list">
				</ul>
			</div>
		
		</div>
		<a onclick="javascript:searchHide();" style="text-align: right;width: 100%;display: inline-block;padding: 10px;">隐藏</a>
	</div>
	
	<div style="padding: 10px;">
		<a target="_blank" href="<%=basePath%>howtouse.jsp">如何使用阿里健</a>
	</div>

	<div data-am-widget="list_news" class="am-list-news am-list-news-default">
		<!--列表标题-->
		<div class="am-list-news-hd am-cf">
			<!--带更多链接-->
			<a href="search_result.jsp?type=3&keyword="><h2 style="color: #0e90d2">1F 产品</h2></a> 
			<span class="am-list-news-more am-fr">
			<a href="search_result.jsp?type=1&keyword=">商家</a>
			<a href="search_result.jsp?type=2&keyword=">讲师</a>
			<a href="search_result.jsp?type=0&keyword=">模式</a>
			<a href="buy_m.jsp">供求</a>
			</span>
		</div>

		<div class="am-list-news-bd">
			<ul class="am-list" id="goods_ly">
				<!--缩略图在标题左边-->
			</ul>
		</div>
		
		<div style="text-align: center;">
			<a href="search_result.jsp?type=3&keyword=">查看更多产品</a>
		</div>

	</div>

	<div data-am-widget="list_news"
		class="am-list-news am-list-news-default">
		<!--列表标题-->
		<div class="am-list-news-hd am-cf">
			<!--带更多链接-->
			<a href="search_result.jsp?type=1&keyword=" target="_blank" class="">
				<h2>2F 商家</h2> <span class="am-list-news-more am-fr">更多&raquo;</span>
			</a>
		</div>

		<div class="am-list-news-bd">
			<ul class="am-list" id="supplier_ly">
				<!--缩略图在标题下方居右-->
			</ul>
		</div>
		
		<div style="text-align: center;">
			<a href="search_result.jsp?type=1&keyword=">查看更多商家</a>
		</div>

	</div>

	<div data-am-widget="list_news"
		class="am-list-news am-list-news-default">
		<!--列表标题-->
		<div class="am-list-news-hd am-cf">
			<!--带更多链接-->
			<a href="search_result.jsp?type=2&keyword=" target="_blank" class="">
				<h2>3F 讲师</h2> <span class="am-list-news-more am-fr">更多
					&raquo;</span>
			</a>
		</div>

		<div class="am-list-news-bd">
			<ul class="am-list" id="lecturer_ly">
				<!--缩略图在标题右边-->
				
			</ul>
		</div>
		
		<div style="text-align: center;">
			<a href="search_result.jsp?type=2&keyword=">查看更多讲师</a>
		</div>

	</div>

	<div data-am-widget="list_news"
		class="am-list-news am-list-news-default">
		<!--列表标题-->
		<div class="am-list-news-hd am-cf">
			<!--带更多链接-->
			<a href="search_result.jsp?type=0&keyword=" target="_blank" class="">
				<h2>4F 热门模式</h2> <span class="am-list-news-more am-fr">更多&raquo;</span>
			</a>
		</div>

		<div class="am-list-news-bd">
			<ul class="am-list" id="business_ly">
				<!--缩略图在标题上方-->
				
			</ul>
		</div>
		
		<div style="text-align: center;">
			<a href="search_result.jsp?type=0&keyword=">查看更多模式</a>
		</div>

	</div>
	
	<!-- 右侧悬浮窗 -->
	<div class="OnlineService_Bg">
		<div class="OnlineService_Box">
			<a target="_blank" href="buy_m.jsp"><button class="am-btn am-btn-primary am-btn-xs">找求购</button></a>
			<a target="_blank" href="search_result.jsp?type=3&keyword="><button class="am-btn am-btn-secondary am-btn-xs">找产品</button></a>
			<a target="_blank" href="search_result.jsp?type=1&keyword="><button class="am-btn am-btn-secondary am-btn-xs">找商家</button></a>
			<a target="_blank" href="search_result.jsp?type=2&keyword="><button class="am-btn am-btn-secondary am-btn-xs">找讲师</button></a>
			<a target="_blank" href="search_result.jsp?type=0&keyword="><button class="am-btn am-btn-secondary am-btn-xs">找模式</button></a>
			<div data-am-widget="gotop">
				<a href="#top"><button class="am-btn am-btn-default am-btn-xs">回顶部</button></a>
			</div>
			<!-- <ul class="OnlineService_QQBox"><li><a target="_blank" rel="nofollow" href="http://sc.chinaz.com/">站长素材</a></li></ul>
			<div class="OnlineService_Phone"><a href="http://sc.chinaz.com/" target="_blank">在线咨询</a></div>
			<div class="OnlineService_Sign" target="_blank" onclick="http://sc.chinaz.com/">立即试用</div>
			<div class="OnlineService_Top"><a href="#">返回顶部</a></div> -->
		</div>
	</div>
	
	<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
	<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
	<script src="<%=basePath%>font/amazeui/js/amazeui.lazyload.js"></script>
	<script src="<%=basePath%>font/addtohomescreen/addtohomescreen.js"></script>
	<script src="<%=basePath%>font/amazeui/js/jweixin-1.0.0.js"></script>
		
	<script>
		addToHomescreen();
		$(document).ready(function() {
			getGoods("");
			getSupplier("");
			getLecturer("");
			getBusiness("");
			initSearch();
			$('#top_ly').flexslider({
				  // options
				slideshowSpeed:1000,
				touch:false
			});
		});
		
		var type = 3;
		function initSearch(){
			$("#keyword_et").on("click", function() {
				$("#search_ly").show();
			});
			
			$("#keyword_et").on("blur", function() {
				
			});
			
			$('#type_selector').change(function() {
				type = $("#type_selector").val();
			});
			
			getHistory();
			getKeywords();
		}
		
		function searchHide(){
			$("#search_ly").hide();
		}
		
		function getGoods(types){
			$.AMUI.progress.start();
			$.ajax({
				type : 'POST',
				url : "<%=basePath%>getGoods",
				data : {"pageNum":1,"pageSize":4,"types":types,"keyword":"","type":0,"supplierid":0},
				success : function(result) {
					$.AMUI.progress.done();
					$("#goods_ly").empty();
					if (result.result == "ok") {
						$.each(result.data, function(n, value) {
							var url = "<%=basePath%>goods/"+value.id;
							$("#goods_ly").append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' width='88px' height='88px' alt='"+value.name+"' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+value.show_price+"元/"+value.units+"<a style='float:right;'>已成交"+value.sales_volume+"笔</a></div></div></li>");
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
				data : {"pageNum":1,"pageSize":4,"types":types,"keyword":""},
				success : function(result) {
					$.AMUI.progress.done();
					$("#supplier_ly").empty();
					if (result.result == "ok") {
						$.each(result.data, function(n, value) {
							var url = "supplier_m.jsp?id="+value.id;
							$('#supplier_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-bottom-right'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class=''>"+value.name+"</a></h3><div class=' am-u-sm-8 am-list-main'><div class='am-list-item-text'>"+value.address+"</div></div><div class='am-list-thumb am-u-sm-4'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' width='88px' height='66px' alt='"+value.name+"' /></a></div></li>")
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
				data : {"pageNum":1,"pageSize":4,"types":types,"keyword":""},
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
							$('#lecturer_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' width='88px' height='102px' alt='"+value.name+"' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+"擅长领域:"+types+"</div></div></li>");
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
							"pageSize" : 4,
							"types" : types,
							"keyword" : ""
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
									$('#business_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' width='88px' height='102px' alt='"+value.name+"' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+"领域:"+types+"</div></div></li>");
								});
								$("img.lazy").lazyload({effect: "fadeIn"});
							}
						},
						dataType : "json"
					});
		}
		
		function searchOnClick(){
			$("#search_ly").show();
		}
		
		function searchOnBlur(){
			$("#search_ly").hide();
		}
		
		function getHistory(){
			var history = $.AMUI.utils.cookie.get("history");
			if(history == null) return;
			var histories = history.split(",");
			$('#am-list').empty();
			for(var i=histories.length-1;i>-1;i--){
				var h = histories[i];
				if(h == null || h == "") continue;
				$('#am-list').append('<li class="am-g am-list-item-dated" onclick=search("'+h+'");><a class="am-list-item-hd">'+h+'</a></li>');
			}
		}
		
		/*
		*搜索功能
		*/
		function search(keyword){
			if(keyword == ""){
				keyword = $("#keyword_et").val();
			}
			if(keyword == null || keyword == "") return;
			var history = $.AMUI.utils.cookie.get("history");
			if(history == null){
				history = "";
			}else{
			}
			history += keyword+",";
			var tempArray = [];
			var hissp = history.split(",").length;
			for(var i=0;i<hissp;i++){
				var his = history.split(",")[i];
				if(his == null || his == "" || tempArray.indexOf(his) != -1){
					continue;
				}
				tempArray.push(his);
			}
			if(tempArray.length > 4){
				tempArray.shift();
			}
			history = "";
			for(var i=0;i<tempArray.length;i++){
				history += tempArray[i]+",";
			}
			if(history.length > 0) history.substring(0,history.length-1);
			$.AMUI.utils.cookie.set("history", history, Infinity);
			getHistory();
			searchData(keyword);
		}
		
		var pageNum = 1;
		function getKeywords(){
			$.AMUI.progress.start();
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : "<%=basePath%>getKeyWords",
				data : {"pageNum":pageNum},
				success : function(result) {
					$.AMUI.progress.done();
					$("#keys_ly").empty();
					if(result.result == "ok"){
						$.each(result.data, function(n, value) {
							$("#keys_ly").append('<a href=javascript:search("'+value.name+'");>'+value.name+'</a>');
						});
					}else{
						//没有数据
						if(pageNum != 1){
							pageNum = 1;
							getKeywords();
						}
					}
				}
			});
		}
		
		function searchData(keywords){
			window.open("search_result.jsp?type="+type+"&keyword="+escape(keywords));
		}
	</script>
	
	<jsp:include page="footer_m.jsp" flush="true" />
</body>
</html>