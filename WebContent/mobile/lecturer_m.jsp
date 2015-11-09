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
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"></meta>
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
	width: 220px;
	height: 220px;
	background: white;
	overflow: hidden;
	border: solid 1px #04aeda;
}

.item .lecturer_img {
	width: 180px;
	height: 220px;
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
	font-size: 18px;
	font-weight: 700;
	color: #222;
}

.table_th {
	font-size: 12px;
}

#goods_info tr td {
	border-bottom: 1px solid #E5E5E5;
}

#types a {
	margin-left: 5px;
	font-size: 14px;
}
</style>

</head>
<body>
	<jsp:include page="head_m.jsp" flush="true" />
	
	<img id="thum" alt="" style="max-width:100%; min-height: 301px;" />

	<div style="margin: 10px 10px 10px 10px;">

		<table id="goods_info" style="width: 100%;">
			<tr>
				<td colspan="2" style="height: 50px;" id="goods_name_ly"><font
					id="goods_name"></font></td>
			</tr>
			<tr>
				<td colspan="2" style="height: 50px;"><font id="birth"></font></td>
			</tr>
			<tr>
				<td class="table_th" style="height: 50px;">擅长领域:</td>
				<td id="types"></td>
			</tr>
			<tr>
				<td colspan="2" style="border-bottom: 0px;" id="contact_me"></td>
			</tr>
		</table>
	</div>

	<header class="am-topbar">
	<h1 class="am-topbar-brand">
		<a href="#">讲师介绍</a>
	</h1>
	</header>
	<div class="am-container" style="margin-top: 10px;" id="description">

	</div>

	<jsp:include page="footer_m.jsp" flush="true" />

	<script>
	
	var id;
	$(document).ready(function(){
		id = getUrlParam("id");
		if(id == null){
			window.close();
		}else{
			getLecturerModelById();
		}
	});
	
	function getLecturerModelById(){
		var path = "<%=basePath%>getLecturerModelById";
		var data = {"id":id};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				if (result.result == "ok") {
					result = result.data;
					$("#thum").attr("src","<%=basePath%>"+result.thum);
					$("#goods_name").html(result.name);
					$("#birth").html("出生年月:"+result.birth);
					$("#description").html(result.description);
					$("#description img").css("height","").css("width","100%");
					$.each(result.typeModels, function(n, value) {
						$("#types").append("<a target='_blank' href='<%=basePath%>goods.jsp?id="+ value.id + "'>"+ value.name + "</a>");});
								//$("#contact_me").append("<a target='_blank' href='tencent://message/?uin=375377612&amp;Site=阿里健&amp;Menu=yes' class='content-btn' title='在线咨询'> <img border='0' src='http://wpa.qq.com/pa?p=2:375377612:42' alt='点击这里给我发消息' title='点击这里给我发消息'></a>");
							} else {
								alert("错误的讲师ID号");
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