<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@include file="/page/tag.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>阿里健 - 订单确认</title>
<style type="text/css">
	.goods_info {
		border: 1px solid #E5E5E5;
	}
	.goods_info tr td,#order_info tr td{
		border-bottom: 1px solid #E5E5E5;
		padding: 5px;
	}
	#pifa_ul,.prices_ul{
		list-style: none;
		padding: 0;
	}
	
	#order_info {
	    -moz-border-radius: 5px;      /* Gecko browsers */
	    -webkit-border-radius: 5px;   /* Webkit browsers */
	    border-radius:5px;            /* W3C syntax */
	}
	
	.prices_ul{
		padding: 5px;
	}
	
	.prices_ul font{
		color: white;
		font-size: 12px;
	}
	
	#pifa_ul>li{
		float: left;
		margin-left: 3px;
	}
</style>
<link rel="stylesheet" href="<%=basePath%>font/amazeui/css/amazeui.min.css"></link>
<link rel="stylesheet" href="<%=basePath%>font/amazeui/css/app.css"></link>
<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
<script src="<%=basePath%>assets/javascripts/alijian.js"></script>
</head>
<body>

<div id="header_ly"></div>

<div class="am-container" >

	<h3 style="text-align: center;">阿里健订单确认</h3>
	
	<c:forEach var="goodsvar" items="${goods}">
		<table style="width: 100%;margin-top: 10px;" id="goods_info${goodsvar.id }" class="goods_info" data-id=${goodsvar.id }>
			<tr><td><img alt="" src="${goodsvar.thum }" width="120px" height="120px" /></td><td style="height: 80px;"><font>${goodsvar.name }</font></td></tr>
			<tr><td class="table_th" style="height: 55px;">单价:</td><td><a style="font-size: 12px;color: #027cff;margin-right: 5px;">￥</a><font style="font-size:30px;line-height:50px;color:#027cff;" id="price${goodsvar.id }">${goodsvar.price }</font><font style="font-size: 12px;color:black;margin-left:5px;">/ ${goodsvar.units }</font></td></tr>
			
			<c:if test="${goodsvar.priceModel != null}">
				<input type="hidden" id="startC${goodsvar.id }" value="${goodsvar.priceModel.startCount }"/>
				<input type="hidden" id="endC${goodsvar.id }" value="${goodsvar.priceModel.endCount }"/>
				<input type="hidden" id="priceC${goodsvar.id }" value="${goodsvar.priceModel.price }"/>
				<tr id="pifa_ly${goodsvar.id}"><td class="table_th" style="height: 55px;"><font>批发价:</font></td>
					<td id="pifa" style="padding-top: 20px;">
						<ul id="pifa_ul">
							<c:forEach var="priceitem" items="${goodsvar.priceModel.price.split(',')}" varStatus="status">
								<c:set value="${goodsvar.priceModel.startCount.split(',')[status.index]}" var="startC" />   
								<c:set value="${goodsvar.priceModel.endCount.split(',')[status.index]}" var="endC" />
								<c:set value="${goodsvar.priceModel.price.split(',')[status.index]}" var="price" />   
								
								<c:set value="${startC } - ${endC }" var="showcontent" />
								<c:if test='${startC == "" || startC == null}'>
									<c:set value="≤${endC }" var="showcontent" />
								</c:if>
								<c:if test='${endC == "" || endC == null}'>
									<c:set value="≥${startC }" var="showcontent" />
								</c:if>
								<li><ul class='prices_ul' style='background: #FFA155;'><li><div><font>${showcontent}</font></div></li><li><font>￥${price }</font></li></ul></li>
							</c:forEach>
						</ul>
					</td>
				</tr>
		　　</c:if>
			
			<tr><td class="table_th" style="height: 55px;">运费:</td><td><a style="font-size: 12px;">${goodsvar.freight}</a></td></tr>
			<c:if test="${goodsvar.goods_type != null && goodsvar.goods_type != '' }">
				<tr><td class="table_th" style="height: 55px;">选择种类:</td><td>
					<ul class="am-nav am-nav-pills typely" id="typely${goodsvar.id}" data-id=${goodsvar.id }>
						<c:forEach var="typeitem" items="${goodsvar.goods_type.split(',')}" varStatus="status">
							<li id="type${goodsvar.id }_${status.index}"><a href="javascript:typeselect(${goodsvar.id },${status.index})">${typeitem }</a></li>
						</c:forEach>
					</ul>
				</td></tr>
			</c:if>
			<tr><td class="table_th" style="height: 55px;">购买数量:</td><td><span><a href="javascript:redu1(${goodsvar.id })" style="padding: 5px;">-</a></span><input id="num${goodsvar.id}" type="text" value="1" style="width:50px; text-align:center;ime-mode:disabled" onkeypress="return event.keyCode>=48&&event.keyCode<=57" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/><span><a href="javascript:add1(${goodsvar.id })" style="padding: 5px;">+</a></span></td></tr>
			<tr><td class="table_th" style="height: 55px;">商品总价:</td><td><font size="3" style="color:#CD0204;" id="goodsprice${goodsvar.id }" class="goods_price" >${goodsvar.price }</font>元</td></tr>
		</table>
	</c:forEach>
	
	<h3 style="color: red;">收货人信息</h3>
	<table style="width: 100%;margin-top: 10px;background: #EEEEEE;" id="order_info">
		<tr><td class="table_th" style="height: 55px;">收货地址:</td><td><input id="buyeraddress" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
		<tr><td class="table_th" style="height: 55px;">联系人:</td><td><input id="buyername" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
		<tr><td class="table_th" style="height: 55px;">联系人手机号:</td><td><input id="buyermobile" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
		<tr><td class="table_th" style="height: 55px;">备注:</td><td><input id="remark" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
		<tr>
		<td class="table_th" style="height: 55px;">付款方式:</td><td>
			<ul class="am-nav am-nav-pills">
				<li class="am-active" id="method0"><a href="javascript:selectPay(0)">支付宝支付</a></li>
				<li class="am-active" id="method1"><a href="javascript:selectPay(1)">微信支付</a></li>
			</ul>
		</td></tr>
		<tr><td colspan="2" align="right" style="height: 55px;border-bottom: 0px;"><a style="color: black;margin-right: 20px;">订单总额:<font size="8" style="color:#CD0204;" id="allprice"></font>元</a><button type="button" id="submitbtn" class="am-btn am-radius am-btn-primary" onclick="formsubmit();">确认购买</button></td></tr>
	</table>
