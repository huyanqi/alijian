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
<title>阿里健 - 商品评价</title>
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
<link rel="stylesheet" href="<%=basePath%>font/raty/jquery.raty.css"></link>
<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
<script src="<%=basePath%>font/raty/jquery.raty.js"></script>
</head>
<body>

<div class="am-container" >

	<h3 style="text-align: center;">阿里健 - 商品评价</h3>
	<table style="width: 100%;margin-top: 10px;" id="goods_info">
		<tr><td><img alt="" src="" width="120px" height="120px" id="thum"/></td><td style="height: 80px;" id="goods_name_ly"><font id="goods_name"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">购买数量:</td><td><font id="amout"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">发货单号:</td><td><font id="cnumber"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">总价:</td><td><font id="prices"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;">打分:</td><td><div id="star"></div></td></tr>
		<tr><td class="table_th" style="height: 55px;">评论:</td><td><textarea rows="10" cols="10" id="content" style="width: 100%;"></textarea></td></tr>
		<tr><td colspan="2" align="right" style="height: 55px;border-bottom: 0px;"><button type="button" id="submitbtn" class="am-btn am-radius am-btn-primary am-disabled" onclick="formsubmit();">发布评价</button></td></tr>
	</table>
</div>

<script type="text/javascript">
	
	var order_id;
	var scoreNum = 5;
	var goods_id = 0;
	$(document).ready(function(){
		order_id = getUrlParam("id");
		$("#star").raty({
			score : 5,
			starOff : '<%=basePath%>font/raty/images/star-off.png',
			starOn  : '<%=basePath%>font/raty/images/star-on.png',
			click: function(score, evt) {
				scoreNum = score; 
			    return true;
			  }
		});
		if(order_id == null){
			window.close();
		}else{
			getOrderById();
		}
	});
	
	function getUrlParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg); //匹配目标参数
		if (r != null)
			return unescape(r[2]);
		return null; //返回参数值
	}
	
	function getOrderById(){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			data : {"orderid":order_id},
			url : "<%=basePath%>getOrderByOrderId",
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					$("#submitbtn").removeClass("am-disabled");
					result = result.data;
					order_id = result.orders_no;
					$("#thum").attr("src",result.goods.thum);
					$("#goods_name").html(result.goods.name);
					goods_id = result.goods.id;
					$("#amout").html(result.amout);
					$("#cnumber").html(result.cnumber);
					$("#prices").html(result.prices+"元");
				}else{
					alert("错误的订单号");
					window.close();
				}
			},
			dataType : "json"
		});
	}
	
	function formsubmit(){
		$.AMUI.progress.start();
		var data = JSON.stringify({good_id:goods_id,star:scoreNum,content:$("#content").val(),order_id:order_id});
		$.ajax({
			type : 'POST',
			data : data,
			dataType : "json",
			contentType : "application/json ; charset=utf-8", 
			url : "<%=basePath%>comment",
			success : function(result) {
				$.AMUI.progress.done();
				if(result.result = "ok"){
					alert("评价已发布");
					window.history.back();
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