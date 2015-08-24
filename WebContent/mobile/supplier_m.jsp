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

	<title>阿里健 - 淘资源</title>
  
</head>
<body class="am-with-topbar-fixed-top">

	<jsp:include page="head_m.jsp" flush="true"/>	
	
	<img id="thum" alt="" width="100%" />
	
	<table style="clear: both;margin:10px 10px 10px 10px;" id="goods_info">
		<tr><td colspan="2" style="height: 50px;" id="goods_name_ly"><font id="goods_name"></font></td></tr>
		<tr><td colspan="2" style="height: 50px;"><font id="address"></font></td></tr>
		<tr><td class="table_th" style="height: 35px;">经营领域:</td><td id="types"></td></tr>
		<tr><td colspan="2" style="border-bottom: 0px;" id="contact_me"></td></tr>
	</table>
	
	<!-- <div class="am-container" style="height: 400px;">
		<div style="width: 400px;height: 450px;float: left;margin-top: 1px;">
			
		</div>
		<a style="width: 1px;height: 100%;background: #DDDDDD;float: left;"></a>
		<div style="width: 500px;height: 450px;float: left;">
			
		</div>
	</div> -->
	
	<div style="clear: both;"/>
	
	<div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
		<header class="am-topbar">
			<h1 class="am-topbar-brand">
				<a href="#">厂家介绍</a>
			</h1>
		</header>
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
			getSuppliesById();
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
					$.each(result.typeList, function(n, value) {
						$("#types").append("<a target='_blank' href='<%=basePath%>goods.jsp?id="+value.id+"'>"+value.name+"</a>");
					});
					$("#description").html(result.description);
					$("#description img").css("height","").css("width","100%");
					$("#contact_me").append("<a target='_blank' href='tencent://message/?uin=375377612&amp;Site=阿里健&amp;Menu=yes' class='content-btn' title='在线咨询'> <img border='0' src='http://wpa.qq.com/pa?p=2:375377612:42' alt='点击这里给我发消息' title='点击这里给我发消息'></a>");
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