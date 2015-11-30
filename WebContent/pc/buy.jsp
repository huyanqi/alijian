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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>阿里健 - 订单确认</title>
<style type="text/css">
	#goods_info {
		border: 1px solid #E5E5E5;
	}
	#goods_info tr td{
		border-bottom: 1px solid #E5E5E5;
		padding: 5px;
	}
	#pifa_ul,.prices_ul{
		list-style: none;
		padding: 0;
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
</head>
<body>

<div id="header_ly"></div>

<div class="am-container" >

	<h3 style="text-align: center;">阿里健订单确认</h3>
	<table style="width: 100%;margin-top: 10px;" id="goods_info">
		<tr><td><img alt="" src="" width="120px" height="120px" id="thum"/></td><td style="height: 80px;" id="goods_name_ly"><font id="goods_name"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">单价:</td><td><a style="font-size: 12px;color: #027cff;margin-right: 5px;">￥</a><font style="font-size:30px;line-height:50px;color:#027cff;" id="price"></font><font style="font-size: 12px;color:black;margin-left:5px;" id="units">/ 个</font></td></tr>
		<tr id="pifa_ly" style="display: none;"><td class="table_th" style="height: 55px;">批发价:</td><td><ul id="pifa_ul"></ul></td></tr>
		<tr><td class="table_th" style="height: 55px;">运费:</td><td><a style="font-size: 12px;" id="freight"></a></td></tr>
		<tr id="type_ly" style="display: none;"><td class="table_th" style="height: 55px;">选择种类:</td><td><ul class="am-nav am-nav-pills" id="type"></ul></td></tr>
		<tr><td class="table_th" style="height: 55px;">购买数量:</td><td><span id="redu"><a href="#" style="padding: 5px;">-</a></span><input id="add" type="text" value="1" style="width:50px; text-align:center;ime-mode:disabled" onkeypress="return event.keyCode>=48&&event.keyCode<=57" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/><span id="add1"><a href="#" style="padding: 5px;">+</a></span></td></tr>
		<tr><td class="table_th" style="height: 55px;">收货地址:</td><td><input id="buyeraddress" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
		<tr><td class="table_th" style="height: 55px;">联系人:</td><td><input id="buyername" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
		<tr><td class="table_th" style="height: 55px;">联系人手机号:</td><td><input id="buyermobile" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
		<tr><td class="table_th" style="height: 55px;">备注:</td><td><input id="remark" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
		<tr><td colspan="2" align="right" style="height: 55px;border-bottom: 0px;"><a style="color: black;margin-right: 20px;">总价:<font size="8" style="color:#CD0204;" id="totalprice"></font>元</a><button type="button" id="submitbtn" class="am-btn am-radius am-btn-primary am-disabled" onclick="formsubmit();">确认购买</button></td></tr>
	</table>
</div>

