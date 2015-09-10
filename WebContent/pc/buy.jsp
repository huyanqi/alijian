<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
</style>
</head>
<body>

<jsp:include page="head.jsp" flush="true"/>

<div class="am-container" >
	<h3 style="text-align: center;">阿里健订单确认</h3>
	<table style="width: 100%;margin-top: 10px;" id="goods_info">
		<tbody>
			<tr><td><img alt="" src="" width="120px" height="120px" id="thum"/></td><td style="height: 80px;" id="goods_name_ly"><font id="goods_name"></font></td></tr>
			<tr><td class="table_th" style="height: 55px;">单价:</td><td><a style="font-size: 12px;color: #027cff;margin-right: 5px;">￥</a><font style="font-size:30px;line-height:50px;color:#027cff;" id="price"></font><font style="font-size: 12px;color:black;margin-left:5px;" id="units">/ 个</font></td></tr>
			<tr><td class="table_th" style="height: 55px;">运费:</td><td><a style="font-size: 12px;" id="freight"></a></td></tr>
			<tr><td class="table_th" style="height: 55px;">购买数量:</td><td><span id="redu"><a href="#" style="padding: 5px;">-</a></span><input id="add" type="text" value="1" style="width:50px; text-align:center;ime-mode:disabled" onkeypress="return event.keyCode>=48&&event.keyCode<=57" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/><span id="add1"><a href="#" style="padding: 5px;">+</a></span></td></tr>
			<tr><td class="table_th" style="height: 55px;">邮寄地址:</td><td><input id="buyeraddress" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
			<tr><td class="table_th" style="height: 55px;">联系人:</td><td><input id="buyername" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
			<tr><td class="table_th" style="height: 55px;">联系人手机号:</td><td><input id="buyermobile" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
			<tr><td class="table_th" style="height: 55px;">备注:</td><td><input id="remark" type="text"  style="width:100%;" class="am-form-field"/></td></tr>
			<tr><td style="border-bottom: 0px;" id="contact_me"></td><td align="right" style="height: 55px;border-bottom: 0px;"><a style="color: black;margin-right: 20px;">总价:<font size="8" style="color:#CD0204;" id="totalprice"></font>元</a><button type="button" id="submitbtn" class="am-btn am-radius am-btn-primary am-disabled" onclick="formsubmit();">确认购买</button></td></tr>
		</tbody>
	</table>
</div>

<script type="text/javascript">
	
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
		var price = $("#price").html();
		var amount = $("#add").val();
		$("#totalprice").html("￥"+(price * amount).toFixed(2));
	}
	
	function getUrlParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg); //匹配目标参数
		if (r != null)
			return unescape(r[2]);
		return null; //返回参数值
	}
	
	function getUserSession() {
		$.ajax({
			type : 'POST',
			dataType : "json",
			contentType : "application/json ; charset=utf-8",
			url : "<%=basePath%>getSession",
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					//已登录，获取产品详情
					getGoodsById();
				}else{
					//未登录
					alert("请先登录后再购买");
					window.location.href="<%=basePath%>login.jsp";
				}
			}
		});
	}
	
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
					$("#thum").attr("src",result.thum);
					$("#goods_name").html(result.name);
					$("#price").html(result.price);
					$("#units").html("/ "+result.units);
					$("#freight").html(result.freight);
					$("#description").html(result.description);
					$.each(result.typeList, function(n, value) {
						$("#types").append("<a target='_blank' href='<%=basePath%>goods.jsp?id="+value.id+"'>"+value.name+"</a>");
					});
					$("#contact_me").append("<a target='_blank' href='tencent://message/?uin=375377612&amp;Site=阿里健&amp;Menu=yes' class='content-btn' title='在线咨询'> <img border='0' src='http://wpa.qq.com/pa?p=2:375377612:42' alt='点击这里给我发消息' title='点击这里给我发消息'></a>");
					refreshTotalPrice();
				}else{
					alert("错误的商品ID号");
					window.close();
				}
			},
			dataType : "json"
		});
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
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			data : {"amout":amount,"goods_ids":goodsid,"address":buyeraddress,"mobile":buyermobile,"name":buyername,"remark":remark},
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