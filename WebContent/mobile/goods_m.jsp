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
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"></meta>
<title>阿里健 - 淘资源</title>

</head>
<body>

<jsp:include page="head_m.jsp" flush="true" />
<div class="jiathis_style" style="padding: 10px;display: inline-block;">
<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt" target="_blank"><img src="http://v2.jiathis.com/code_mini/images/btn/v1/jiathis5.gif" border="0" /></a>
</div>

<img id="thum" alt="" width="100%"/>

<table id="goods_info" style="clear: both;margin:10px 10px 10px 10px;">
	<tr><td colspan="2" style="height: 80px;" id="goods_name_ly"><font id="goods_name"></font></td></tr>
	<tr><td class="table_th" style="height: 55px;">单价:</td><td><a style="font-size: 12px;color: #027cff;margin-right: 5px;">￥</a><font style="font-size:30px;line-height:50px;color:#027cff;" id="price"></font><font style="font-size: 12px;color:black;margin-left:5px;" id="units"></font></td></tr>
	<tr><td class="table_th" style="height: 55px;">运费:</td><td><a style="font-size: 12px;" id="freight"></a></td></tr>
	<tr><td class="table_th" style="height: 55px;">销量:</td><td><a style="font-size: 12px;" id="sales_volume"></a></td></tr>
	<tr><td class="table_th" style="height: 55px;">所属分类:</td><td id="types"></td></tr>
	<tr><td style="border-bottom: 0px;" id="contact_me"></td><td align="right" style="height: 55px;border-bottom: 0px;"><button type="button" class="am-btn am-radius am-btn-primary" >立即订购</button></td></tr>
</table>

<header class="am-topbar" style="margin-bottom: 0px;" >
	<h1 class="am-topbar-brand">
		<a href="#">详细信息</a>
	</h1>
</header>
<div id="description">
</div>

<script>
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
		url : "<%=basePath%>getGoodsModelById",
		success : function(result) {
			$.AMUI.progress.done();
			if (result.result == "ok") {
				result = result.data;
				$("#thum").attr("src",result.thum);
				$("#goods_name").html(result.name);
				$("#goods_name_ly").append("<img style='margin-left:10px;' src='<%=basePath%>assets/images/icon_self.png' />");
				$("#price").html(result.price);
				$("#units").html("/ "+result.units);
				$("#freight").html(result.freight);
				$("#sales_volume").html(result.sales_volume+result.units);
				$("#description").html(result.description);
				$("#description img").css("height","").css("width","100%");
				$.each(result.typeList, function(n, value) {
					$("#types").append("<a target='_blank' href='<%=basePath%>goods.jsp?id="+value.id+"'>"+value.name+"</a>");
				});
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
<jsp:include page="footer_m.jsp" flush="true" />
</body>
</html>