</div>

<script type="text/javascript">
	
	var isMobile = 0;
	var paymethod = 0;
	
	if(!IsPC()){
		isMobile = 1;
		$("#header_ly").load("<%=basePath%>page/mobile/head_m.jsp");
	}else{
		isMobile = 0;
		$("#header_ly").load("<%=basePath%>page/pc/head.jsp");
	}
	
	$(document).ready(function(){
		getUserSession();
	});
	
	function formsubmit(){
		//遍历商品
		var saveDataAry=[];  
		var address = $("#buyeraddress").val();
		if(address == ""){
			alert("请填写收货地址");
			return;
		}
		var name = $("#buyername").val();
		if(name == ""){
			alert("请填写收货人名字");
			return;
		}
		var mobile = $("#buyermobile").val();
		if(mobile == ""){
			alert("请填写收货人手机号");
			return;
		}
		var remark = $("#remark").val();
		
		$(".goods_info").each(function(i,n){
			var id = $(this).data("id");
			//获取购买数量
			var num = $("#num"+id).val();
			var type = "";
			if(map.get(id) != null){
				//获取选择的种类
				$("#typely"+id+" .am-active").each(function(i,n){
					type = $(this).find("a").html();
			    });
			}
			var data={"goods_id":id,"goods_type":type,"amout":num,"address":address,"name":name,"mobile":mobile,"remark":remark};  
	        saveDataAry.push(data);
		});

		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			dataType : "json",
			contentType : "application/json ; charset=utf-8",
			data : JSON.stringify(saveDataAry),
			url : "<%=basePath%>create_order?pay_method="+paymethod,
			success : function(result) {
				$.AMUI.progress.done();
				if(result.result == "ok"){
					$("body").append(result.data);
				}else{
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
	
	function getUserSession() {
		var cookie = $.AMUI.utils.cookie;
		if(cookie.get("accesstoken") != null){
			//已登录，获取产品详情
			init();
			autoSelect();
			refreshAllprice();
			selectPay(0);
		}else{
			//未登录
			alert("请先登录后再购买");
			window.location.href="<%=basePath%>login.jsp";
		}
	}
	
	function selectPay(method){
		if(method == 0){
			$("#method1").removeClass("am-active");
		}else{
			$("#method0").removeClass("am-active");
		}
		$("#method"+method).addClass("am-active");
		paymethod = method;
	}
	
	function init(){
		$(".goods_info").each(function(i,n){
			var id = $(this).data("id");
			$('#num'+id).bind('input propertychange', function() {  
				refreshTotalPrice(id);
			});
		});
	}
	
	//如果商品有可选类型，自动选择第一个
	function autoSelect(){
		$(".typely").each(function(i,n){
			typeselect($(this).data("id"),0);
	    });
	}
	
	var map = new HashMap();
	function typeselect(goods,index){
		map.put(goods,index);
		$("#typely"+goods).children().each(function(i,n){
			$(this).removeClass("am-active");
	    });
		$("#type"+goods+"_"+index).addClass("am-active");
	}
	
	function add1(goodsid){
		var oldValue=parseInt($("#num"+goodsid).val()); //取出现在的值，并使用parseInt转为int类型数据
		oldValue++   //自加1
		$("#num"+goodsid).val(oldValue)  //将增加后的值付给控件
		refreshTotalPrice(goodsid);
	}
	
	function redu1(goodsid){
		var oldValue=parseInt($("#num"+goodsid).val()); //取出现在的值，并使用parseInt转为int类型数据
		if(oldValue > 1){
			oldValue--   //自减1
		}
		$("#num"+goodsid).val(oldValue)  //将增加后的值付给控件
		refreshTotalPrice(goodsid);
	}
	
	//刷新商品价格
	function refreshTotalPrice(goodsid){
		var amount = $("#num"+goodsid).val();
		var startCount = $("#startC"+goodsid).val();
		var endCount = $("#endC"+goodsid).val();
		var prices = $("#priceC"+goodsid).val();
		var totalprice = -1;
		if(prices != null){
			startCount = startCount.split(",");
			endCount = endCount.split(",");
			prices = prices.split(",");
			
			for(var i=0;i<endCount.length;i++){
				var start = Number(startCount[i]);
				if(start == "") {
					start = 0;
				}
				var end = Number(endCount[i]);
				if(end == "") {
					end = 9999999999;
				};
				
				if(Number(start) <= Number(amount) && Number(amount) <= Number(end)){
					totalprice = (prices[i] * amount).toFixed(2);
					break;
				}
			}
			if(totalprice == -1){
				var price = $("#price"+goodsid).html();
				totalprice = (price * amount).toFixed(2);
			}
		}else{
			var price = $("#price"+goodsid).html();
			totalprice = (price * amount).toFixed(2);
		}
		$("#goodsprice"+goodsid).html(totalprice);
		
		refreshAllprice();
	}
	
	function refreshAllprice(){
		//刷新总价
		var allprice = 0;
		$(".goods_price").each(function(i,n){
			allprice += Number($(this).html());
	    });
		$("#allprice").html(allprice.toFixed(2));
	}
	
	function IsPC() {
	    var userAgentInfo = navigator.userAgent;
	    var Agents = ["Android", "iPhone",
	                "SymbianOS", "Windows Phone",
	                "iPad", "iPod"];
	    var flag = true;
	    for (var v = 0; v < Agents.length; v++) {
	        if (userAgentInfo.indexOf(Agents[v]) > 0) {
	            flag = false;
	            break;
	        }
	    }
	    return flag;
	}
	
</script>
</body>
</html>