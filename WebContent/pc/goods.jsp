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
  <meta name="viewport"  content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"></meta>
  <title>阿里健 - 大健康产业链</title>

  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit"></meta>

  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/></meta>

  <link rel="icon" type="image/png" href="<%=basePath%>font/amazeui/i/favicon.png"></link>

  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes"></meta>
  <link rel="icon" sizes="192x192" href="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></link>

  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes"></meta>
  <meta name="apple-mobile-web-app-status-bar-style" content="black"></meta>
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></link>

  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="font/amazeui/i/app-icon72x72@2x.png"></meta>
  <meta name="msapplication-TileColor" content="#0e90d2"></meta>

  <link rel="stylesheet" href="<%=basePath%>font/amazeui/css/amazeui.min.css"></link>
  <link rel="stylesheet" href="<%=basePath%>font/amazeui/css/app.css"></link>
	
	<style>
	
	.my_at {
		border-bottom: 4px solid #0E90D2;
	}
	
	.my_at font {
		color: #0E90D2;
		font-size: 20px;
	}
	
	.my_at font a {
		font-size: 25px;
	}
	
	.my_at .am-topbar-right {
		margin-top: 5px;
	}
	
	.item{
		margin-left:10px;
		margin-top:10px;
		float: left;
		width: 220px;
		height: 220px;
		background: white;
		overflow: hidden;
		border: solid 1px #04aeda;
	}
	
	.item .lecturer_img{
		width: 180px;
		height: 220px;
		float: left;
	}
	.item .supplier_name{
		width: 220px;
		height: 40px;
		display: block;
		text-align: center;
		line-height: 40px;
	}
	
	.item .supplier_img{
		width: 220px;
		height: 180px;
	}
	
	.footer p {
	    color: #7f8c8d;
	    margin: 0;
	    padding: 15px 0;
	    text-align: center;
	    margin-top: 30px;
	}
	
	#goods_name{
		font-size: 18px;
	    font-weight: 700;
	    color: #222;
	}
	.table_th{
		font-size: 12px;
	}
	
	#goods_info tr td{
		border-bottom: 1px solid #E5E5E5;
	}
	
	#types a{
		margin-left: 5px;
		font-size: 14px;
	}
	
	.prices_ul{
		list-style: none;
		padding: 0;
		border: 1px solid #CCCCCC;
		width: 125px;
		padding: 5px;
	}
	
	.prices_ul font{
		font-weight: bold;
		color: white;
	}
	
	#pifa_ul{
		list-style: none;
		padding: 0;
	}
	
	#pifa_ul>li{
		float: left;
		margin-left: 3px;
	}
</style>
	
</head>
<body class="am-with-topbar-fixed-top">

	<jsp:include page="head.jsp" flush="true"/>
	
	<div class="am-container" style="background: #DDDDDD;height: 1px;"/>
	
	<div class="jiathis_style" style="padding: 10px;display: inline-block;width: 100%;">
		<a href="http://www.jiathis.com/share" style="float: none;" class="jiathis jiathis_txt" target="_blank"><img src="http://v2.jiathis.com/code_mini/images/btn/v1/jiathis5.gif" border="0" /></a>
	</div>

	<div class="am-container" style="height: 400px;">
		<div style="width: 400px;height: 450px;float: left;margin-top: 1px;">
			<img id="thum" alt="" width="400px" height="400px" />
		</div>
		<a style="width: 1px;height: 100%;background: #DDDDDD;float: left;"></a>
		<div style="width: 500px;height: 600px;float: left;">
			<table style="width: 100%;margin-left: 30px;margin-top: 10px;" id="goods_info">
				<tr><td colspan="2" style="height: 80px;" id="goods_name_ly"><font id="goods_name"></font></td></tr>
				<tr><td class="table_th" style="height: 55px;">单价:</td><td><a style="font-size: 12px;color: #027cff;margin-right: 5px;">￥</a><font style="font-size:30px;line-height:50px;color:#027cff;" id="price"></font><font style="font-size: 12px;color:black;margin-left:5px;" id="units"></font></td></tr>
				<tr id="pifa_ly" style="display: none;"><td class="table_th" style="height: 55px;">批发价:</td>
					<td id="pifa" style="padding-top: 20px;">
						<ul id="pifa_ul">
						</ul>
					</td>
				</tr>
				<tr><td class="table_th" style="height: 55px;">运费:</td><td><a style="font-size: 12px;" id="freight"></a></td></tr>
				<tr><td class="table_th" style="height: 55px;">所属分类:</td><td id="types"></td></tr>
				<tr><td class="table_th" style="height: 55px;">卖家:</td><td id="supplier_ly"><a style="font-size: 12px;margin-right: 10px;" id="supplier"></a></td></tr>
				<tr><td style="border-bottom: 0px;" id="contact_me"></td><td align="right" style="height: 55px;border-bottom: 0px;"><button type="button" class="am-btn am-radius am-btn-primary" id="buy_submit">立即订购</button></td></tr>
			</table>
		</div>
	</div>
	
	<div style="clear: both;"/>
	
	<div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
		<header class="am-topbar">
			<h1 class="am-topbar-brand">
				<a href="#">详细信息</a>
			</h1>
		</header>
		<div class="am-container" style="margin-top: 10px;" id="description">
			
		</div>
	</div>
	
	<jsp:include page="footer.jsp" flush="true"/>
	
<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
<script src="<%=basePath%>assets/javascripts/alijian.js"></script>
<script>

var id = getUrlParam("id");
alert("this is goods.jsp");
	$(document).ready(function(){
		if(id == null){
			window.close();
		}else{
			getGoodsById();
		}
	});
	
	var goods;
	function getGoodsById(){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			data : {"id":id},
			url : "<%=basePath%>getGoodsModelById",
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					result = result.data;
					goods = result;
					$("#thum").attr("src",result.thum);
					$("#goods_name").html(result.name);
					$("#goods_name_ly").append("<img style='margin-left:10px;' src='<%=basePath%>assets/images/icon_self.png' />");
					$("#price").html(result.price);
					$("#units").html("/ "+result.units);
					$("#freight").html(result.freight);
					$("#description").html(result.description);
					$.each(result.typeList, function(n, value) {
						$("#types").append("<a target='_blank' href='<%=basePath%>goods/"+value.id+"'>"+value.name+"</a>");
					});
					$("#supplier").html(result.user.name);
					$("#supplier").attr("href","<%=basePath%>pc/supplier.jsp?id="+result.user.id+"");
					$("#supplier_ly").append(getLevel("<%=basePath%>",result.user.credit_supplier));
					$("#contact_me").append("<a id='contact_me_a' href='javascript:toChat();' class='content-btn' title='在线咨询'> <img border='0' src='http://wpa.qq.com/pa?p=2:375377612:42' alt='点击这里给我发消息' title='点击这里给我发消息'></a>");
					$("#buy_submit").click(function(){
						location.href="<%=basePath%>pc/buy.jsp?id="+result.id;
					});
					if(result.priceModel != null){
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
					//document.getElementById("contact_me_a").click();
				}else{
					alert("错误的商品ID号");
					window.close();
				}
			},
			dataType : "json"
		});
	}
	
	function toChat(){
		var iHeight = 575;
		var iWidth = 900;
		var iTop = (window.screen.height-30-iHeight)/2; //获得窗口的垂直位置;  
		var iLeft = (window.screen.width-10-iWidth)/2; //获得窗口的水平位置;  
		window.open("<%=basePath%>chat/chat.jsp?chat="+goods.user.id,'newindow','height='+iHeight+',width='+iWidth+',top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no,top='+iTop+',left='+iLeft);
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