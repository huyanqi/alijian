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
<title>阿里健 - 发货单确认</title>
<style type="text/css">
	#goods_info {
		border: 1px solid #E5E5E5;
	}
	#goods_info tr td{
		border-bottom: 1px solid #E5E5E5;
		padding: 5px;
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

	<h3 style="text-align: center;">阿里健发货单确认</h3>
	<table style="width: 100%;margin-top: 10px;" id="goods_info">
		<tr><td><img alt="" src="" width="120px" height="120px" id="thum"/></td><td style="height: 80px;" id="goods_name_ly"><font id="goods_name"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">数量:</td><td><font id="amout"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">邮寄地址:</td><td><font id="address"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">收货人:</td><td><font id="user_name"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">收货人手机号:</td><td><font id="user_mobile"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">备注:</td><td><font id="remark"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">发货单号:</td><td><input type="text" id="cnumber"></font></td></tr>
		<tr><td colspan="2" align="right" style="height: 55px;border-bottom: 0px;"><button type="button" id="submitbtn" class="am-btn am-radius am-btn-primary am-disabled" onclick="formsubmit();">确认发货</button></td></tr>
	</table>
</div>

<script type="text/javascript">
	
	$("#header_ly").load("<%=basePath%>pc/head.jsp");
	
	var orderid;
	$(document).ready(function(){
		orderid = getUrlParam("id");
		if(orderid == null){
			window.close();
		}else{
			getUserSession();
		}
	});
	
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
			//已登录
			if(cookie.get("uid") != orderid.split("-")[orderid.split("-").length-2]){
				alert("非法操作");
				window.close();
				return;
			}
			//已登录，获取订单详情
			getOrderById();
		}else{
			//未登录
			alert("请先登录后使用此功能");
			window.location.href="<%=basePath%>login.jsp";
		}
	}
	
	function getOrderById(){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			data : {"orderid":orderid},
			url : "<%=basePath%>getOrderById",
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					$("#submitbtn").removeClass("am-disabled");
					result = result.data;
					$("#thum").attr("src",result.goods.thum);
					$("#goods_name").html(result.goods.name);
					$("#amout").html(result.amout);
					$("#address").html(result.address);
					$("#user_name").html(result.name);
					$("#user_mobile").html(result.mobile);
					$("#remark").html(result.remark);
				}else{
					alert("错误的订单号");
					window.close();
				}
			},
			dataType : "json"
		});
	}
	
	function formsubmit(){
		var cnumber = $("#cnumber").val();
		if(cnumber == ""){
			if(!confirm("是否不需要提供快递单号?")){
				return;
			};
		}
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			data : {"no":orderid,"cnumber":cnumber},
			url : "<%=basePath%>fahuo",
			success : function(result) {
				$.AMUI.progress.done();
				if(result.result == "ok"){
					alert("操作已完成");
					window.close();
				}else{
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
	
</script>
</body>
</html>