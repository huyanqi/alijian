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
  <title>阿里健 - 淘资源</title>

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
		font-size: 24px;
	    font-weight: 700;
	    color: #222;
        width: 100%;
	    display: inline-block;
	    text-align: center;
	    padding: 20px 20px 20px 20px;
	}

	ul{
		list-style: none;
	}
	
</style>
	
</head>
<body class="am-with-topbar-fixed-top">

	<jsp:include page="head.jsp" flush="true"/>	
	
	<div class="am-container" style="background: #DDDDDD;height: 1px;"/>

	<div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
		<font id="goods_name"></font>
	</div>
	
	<div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
		<div class="am-container" style="margin-top: 10px;" id="description">
			
		</div>
	</div>
	
	
	<footer class="footer">
	  <p>© 2015 <a href="#" target="_blank">阿里健 - 淘资源.</a> Powered by Frankie.</p>
	</footer>
	
<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
<script>
var uid;
var id;
	$(document).ready(function(){
		id = getUrlParam("id");
		if(id == null){
			window.close();
		}else{
			getGoodsById();
		}
	});
	
	function getGoodsById(){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			data : {"id":id},
			url : "<%=basePath%>getBusinessById",
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					result = result.data;
					$("#goods_name").html(result.name);
					$("#description").html(result.description);
				}else{
					alert("错误的商品ID号");
					window.close();
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