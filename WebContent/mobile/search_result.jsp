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
		<li>
			<button id="keyword_et" class="am-btn am-btn-default am-btn-sm" style="width: 100%;" />
		</li>
		<li>
			<div class="am-form-group" style="margin: 0px; padding: 10px;" id="typely">
				<label style="font-size: 12px;">可选分类></label> <label class="am-checkbox-inline"> <input type="checkbox" value="0" data-am-ucheck checked onclick="unselectAll(0);">不限</input></label>
			</div>
		</li>
		<li>
			<div data-am-widget="tabs" class="am-tabs am-tabs-default" style="margin: 0;display: none;" id="list_tabs_ky">
		      <ul class="am-tabs-nav am-cf" id="list_tabs">
		          <li class="am-active" onclick="changeGoodsType(0);"><a>默认</a></li>
		          <li class="" onclick="changeGoodsType(1);"><a>销量</a></li>
		          <li class="" onclick="changeGoodsType(2);"><a>价格<i id="price_type" class="am-icon-arrows-v" style="margin-left: 5px;"></i></a></li>
		      </ul>
		  </div>
		</li>
	</ul>
</div>

<script src="<%=basePath%>font/amazeui/js/amazeui.lazyload.js"></script>
<script src="<%=basePath%>font/iscroll/iscroll.js"></script>
<script src="<%=basePath%>font/iscroll/pullToRefresh.js"></script>
<script>
initScroll();

var type;
var types = "";//用于搜索
var keyword;
var pageNum = 1;
var pageSize = 20;
$(document).ready(function(){
	type = getUrlParam("type");
	keyword = unescape(getUrlParam("keyword"));
	var key = keyword == "" ? "全部":"\""+keyword+"\"";
	$("#keyword_et").html("搜索:"+key+"的返回结果,点击更换关键词");
	$("#keyword_et").click(function(){
		location.href="search_m.jsp";
	});
	if(type == 3){
		$("#list_tabs_ky").show();
	}
	getData();
	getTypes();
});

function getData(){
	if(type == 0){
		getBusiness();
	}
	if(type == 1){
		getSupplier();
	}
	if(type == 2){
		getLecturer();
	}
	if(type == 3){
		getGoods();
	}
}

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

function removeChild(){
	$("#result_ly").children().each(function(i,n){
		if(i > 2){
		     var obj = $(n);
		     obj.remove();
		}
    });
}

//改变排序方式
var goodsType = 0;
function changeGoodsType(selecttype){
	if(selecttype == 2){
		$("#price_type").removeClass("am-icon-arrows-v").removeClass("am-icon-sort-up").removeClass("am-icon-sort-down");
		//改变价格方式
		if(goodsType == 2){
			//价格从低到高
			goodsType = 1;
			$("#price_type").addClass("am-icon-sort-down");
		}else{
			//改为价格从高到低
			goodsType = 2;
			$("#price_type").addClass("am-icon-sort-up");
		}
	}else{
		if(selecttype == 1){
			//改变为销量排序
			goodsType = 3;
		}else{
			goodsType = 0;
		}
		$("#price_type").addClass("am-icon-arrows-v");
	}
	pageNum = 1;
	getData();
}

function getGoods(){
	$.AMUI.progress.start();
	$.ajax({
		type : 'POST',
		url : "<%=basePath%>getGoods",
		data : {"pageNum":pageNum,"pageSize":pageSize,"types":types,"keyword":keyword,"type":goodsType},
		success : function(result) {
			$.AMUI.progress.done();
			if(pageNum == 1){
				removeChild();
			}
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					var url = "goods_m.jsp?id="+value.id;
					$("#result_ly").append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img src='"+value.thum+"' alt='"+value.name+"' width='88px' height='88px' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+value.price+"元/"+value.units+"</div><div class='am-list-item-text base_info' style=''>"+"销量:"+value.sales_volume+"</div></div></li>");
				});
				$("img.lazy").lazyload({effect: "fadeIn"});
				myScroll.refresh();
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
		data : {"pageNum":pageNum,"pageSize":8,"types":types,"keyword":keyword},
		success : function(result) {
			$.AMUI.progress.done();
			if(pageNum == 1){
				removeChild();
			}
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					var url = "supplier_m.jsp?id="+value.id;
					$('#result_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-bottom-right'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='' style='margin-left:10px;'>"+value.name+"</a></h3><div class=' am-u-sm-8 am-list-main'><div class='am-list-item-text'>"+value.address+"</div></div><div class='am-list-thumb am-u-sm-4'><a href='"+url+"' target='_blank' class=''> <img src='"+value.thum+"' width='88px' height='66px' alt='"+value.name+"' /></a></div></li>")
				});
				$("img.lazy").lazyload({effect: "fadeIn"});
				myScroll.refresh();
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
		data : {"pageNum":pageNum,"pageSize":8,"types":types,"keyword":keyword},
		success : function(result) {
			$.AMUI.progress.done();
			if(pageNum == 1){
				removeChild();
			}
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					var url = "lecturer_m.jsp?id="+value.id;
					var types = "";
					$.each(value.typeModels, function(n, value2) {
						types += value2.name+",";
					});
					if(types.length > 0)
						types = types.substring(0, types.length-1);
					$('#result_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img src='"+value.thum+"'  width='88px' height='102px' alt='"+value.name+"' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+"擅长领域:"+types+"</div></div></li>");
				});
				$("img.lazy").lazyload({effect: "fadeIn"});
				myScroll.refresh();
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
					"pageNum" : pageNum,
					"pageSize" : 8,
					"types" : types,
					"keyword" : keyword
				},
				success : function(result) {
					$.AMUI.progress.done();
					if(pageNum == 1){
						removeChild();
					}
					if (result.result == "ok") {
						$.each(result.data,function(n, value) {
							var url = "business_m.jsp?id="+value.id;
							var types = "";
							$.each(value.typeModels, function(n, value2) {
								types += value2.name+",";
							});
							if(types.length > 0)
								types = types.substring(0, types.length-1);
							$('#result_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-top'><div class='am-list-thumb am-u-sm-12'><a href='"+url+"' target='_blank' class=''> <img src='"+value.thum+"' width='100%' alt='"+value.name+"' /></a></div><div class=' am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='' style='margin-left:10px;'>"+value.name+"</a></h3><div class='am-list-item-text' style='padding-left:10px;'>"+"所属分类:"+types+"</div></div></li>");
						});
						$("img.lazy").lazyload({effect: "fadeIn"});
						myScroll.refresh();
					}
				},
				dataType : "json"
			});
}

function getTypes(){
	$.AMUI.progress.start();
	var path = "<%=basePath%>getTypeModelByType";
	var data = {"type":type};
	$.ajax({
		type : 'POST',
		data : data,
		url : path,
		success : function(result) {
			$.AMUI.progress.done();
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					$("#typely").append("<label class='am-checkbox-inline'><input id='checkbox"+value.id+"' type='checkbox' value="+value.id+" data-am-ucheck>"+value.name+"</input></label>");
					$("#checkbox"+value.id).click(function(){
						checkLyChecked(value.type);
					});
				});
			}
		},
		dataType : "json"
	});
}

function checkLyChecked(type){
	var uncheck = false;
	var selected = "";
	$("#typely :checkbox").each(function(){
		if($(this).val() != 0 && $(this).is(':checked') == true){
			selected += $(this).val() + ",";
			uncheck = true;
		}
	});
	$("#typely [value=0]").prop("checked",!uncheck); 
	types = selected;
	
	pageNum = 1;
	getData();
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