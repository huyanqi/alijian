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
<meta name="apple-mobile-web-app-title" content="阿里健 - 淘资源" />
<link rel="apple-touch-icon-precomposed" href="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></link>

<!-- Tile icon for Win8 (144x144 + tile color) -->
<meta name="msapplication-TileImage" content="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></meta>
<meta name="msapplication-TileColor" content="#0e90d2"></meta>

<link rel="stylesheet" href="<%=basePath%>font/amazeui/css/amazeui.min.css"></link>
<link rel="stylesheet" href="<%=basePath%>font/amazeui/css/app.css"></link>

<link rel="stylesheet" type="text/css" href="<%=basePath%>font/addtohomescreen/addtohomescreen.css">
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
</style>
</head>
<body>

	<jsp:include page="head_m.jsp" flush="true" />
	
	<div id="container" style="display: inline-block;height: 39px;margin-bottom: 0px;">
	
	<div class="am-form-group am-form-select" style="float: left;">
		<select name="select-native-3" id="type_selector" style="height: 39px;border: 0px;border: 1px solid #E6E6E6;background: transparent;">
			<option value="0">产品</option>
			<option value="1">厂家</option>
			<option value="2">讲师</option>
			<option value="3">模式</option>
		</select>
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
	

	<div data-am-widget="list_news" class="am-list-news am-list-news-default">
		<!--列表标题-->
		<div class="am-list-news-hd am-cf">
			<!--带更多链接-->
			<a href="search_result.jsp?type=0&keyword=" target="_blank" class="">
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
			<a href="search_result.jsp?type=1&keyword=" target="_blank" class="">
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

	</div>

	<div data-am-widget="list_news"
		class="am-list-news am-list-news-default">
		<!--列表标题-->
		<div class="am-list-news-hd am-cf">
			<!--带更多链接-->
			<a href="search_result.jsp?type=3&keyword=" target="_blank" class="">
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
	<script src="<%=basePath%>font/addtohomescreen/addtohomescreen.js"></script>
	<script>
	addToHomescreen();
		$(document).ready(function() {
			getGoods("");
			getSupplier("");
			getLecturer("");
			getBusiness("");
			initSearch();
			
		});
		
		var type = 0;
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
				data : {"pageNum":1,"pageSize":4,"types":types,"keyword":""},
				success : function(result) {
					$.AMUI.progress.done();
					$("#goods_ly").empty();
					if (result.result == "ok") {
						$.each(result.data, function(n, value) {
							var url = "goods_m.jsp?id="+value.id;
							$("#goods_ly").append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' width='88px' height='88px' alt='"+value.name+"' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+value.price+"元/"+value.units+"</div></div></li>");
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
									$('#business_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-top'><div class='am-list-thumb am-u-sm-12'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' alt='"+value.name+"' /></a></div><div class=' am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class=''>"+value.name+"</a></h3><div class='am-list-item-text'>"+"所属分类:"+types+"</div></div></li>");
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
</body>
</html>