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

.item {
	margin-left: 10px;
	margin-top: 10px;
	float: left;
	width: 220px;
	height: 220px;
	background: white;
	overflow: hidden;
	border: solid 1px #04aeda;
}

.item .lecturer_img {
	width: 180px;
	height: 220px;
	float: left;
}

.item .supplier_name {
	width: 220px;
	height: 40px;
	display: block;
	text-align: center;
	line-height: 40px;
}

.item .supplier_img {
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

#goods_name {
	font-size: 24px;
	font-weight: 700;
	color: #222;
	width: 100%;
	display: inline-block;
	text-align: center;
	padding: 20px 20px 20px 20px;
}

ul {
	list-style: none;
}
</style>

</head>
<body class="am-with-topbar-fixed-top">

	<jsp:include page="head_m.jsp" flush="true" />

	<font id="goods_name"></font>
	<div id="contact_me" style="text-align: center;"></div>
	<div class="am-container" style="margin-top: 10px;" id="description">

	</div>
	<script>
var uid;
var id;
	$(document).ready(function(){
		id = getUrlParam("id");
		if(id == null){
			window.close();
		}else{
			getBusinessById();
		}
	});
	
	function getBusinessById(){
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
						$("#description img").css("height","").css("width","100%");
						$("#contact_me").append("<a id='contact_me_a' href='javascript:toChat("+result.user.id+");' class='content-btn' title='在线咨询'> <img border='0' src='<%=basePath%>font/imgs/icon_chat.png' alt='点击这里给我发消息' title='点击这里给我发消息'></a>");
					} else {
						alert("错误的商品ID号");
						window.close();
					}
				},
				dataType : "json"
			});
		}
	
		function toChat(userid){
			window.location.href = "<%=basePath%>chat/chat.jsp?chat="+userid;
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