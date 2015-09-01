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
<title>阿里健 - 搜索结果</title>
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


<div data-am-widget="list_news" class="am-list-news am-list-news-default">
	<div class="am-list-news-bd">
		<ul class="am-list" id="result_ly">
		</ul>
	</div>
</div>

<script src="<%=basePath%>font/amazeui/js/amazeui.lazyload.js"></script>
<script>
var type;
var keyword;
var pageNum = 1;
var pageSize = 20;
$(document).ready(function(){
	type = getUrlParam("type");
	keyword = unescape(getUrlParam("keyword"));
	if(type == 0){
		getGoods();
	}
	if(type == 1){
		getSupplier();
	}
	if(type == 2){
		getLecturer();
	}
	if(type == 3){
		getBusiness();
	}
});

function getGoods(){
	$.AMUI.progress.start();
	$.ajax({
		type : 'POST',
		url : "<%=basePath%>getGoods",
		data : {"pageNum":pageNum,"pageSize":pageSize,"types":"","keyword":keyword},
		success : function(result) {
			$.AMUI.progress.done();
			$("#result_ly").empty();
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					var url = "goods_m.jsp?id="+value.id;
					$("#result_ly").append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' alt='"+value.name+"' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+value.price+"元/"+value.units+"</div></div></li>");
				});
				$("img.lazy").lazyload({effect: "fadeIn"});
			}
		},
		dataType : "json"
	});
}

function getSupplier(){
	$.AMUI.progress.start();
	$.ajax({
		type : 'POST',
		url : "<%=basePath%>getSuppliers",
		data : {"pageNum":1,"pageSize":8,"types":"","keyword":keyword},
		success : function(result) {
			$.AMUI.progress.done();
			$("#result_ly").empty();
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					var url = "supplier_m.jsp?id="+value.id;
					$('#result_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-bottom-right'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class=''>"+value.name+"</a></h3><div class=' am-u-sm-8 am-list-main'><div class='am-list-item-text'>"+value.address+"</div></div><div class='am-list-thumb am-u-sm-4'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' alt='"+value.name+"' /></a></div></li>")
				});
				$("img.lazy").lazyload({effect: "fadeIn"});
			}
		},
		dataType : "json"
	});
}

function getLecturer(){
	$.AMUI.progress.start();
	$.ajax({
		type : 'POST',
		url : "<%=basePath%>getLecturers",
		data : {"pageNum":1,"pageSize":8,"types":"","keyword":keyword},
		success : function(result) {
			$.AMUI.progress.done();
			$("#result_ly").empty();
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					var url = "lecturer_m.jsp?id="+value.id;
					var types = "";
					$.each(value.typeModels, function(n, value2) {
						types += value2.name+",";
					});
					if(types.length > 0)
						types = types.substring(0, types.length-1);
					$('#result_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' alt='"+value.name+"' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+"擅长领域:"+types+"</div></div></li>");
				});
				$("img.lazy").lazyload({effect: "fadeIn"});
			}
		},
		dataType : "json"
	});
}

function getBusiness(){
	$.AMUI.progress.start();
	$.ajax({
		type : 'POST',
		url : "<%=basePath%>getBusinessModels",
				data : {
					"pageNum" : 1,
					"pageSize" : 8,
					"types" : "",
					"keyword" : keyword
				},
				success : function(result) {
					$.AMUI.progress.done();
					$("#result_ly").empty();
					if (result.result == "ok") {
						$.each(result.data,function(n, value) {
							var url = "business_m.jsp?id="+value.id;
							var types = "";
							$.each(value.typeModels, function(n, value2) {
								types += value2.name+",";
							});
							if(types.length > 0)
								types = types.substring(0, types.length-1);
							$('#result_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-top'><div class='am-list-thumb am-u-sm-12'><a href='"+url+"' target='_blank' class=''> <img class='lazy' data-original='"+value.thum+"' alt='"+value.name+"' /></a></div><div class=' am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class=''>"+value.name+"</a></h3><div class='am-list-item-text'>"+"所属分类:"+types+"</div></div></li>");
						});
						$("img.lazy").lazyload({effect: "fadeIn"});
					}
				},
				dataType : "json"
			});
}

function getUrlParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg); //匹配目标参数
	if (r != null)
		return unescape(r[2]);
	return null; //返回参数值
}
</script>
</body>
</html>