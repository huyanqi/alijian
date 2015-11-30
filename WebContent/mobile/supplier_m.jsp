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
	.extra2 {
	    background-repeat: no-repeat;
	    background-position: center;
	    text-align:center;
	    height: auto;
	    width: 100%;
	    position: fixed;
	    bottom: 0px;
	    z-index: 9999;
	    padding:6px;
	    background: #F3F3F3;
	}
	
</style>  
  
</head>
<body class="am-with-topbar-fixed-top">

	<jsp:include page="head_m.jsp" flush="true"/>
	
	<div id="wrapper" class="am-list-news">
		<ul id="result_ly">
			<li>
				<div>
					<div data-am-widget="slider" class="am-slider am-slider-a2" data-am-slider='{"controlNav":"thumbnails","directionNav":false}' id="dianzhao_ly">
						<ul class="am-slides" id="dianzhao">
						</ul>
					</div>
					
					<div>
						<div style="float: left;width: auto;">
							<img id="thum" width="100" height="100" src=""/>	
						</div>
						<div style="float: left;width:auto;" id="info_ly">
							<ul class="top_ul">
								<li><img id="gold_img" src="<%=basePath%>font/imgs/gold.png" width="30" style="display: none;"/><font id="goods_name" ></font></li>
								<li><font id="address"></font></li>
								<li><font id="types"></font></li>
								<li><span id="contact_me" style="padding-left: 5px;"></span><span id="supplier_ly" style="padding-left: 5px;"></span></li>
							</ul>
						</div>
					</div>
					<div style="clear: both;"/>
					<div style="text-align: center;"><a id="more_info">更多企业信息</a></div>
					
				</div>
				
				<hr style="margin-top: 2px;margin-bottom: 2px;"></hr>
				<button class="am-btn am-btn-default am-btn-sm" style="width: 100%;color: #black;" disabled="true">在售商品</button>
				<hr style="margin-top: 2px;margin-bottom: 2px;"></hr>
				
				<div>
					<input type="text" id="keyword_et" class="am-form-field" placeholder="输入搜索的关键字" style="float: left;width: 75%;border-color: #E6E6E6;border-left: 0px;margin-bottom: 5px;margin-left: 5px;"/>
					<input type="button" class="am-btn am-btn-success" style="height: 39px;margin-left: 5px;" onclick="search();" value="搜索" />
				</div>
				
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
	
	<div class="extra2" role="presentation">
		<!-- <button type="button" style="width: 33%;float: left;" class="am-btn am-radius am-btn-default">店铺分类</button> -->
		<div class="am-dropdown am-dropdown-up" data-am-dropdown style="width: 33%;float: left;">
		<button style="width: 100%;" class="am-btn am-radius am-btn-default am-dropdown-toggle" data-am-dropdown-toggle>店铺分类 <span class="am-icon-caret-up"></span></button>
		  <ul class="am-dropdown-content" id="mytypes_ly">
		    <li class="am-dropdown-header">请选择店铺分类:</li>
		  </ul>
		</div>
		<button type="button" style="width: 33%;float: left;margin-left: 1px;" class="am-btn am-radius am-btn-danger" id="tel_submit">拨打电话</button>
		<button type="button" style="width: 33%;float: left;margin-left: 1px;" class="am-btn am-radius am-btn-primary" id="tochat_btn">在线咨询</button>
	</div>
	
	<div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
	  <div class="am-modal-dialog">
	    <div class="am-modal-hd">留言板</div>
	    <div class="am-modal-bd">
	      请在下方输入留言内容及联系方式:
	      <input type="text" class="am-modal-prompt-input">
	    </div>
	    <div class="am-modal-footer">
	      <span class="am-modal-btn" data-am-modal-cancel>取消</span>
	      <span class="am-modal-btn" data-am-modal-confirm>提交</span>
	    </div>
	  </div>
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
	//$("#thum").width(value);
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
					$("#supplier_ly").append(getLevel("<%=basePath%>",result.credit_supplier));
					$("#contact_me").append("<a id='contact_me_a' href='javascript:toChat("+result.id+");' class='content-btn' title='在线咨询'> <img border='0' height='20' src='<%=basePath%>font/imgs/icon_chat.png' alt='点击这里给我发消息' title='点击这里给我发消息'></a>");
					$("#tochat_btn").click(function(){
						toChat(result.id);
					});
					$("#tel_submit").click(function(){
						location.href="tel:"+result.mobile;
					});
					if(result.dianzhao != null && result.dianzhao != ""){
						$.each(result.dianzhao.split(","), function(n, value) {
							$("#dianzhao").append("<li><img style='max-height:150px;' src='<%=basePath%>"+value+"' ></img></li>");
						});
					}
					$('#dianzhao_ly').flexslider({
						  // options
						slideshowSpeed:3000,
						touch:false
					});
					if(result.gold == 1) $("#gold_img").show();
					$.each(result.myTypesList, function(n, value) {
						$("#mytypes_ly").append("<li><a href='<%=basePath%>mobile/showGoodsByMyTypes.jsp?mytype="+value.id+"'>"+value.name+"</a></li>");
					});
					
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
		window.location.href = "<%=basePath%>chat/chat.jsp?chat="+userid;
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
	var keyword = "";
	function getData(){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			url : "<%=basePath%>getGoods",
			data : {"pageNum":pageNum,"pageSize":pageSize,"types":"","keyword":keyword,"type":goodsType,"supplierid":id},
			success : function(result) {
				$.AMUI.progress.done();
				if(pageNum == 1){
					removeChild();
				}
				if (result.result == "ok") {
					if(pageNum == 1 && result.data.length == 0){
						alert("无数据");
					}
					$.each(result.data, function(n, value) {
						var url = "<%=basePath%>goods/"+value.id;
						$("#result_ly").append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class='am-u-sm-4 am-list-thumb'><a href='"+url+"' target='_blank' class=''> <img src='"+value.thum+"' alt='"+value.name+"' width='88px' height='88px' /></a></div><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a href='"+url+"' target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+value.show_price+"元/"+value.units+"</div><div class='am-list-item-text base_info' style=''>"+"成交:"+value.sales_volume+"笔</div></div></li>");
					});
					$("img.lazy").lazyload({effect: "fadeIn"});
				}
				myScroll.refresh();
			},
			dataType : "json"
		});
	}
	
	function search(){
		keyword = $("#keyword_et").val();
		pageNum = 1;
		getData();
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
		$("#wrapper").css("height",$(document).height() - $(".extra2").height() - 10);
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
	
	function toComment(){
		$('#my-prompt').modal({
		      relatedTarget: this,
		      onConfirm: function(e) {
		        var path = "<%=basePath%>insertComments";
				var data = '{"content":"'+e.data+'","touser":'+id+'}';
				$.ajax({
					type : 'POST',
					dataType : "json",
					contentType : "application/json ; charset=utf-8",
					data : data,
					url : path,
					success : function(result) {
						if (result.result == "ok") {
							alert("留言已发送给该商户");
						} else {
							alert(result.data);
						}
					},
					dataType : "json"
				});
		        
		      },
		      onCancel: function(e) {}
		    });
	}
	
</script>
</body>
</html>