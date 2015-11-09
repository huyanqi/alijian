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

<title>阿里健 - 大健康产业链</title>
<link rel="stylesheet" href="<%=basePath%>font/iscroll/pullToRefresh.css"/>
<style>
	.top_ul{
		list-style: none;
		padding-left: 0;
		margin-left: 0;
		margin: 10px;
	}
	#scroller li{
		border: 0px;
	}
	#result_ly{
		list-style: none;
		padding-left: 0;
		margin-left: 0;
	}
	#goods_name{
		font-size: 18px;
		padding: 5px;
	}
	#address{
		font-size: 14px;
		margin-left: 5px;
	}
	#types{
		font-size: 14px;
		margin-left: 5px;
	}
	#list_tabs li a{
		width: auto;
		text-align: center;
		border: 1px solid #EEEEEE;
	}
</style>  
  
</head>
<body class="am-with-topbar-fixed-top">

	<jsp:include page="head_m.jsp" flush="true"/>
	
	<div id="wrapper" class="am-list-news">
		<ul id="result_ly">
			<li>
				<div>
					<div style="float: left;">
						<img id="thum" src=""/>	
					</div>
					<div style="float: left;" id="info_ly">
						<ul class="top_ul" style="float: left;">
							<li><font id="goods_name" ></font></li>
							<li><font id="address"></font></li>
							<li><font id="types"></font></li>
							<li><span id="contact_me" style="padding-left: 5px;"></span><span id="supplier_ly" style="padding-left: 5px;"></span></li>
						</ul>
					</div>
					<div style="clear: both;"/>
					<div style="text-align: center;"><a id="more_info">更多企业信息</a></div>
					
				</div>
				
				<hr style="margin-top: 2px;margin-bottom: 2px;"></hr>
				<button id="keyword_et" class="am-btn am-btn-default am-btn-sm" style="width: 100%;color: #666666;">在售商品</button>
				<hr style="margin-top: 2px;margin-bottom: 2px;"></hr>
				<div data-am-widget="tabs" class="am-tabs am-tabs-default am-no-layout" style="margin: 0px;" id="list_tabs_ky">
				    <ul class="am-tabs-nav am-cf" id="list_tabs">
				        <li class="am-active" onclick="changeGoodsType(0);"><a>默认</a></li>
				        <li class="" onclick="changeGoodsType(1);"><a>销量</a></li>
				        <li class="" onclick="changeGoodsType(2);"><a>价格<i id="price_type" class="am-icon-arrows-v" style="margin-left: 5px;"></i></a></li>
				    </ul>
				</div>
			</li>
		</ul>
	</div>
	
<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.lazyload.js"></script>
<script src="<%=basePath%>font/iscroll/iscroll.js"></script>
<script src="<%=basePath%>font/iscroll/pullToRefresh.js"></script>
<script src="<%=basePath%>assets/javascripts/alijian.js"></script>
<script>

	//设置头像大小
	var value = $(window).width() * 0.3;
	$("#thum").width(value);
	$("#info_ly").height(value);

	initScroll();
	var id;
	$(document).ready(function(){
		id = getUrlParam("id");
		if(id == null){
			window.close();
		}else{
			getSuppliesById();
			$("#more_info").attr("href","supplier_info.jsp?id="+id);
		}
	});
	
	function getSuppliesById(){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			data : {"uid":id},
			url : "<%=basePath%>getSupplierById",
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					result = result.data;
					$("#thum").attr("src",result.thum);
					$("#goods_name").html(result.name);
					$("#address").html("地址:"+result.address);
					$("#types").append("经营领域:");
					$.each(result.typeList, function(n, value) {
						$("#types").append(value.name+"&emsp;");
					});
					/* $("#description").html(result.description);
					$("#description img").css("height","").css("width","100%"); */
					$("#supplier_ly").append(getLevel("<%=basePath%>",result.credit_supplier));
					$("#contact_me").append("<a id='contact_me_a' href='javascript:toChat("+result.id+");' class='content-btn' title='在线咨询'> <img border='0' src='<%=basePath%>font/imgs/icon_chat.png' alt='点击这里给我发消息' title='点击这里给我发消息'></a>");
					getData();
				}else{
					alert("错误的商家ID号");
					window.close();
				}
			},
			dataType : "json"
		});
	}
	
	function toChat(userid){
		window.location.href = "<%=basePath%>chat/pc/index.jsp?chat="+userid;
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
	
	var pageNum = 1;
	var pageSize = 20;
	function getData(){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			url : "<%=basePath%>getGoods",
			data : {"pageNum":pageNum,"pageSize":pageSize,"types":"","keyword":"","type":goodsType,"supplierid":id},
			success : function(result) {
				$.AMUI.progress.done();
				if(pageNum == 1){
					removeChild();
				}
				if (result.result == "ok") {
					$.each(result.data, function(n, value) {
						var url = "goods_m.jsp?id="+value.id;
						$("#result_ly").append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img src='"+value.thum+"' alt='"+value.name+"' width='88px' height='88px' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+value.price+"元/"+value.units+"</div><div class='am-list-item-text base_info' style=''>"+"成交:"+value.sales_volume+"笔</div></div></li>");
					});
					$("img.lazy").lazyload({effect: "fadeIn"});
					myScroll.refresh();
				}
			},
			dataType : "json"
		});
	}
	
	function removeChild(){
		$("#result_ly").children().each(function(i,n){
			if(i > 0){
			     var obj = $(n);
			     obj.remove();
			}
	    });
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