<script type="text/javascript">
	
	var isMobile = 0;
	var priceModel;
	
	if(!IsPC()){
		isMobile = 1;
		$("#header_ly").load("<%=basePath%>mobile/head_m.jsp");
	}else{
		isMobile = 0;
		$("#header_ly").load("<%=basePath%>pc/head.jsp");
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
	
	var goodsid;
	$(document).ready(function(){
		goodsid = getUrlParam("id");
		if(goodsid == null){
			alert("没有想要购买的产品");
		}else{
			getUserSession();
		}
		initAmoutSelector();
	});
	
	function initAmoutSelector(){
		$("#add1").click(function(){
		      var oldValue=parseInt($("#add").val()); //取出现在的值，并使用parseInt转为int类型数据
		      oldValue++   //自加1
		      $("#add").val(oldValue)  //将增加后的值付给控件
		      refreshTotalPrice();
		});
		$("#redu").click(function(){
		      var oldValue=parseInt($("#add").val()); //取出现在的值，并使用parseInt转为int类型数据
		      if(oldValue > 1){
		    	  oldValue--   //自减1
		      }
		     $("#add").val(oldValue)  //将增加后的值付给控件
		     refreshTotalPrice();
		});
		$('#add').bind('input propertychange', function() {  
		    $('#result').html($(this).val().length + ' characters');
		    refreshTotalPrice();
		});
	}
	
	function refreshTotalPrice(){
		var amount = $("#add").val();
		if(priceModel != null){
			//计算批发价，查询出这个范围的批发单价
			var startCount = priceModel.startCount.split(",");
			var endCount = priceModel.endCount.split(",");
			var prices = priceModel.price.split(",");
			var totalprice = -1;
			for(var i=0;i<endCount.length;i++){
				var start = startCount[i];
				if(start == "") {
					start = 0;
				}
				var end = endCount[i];
				if(end == "") {
					end = 9999999999;
				};
				if(Number(start) <= Number(amount) && Number(amount) <= Number(end)){
					totalprice = (prices[i] * amount).toFixed(2);
					break;
				}
			}
			if(totalprice == -1){
				var price = $("#price").html();
				totalprice = (price * amount).toFixed(2);
			}
			$("#totalprice").html("￥"+totalprice);
		}else{
			var price = $("#price").html();
			$("#totalprice").html("￥"+(price * amount).toFixed(2));
		}
	}
	
	function getUrlParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg); //匹配目标参数
		if (r != null)
			return unescape(r[2]);
		return null; //返回参数值
	}
	
	function getUserSession() {
		
		var cookie = $.AMUI.utils.cookie;
		if(cookie.get("accesstoken") != null){
			//已登录，获取产品详情
			getGoodsById();
		}else{
			//未登录
			alert("请先登录后再购买");
			window.location.href="<%=basePath%>login.jsp";
		}
	}
	
	var goods;
	function getGoodsById(){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			data : {"id":goodsid},
			url : "<%=basePath%>getGoodsModelById",
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					$("#submitbtn").removeClass("am-disabled");
					result = result.data;
					goods = result;
					$("#thum").attr("src",result.thum);
					$("#goods_name").html(result.name);
					$("#price").html(result.price);
					$("#units").html("/ "+result.units);
					$("#freight").html(result.freight);
					$("#description").html(result.description);
					$.each(result.typeList, function(n, value) {
						$("#types").append("<a target='_blank' href='<%=basePath%>goods/"+value.id+"'>"+value.name+"</a>");
					});
					if(result.priceModel != null){
						priceModel = result.priceModel;
						$("#pifa_ly").show();
						var start = result.priceModel.startCount.split(",");
						var end = result.priceModel.endCount.split(",");
						var price = result.priceModel.price.split(",");
						for(var i=0;i<start.length;i++){
							var startC = start[i];
							var endC = end[i];
							//endC+result.units+
							var showCount = "";
							if(startC == "") {
								showCount = "≤"+endC;
							}else if(endC == ""){
								showCount = "≥"+startC;
							}else{
								showCount = startC+"-"+endC;
							}
							$('#pifa_ul').append("<li><ul class='prices_ul' style='background: #FFA155;'><li><div><font>"+showCount+result.units+"</font></div></li><li><font>￥"+price[i]+"</font></li></ul></li>");
						}
					}
					if(result.goods_type != null && result.goods_type != ""){
						//显示商品属性
						var type = "";
						$.each(result.goods_type.split(","), function(n, value) {
							$("#type").append("<li id='type"+n+"'><a href='javascript:typeselect("+n+")'>"+value+"</a></li>");
						});
						$("#type_ly").show();
					}
					refreshTotalPrice();
				}else{
					alert("错误的商品ID号");
					window.close();
				}
			},
			dataType : "json"
		});
	}
	
	var lastselect = -1;
	function typeselect(id){
		if(lastselect != -1){
			$("#type"+lastselect).removeClass("am-active");
		}
		$("#type"+id).addClass("am-active");
		lastselect = id;
	}
	
	function formsubmit(){
		var amount = $("#add").val();
		var buyeraddress = $("#buyeraddress").val();
		var buyername = $("#buyername").val();
		var buyermobile = $("#buyermobile").val();
		var remark = $("#remark").val();
		if(amount == 0 || amount == ""){
			alert("请输入购买数量");
			return;
		}
		if(buyeraddress == "" || buyername == "" || buyermobile == ""){
			alert("请填写完整的收货信息，我们将尽快发货");
			return;
		}
		var goods_type = "";
		if(goods.goods_type != null && goods.goods_type != ""){
			//需要判断是否选择商品类型
			if(lastselect == -1){
				alert("请选择需要采购的商品种类");
				return;
			}
			goods_type = $("#type"+lastselect).find("a").html();
		}
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			data : {"amout":amount,"goods_id":goodsid,"address":buyeraddress,"mobile":buyermobile,"name":buyername,"remark":remark,"is_mobile":isMobile,"goods_type":goods_type},
			url : "<%=basePath%>create_order",
			success : function(result) {
				$.AMUI.progress.done();
				if(result.result == "ok"){
					$("body").append(result.data);
				}else{
					self.location="<%=basePath%>welcome.jsp";
				}
			},
			dataType : "json"
		});
	}
	
</script>
</body>
</html>