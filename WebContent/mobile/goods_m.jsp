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

	body{
		padding-bottom: 50px;
	}

	.table_th font{
		font-size: 12px;
	}
	#goods_info td{
		border-bottom: 1px solid #EEEEEE;
		padding-left: 10px;
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
	
	#thum img{
		width: 100%;
		height: 260px;
	}
	
	.commentclass>div{
		float: left;
	}
	
	.clear{
		clear: both;
		width:100%;
		height:1px;
		background:#CCCCCC;
		margin-top: 5px;
		margin-bottom: 5px;
	}
	
	.extra2 {
	    background-repeat: no-repeat;
	    background-position: center;
	    text-align:center;
	    height: auto;
	    width: 100%;
	    position: fixed;
	    bottom: 0px;
	    z-index: 9999;
	    padding:6px;
	    background: #F3F3F3;
	}
	
</style>
</head>
<body>

<div class="extra2" role="presentation">
	<button type="button" style="width: 100%;" class="am-btn am-radius am-btn-primary" id="buy_submit">立即订购</button>
</div>

<jsp:include page="head_m.jsp" flush="true" />
<div class="jiathis_style" style="padding: 10px;display: inline-block;">
<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt" target="_blank"><img src="http://v2.jiathis.com/code_mini/images/btn/v1/jiathis5.gif" border="0" /></a>
</div>

<div data-am-widget="slider" class="am-slider am-slider-a5"
	data-am-slider='{&quot;directionNav&quot;:false}' id="thum_ly">
	<ul class="am-slides" id="thum">
	</ul>
</div>

<table id="goods_info" style="clear: both;width: 100%;">
		<tr><td colspan="2" style="height: 80px;" id="goods_name_ly"><font id="goods_name"></font></td></tr>
		<tr><td class="table_th" style="height: 55px;"><font>单价:</font></td><td><a style="font-size: 12px;color: #027cff;margin-right: 5px;">￥</a><font style="font-size:30px;line-height:50px;color:#027cff;" id="price"></font><font style="font-size: 12px;color:black;margin-left:5px;" id="units"></font></td></tr>
		<tr id="pifa_ly" style="display: none;"><td class="table_th" style="height: 55px;"><font>批发价:</font></td>
			<td id="pifa" style="padding-top: 20px;">
				<ul id="pifa_ul">
				</ul>
			</td>
		</tr>
		<tr><td class="table_th" style="height: 55px;"><font>运费:</font></td><td><a style="font-size: 12px;" id="freight"></a></td></tr>
		<tr><td class="table_th" style="height: 55px;"><font>销量:</font></td><td><a style="font-size: 12px;" id="sales_volume"></a></td></tr>
		<tr><td class="table_th" style="height: 55px;"><font>所属分类:</font></td><td id="types"></td></tr>
		<tr><td class="table_th" style="height: 55px;"><font>卖家:</font></td><td id="supplier_ly"><a style="font-size: 12px;margin-right: 10px;" id="supplier"></a></td></tr>
		<tr><td style="border-bottom: 0px;" id="contact_me"></td><td align="right" style="height: 55px;border-bottom: 0px;"><button type="button" style="margin: 10px;" class="am-btn am-radius am-btn-primary" id="buy_submit">立即订购</button></td></tr>
</table>

<div data-am-widget="tabs" class="am-tabs am-tabs-default" style="margin: 0;">
      <ul class="am-tabs-nav am-cf">
          <li class="am-active"><a href="[data-tab-panel-0]">详细信息</a></li>
          <li class=""><a href="[data-tab-panel-1]">商品评价</a></li>
      </ul>
      <div class="am-tabs-bd">
          <div data-tab-panel-0 class="am-tab-panel am-active" id="description">
          </div>
          <div data-tab-panel-1 class="am-tab-panel">
	    	<ul style="list-style: none;margin: 0;padding: 0;display: inline-block;" id="comment_ly">
	    		
	    	</ul>
	    	<div>
		    	<a href="javascript:page(0);">上一页</a>
		    	<a href="javascript:page(1);">下一页</a>
	    	</div>
          </div>
      </div>
  </div>

