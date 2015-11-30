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
<title>阿里健 - 分类列表</title>
<link rel="stylesheet" href="<%=basePath%>font/iscroll/pullToRefresh.css"/>
<style>
.title_name {
	max-height: 50px;
	display: inline-block;
	overflow: hidden;
}

.base_info {
	font-weight: bold;
}
#result_ly li a{
	width: 200px;
	height: 40px;
}
#list_tabs li a{
	width: auto;
	text-align: center;
}
</style>
</head>
<body>
<jsp:include page="head_m.jsp" flush="true" />

<div id="wrapper" class="am-list-news">
	<ul id="result_ly">
		
	</ul>
</div>

<script src="<%=basePath%>font/amazeui/js/amazeui.lazyload.js"></script>
<script src="<%=basePath%>font/iscroll/iscroll.js"></script>
<script src="<%=basePath%>font/iscroll/pullToRefresh.js"></script>
<script>
initScroll();

var mytype;
var pageNum = 1;
var pageSize = 20;
$(document).ready(function(){
	mytype = getUrlParam("mytype");
	getGoods();
});

function initScroll(){
	$("#wrapper").css("height",$(document).height());
	
	refresher.init({
		id:"wrapper",
		pullDownAction:Refresh,
		pullUpAction:Load
		});
}

function Refresh() {
	pageNum = 1;
	getData();
}

function Load() {
	pageNum++;
	getData();
}

function getGoods(){
	$.AMUI.progress.start();
	$.ajax({
		type : 'POST',
		url : "<%=basePath%>getGoodsByMyType",
		data : {"pageNum":pageNum,"pageSize":pageSize,"mytype":mytype},
		success : function(result) {
			$.AMUI.progress.done();
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					var url = "<%=basePath%>goods/"+value.id;
					$("#result_ly").append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img src='"+value.thum+"' alt='"+value.name+"' width='88px' height='88px' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+value.show_price+"元/"+value.units+"</div><div class='am-list-item-text base_info' style=''>"+"成交:"+value.sales_volume+"笔</div></div></li>");
				});
				$("img.lazy").lazyload({effect: "fadeIn"});
				myScroll.refresh();
			}else if(pageNum == 1){
				alert("没有商品");
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