<script src="<%=basePath%>assets/javascripts/alijian.js"></script>
<script src="<%=basePath%>font/raty/moment.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
var id;
var goods;
$(document).ready(function(){
	moment.locale('zh-cn');
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
				goods = result;
				$("#thum").append("<li><img src='"+result.thum+"'></li>");
				if(result.thums != null){
					var thums = result.thums.split(",");
					for(var i=0;i<thums.length;i++){
						if(thums[i] == "") continue;
						$("#thum").append("<li><img src='"+thums[i]+"'></li>");
					}
				}
 				$('#thum_ly').flexslider({
					  // options
					  });
				$("#goods_name").html(result.name);
				$("#goods_name_ly").append("<img style='margin-left:10px;' src='<%=basePath%>assets/images/icon_self.png' />");
				$("#price").html(result.price);
				$("#units").html("/ "+result.units);
				$("#freight").html(result.freight);
				$("#sales_volume").html(result.sales_volume+"笔");
				$("#description").html(result.description);
				$("#description img").css("height","").css("width","100%");
				$.each(result.typeList, function(n, value) {
					$("#types").append("<a target='_blank' href='<%=basePath%>goods.jsp?id="+value.id+"'>"+value.name+"</a>");
				});
				$("#supplier").html(result.user.name);
				$("#supplier").attr("href","<%=basePath%>mobile/supplier_m.jsp?id="+result.user.id+"");
				$("#supplier_ly").append(getLevel("<%=basePath%>",result.user.credit_supplier));
				//$("#contact_me").append("<a target='_blank' href='tencent://message/?uin=375377612&amp;Site=阿里健&amp;Menu=yes' class='content-btn' title='在线咨询'> <img border='0' src='http://wpa.qq.com/pa?p=2:375377612:42' alt='点击这里给我发消息' title='点击这里给我发消息'></a>");
				$("#contact_me").append("<a id='contact_me_a' href='javascript:toChat();' class='content-btn' title='在线咨询'> <img border='0' src='<%=basePath%>font/imgs/icon_chat.png' alt='点击这里给我发消息' title='点击这里给我发消息'></a>");
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
				getComments();
				getWXSignature();
			}else{
				alert("错误的商品ID号");
				window.close();
			}
		},
		dataType : "json"
	});
}

var pageNum = 1;
function getComments(){
	$.AMUI.progress.start();
	$.ajax({
		type : 'POST',
		data : {"goods_id":id,"pageNum":pageNum},
		url : "<%=basePath%>getComment",
		success : function(result) {
			$.AMUI.progress.done();
			$("#comment_ly").empty();
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					var stars = "";
					for(var i=0;i<value.star;i++){
						stars += "<img src='<%=basePath%>font/raty/images/star-on.png' width='18' height='18'/>";
					}
					var time = "";
					time = moment(value.update_time.time).format("YYYY-MM-DD");
					$('#comment_ly').append("<li class='commentclass'><div style='width: 60%;'><div>"+value.content+"</div><div style='margin-left: 5px;'>"+stars+"</div></div><div style='width: 40%;'><div style='font-size: 13px;'>"+value.user.name+"</div><div>"+time+"</div></div><div class='clear'/></li>");
				});
			}else{
				$("#comment_ly").append("暂无");
			}
		},
		dataType : "json"
	});
}

function getWXSignature(){
	var timestamp = Math.round(new Date().getTime()/1000);
	var noncestr = Math.random().toString(36).substr(2, 15);
	var host = window.location.href;
	$.ajax({
		type : 'POST',
		data : {"host":host,"timestamp":timestamp,"noncestr":noncestr},
		url : "<%=basePath%>getWXSignature",
		success : function(result) {
			var signature = result.data;
			wx.config({
			    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			    appId: 'wxd12014470a8088bc', // 必填，公众号的唯一标识
			    timestamp: timestamp, // 必填，生成签名的时间戳
			    nonceStr: noncestr, // 必填，生成签名的随机串
			    signature: signature,// 必填，签名，见附录1
			    jsApiList: ["onMenuShareAppMessage","onMenuShareTimeline"] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			});
			wx.ready(function(){
			    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
				wx.onMenuShareAppMessage({
				    title: '阿里健 - 大健康产业链', // 分享标题
				    desc: goods.name, // 分享描述
				    link: host, // 分享链接
				    imgUrl: '<%=basePath%>'+goods.thum, // 分享图标
				    type: '', // 分享类型,music、video或link，不填默认为link
				    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
				    success: function () { 
				        // 用户确认分享后执行的回调函数
				        alert("分享成功");
				    },
				    cancel: function () { 
				        // 用户取消分享后执行的回调函数
				    }
				});
			    
				wx.onMenuShareTimeline({
				    title: '【阿里健 - 大健康产业链】'+goods.name, // 分享标题
				    link: host, // 分享链接
				    imgUrl: '<%=basePath%>'+goods.thum, // 分享图标
				    success: function () { 
				        // 用户确认分享后执行的回调函数
				    	alert("分享成功");
				    },
				    cancel: function () { 
				        // 用户取消分享后执行的回调函数
				    }
				});
			});
		},
		dataType : "json"
	});
}

function page(flag){
	if(flag == 0){
		//上一页
		if(pageNum > 1)
			pageNum--;
	}else{
		//下一页
		pageNum++;
	}
	getComments();
}

function toChat(){
	window.location.href = "<%=basePath%>chat/chat.jsp?chat="+goods.user.id;
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