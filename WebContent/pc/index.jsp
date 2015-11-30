<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
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

  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes"></meta>

  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes"></meta>
  <meta name="apple-mobile-web-app-status-bar-style" content="black"></meta>
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></link>

  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="<%=basePath%>font/amazeui/i/app-icon72x72@2x.png"></meta>
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
</style>
	
</head>
<body class="am-with-topbar-fixed-top">

	<jsp:include page="head.jsp" flush="true"/>	
	
	<div class="am-container" style="background: #DDDDDD;height: 1px;"></div>
	
	<div>
		<iframe id="iframe1" src="<%=basePath%>boom.jsp" scrolling="no" style="height: 1000px;float: left;">
		</iframe>
		
		<!-- 搜索框 -->
		<div class="am_container" style="margin-top: 15px;width: 980px;float: left;">
			<div class="am-g">
				<div class="am-u-lg-6" style="padding:  0;">
					<div class="am-input-group" style="width: 500px;">
						<span class="am-input-group-btn">
							<button class="am-btn am-btn-default" type="button">
								<span class="am-icon-search"></span>
							</button>
						</span> 
						<input type="text" class="am-form-field" placeholder="输入关键字搜索" />
						<span class="am-input-group-btn">
							<button class="am-btn am-btn-default" onclick="search();" type="button">搜索</button>
						</span>
					</div>
				</div>
				<a target="_blank"
					style="margin-left: 100px;"
					href="tencent://message/?uin=375377612&Site=阿里健&Menu=yes"
					class="content-btn" title="在线咨询"> <img border="0"
					src="http://wpa.qq.com/pa?p=2:375377612:42" alt="点击这里给我发消息"
					title="点击这里给我发消息"></a>
				<a target="_blank"
					style="margin-left: 10px;"
					href="tencent://message/?uin=375377612&Site=阿里健&Menu=yes"
					class="content-btn" title="在线咨询"> <img border="0"
					src="http://wpa.qq.com/pa?p=2:375377612:42" alt="点击这里给我发消息"
					title="点击这里给我发消息"></a>
			</div>
			
			<!-- 多选框 -->
			<div class="am-form-group" style="margin-top: 20px;" id="type3ly">
			  <label>产品 ></label>
			  <label class="am-checkbox-inline">
			    <input type="checkbox"  value="0" data-am-ucheck checked onclick="unselectAll(3);">不限</input>
			  </label>
			</div>
			
			<div class="am-form-group" style="margin-top: 10px;" id="type1ly">
			  <label>商家 ></label>
			  <label class="am-checkbox-inline">
			    <input type="checkbox"  value="0" data-am-ucheck checked onclick="unselectAll(1);">不限</input>
			  </label>
			</div>
			
			<div class="am-form-group" style="margin-top: 10px;" id="type2ly">
			  <label>讲师 ></label>
			  <label class="am-checkbox-inline">
			    <input type="checkbox"  value="0" data-am-ucheck checked onclick="unselectAll(2);">不限</input>
			  </label>
			</div>
			
			<div class="am-form-group" style="margin-top: 10px;" id="type0ly">
			  <label>模式 ></label>
			  <label class="am-checkbox-inline">
			    <input type="checkbox"  value="0" data-am-ucheck checked onclick="unselectAll(0);">不限</input>
			  </label>
			</div>
			
			<!-- 各种列表 -->
			<div class="my_at">
				<font>1F <a>产品</a></font>
				<div class="am-topbar-right">
			        <a class="am-badge am-badge-primary am-radius">更多</a>
			    </div>
			</div>
			<div id="goods_ly" style="width:100%;  margin-left: auto;margin-right: auto;" align="center">
			    
			</div>		
			
			<div style="clear:both;"></div>
			
			<div class="my_at">
				<font>2F <a>商家</a></font>
				<div class="am-topbar-right">
			        <a class="am-badge am-badge-primary am-radius">更多</a>
			    </div>
			</div>
			<div id="supplies_ly" style="width:100%;  margin-left: auto;margin-right: auto;" align="center">
			    
			</div>		
			
			<div style="clear:both;"></div>
			
			<div class="my_at">
				<font>3F <a>讲师</a></font>
				<div class="am-topbar-right">
			        <a class="am-badge am-badge-primary am-radius">更多</a>
			    </div>
			</div>
			<div id="lecturer_ly" style="width:100%;  margin-left: auto;margin-right: auto;" align="center">
			</div>		
			
			<div style="clear:both;"></div>
			
			<div class="my_at">
				<font>4F <a>模式</a></font>
				<div class="am-topbar-right">
			        <a class="am-badge am-badge-primary am-radius">更多</a>
			    </div>
			</div>
			
			<div id="business_ly" style="width:100%;  margin-left: auto;margin-right: auto;" align="center">
			</div>		
			
			<div style="clear:both;"></div>
			
		</div>
		
		<iframe id="iframe2" src="<%=basePath%>boom.jsp" scrolling="no" style="height: 1000px;float: left;">
		</iframe>
	</div>
	
	<div style="clear: both;"></div>
	
	<div id="footer">
		<jsp:include page="footer.jsp" flush="true"/>
	</div>
	
<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
<script>
if(!IsPC()){
	window.location.href='index_m.jsp';
}
$("#footer > #links_ly").css("margin-left",($(document).width() - 980)/2);
$("#iframe1").css("width",($(document).width() - 980)/2);
$("#iframe2").css("width",($(document).width() - 980)/2);

	$(document).ready(function(){
		getGoods("");
		getSupplier("");
		getLecturer("");
		getBusiness("");
		getAllTypes();
	});
	
	function search(){
		//获取checkbox选中值
		
	}
	
	function unselectAll(type){
		$("#type"+type+"ly [value=0]").prop("checked",true);
		$("#type"+type+"ly :checkbox").each(function(){
			$(this).prop("checked",false);
		});
		checkLyChecked(type);
	}
	
	function getAllTypes(){
		$.ajax({
			type : 'POST',
			dataType : "json",
			contentType : "application/json ; charset=utf-8",
			url : "<%=basePath%>getAllTypeModel",
			success : function(result) {
				if (result.result == "ok") {
					$.each(result.data, function(n, value) {
						$("#type"+value.type+"ly").append("<label class='am-checkbox-inline'><input id='checkbox"+value.id+"' type='checkbox' value="+value.id+" data-am-ucheck>"+value.name+"</input></label>");
						$("#checkbox"+value.id).click(function(){
							checkLyChecked(value.type);
						});
					});
				}
			},
		});
	}
	
	function checkLyChecked(type){
		var uncheck = false;
		var selected = "";
		$("#type"+type+"ly :checkbox").each(function(){
			if($(this).val() != 0 && $(this).is(':checked') == true){
				selected += $(this).val() + ",";
				uncheck = true;
			}
		});
		$("#type"+type+"ly [value=0]").prop("checked",!uncheck); 
		
		if(type == 0){
			//模式
			getBusiness(selected);
		}
		
		if(type == 1){
			//商家
			getSupplier(selected);
		}
				
		if(type == 2){
			//讲师
			getLecturer(selected);
		}
		
		if(type == 3){
			//商品
			getGoods(selected);
		}
	}
	
	function getGoods(types){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			url : "<%=basePath%>getGoods",
			data : {"pageNum":1,"pageSize":8,"types":types,"keyword":"","type":0,"supplierid":0},
			success : function(result) {
				$.AMUI.progress.done();
				$("#goods_ly").empty();
				if (result.result == "ok") {
					$.each(result.data, function(n, value) {
						$("#goods_ly").append("<a target='_blank' href='<%=basePath%>goods/"+value.id+"'><div class='item'><img class='supplier_img' src='"+value.thum+"' alt='' /><font class='supplier_name'>"+value.name+"</font></div></a>");
					});
				}
			},
			dataType : "json"
		});
	}
	
	function getSupplier(types){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			url : "<%=basePath%>getSuppliers",
			data : {"pageNum":1,"pageSize":8,"types":types,"keyword":""},
			success : function(result) {
				$.AMUI.progress.done();
				$("#supplies_ly").empty();
				if (result.result == "ok") {
					$.each(result.data, function(n, value) {
						$("#supplies_ly").append("<a target='_blank' href='supplier.jsp?id="+value.id+"'><div class='item'><font class='supplier_name'>"+value.name+"</font><img class='supplier_img' src='"+value.thum+"' alt='' /></div></a>")
					});
				}
			},
			dataType : "json"
		});
	}
	
	function getLecturer(types){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			url : "<%=basePath%>getLecturers",
			data : {"pageNum":1,"pageSize":8,"types":types,"keyword":""},
			success : function(result) {
				$.AMUI.progress.done();
				$("#lecturer_ly").empty();
				if (result.result == "ok") {
					$.each(result.data, function(n, value) {
						var name = value.name.split('').join("<br/>");
						$("#lecturer_ly").append("<a href='lecturer.jsp?id="+value.id+"' target='_blank'><div class='item'><img class='lecturer_img' src='"+value.thum+"' alt='' /><font>"+name+"</font></div></a>")
					});
				}
			},
			dataType : "json"
		});
	}
	
	function getBusiness(types){
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			url : "<%=basePath%>getBusinessModels",
			data : {"pageNum":1,"pageSize":8,"types":types,"keyword":""},
			success : function(result) {
				$.AMUI.progress.done();
				$("#business_ly").empty();
				if (result.result == "ok") {
					$.each(result.data, function(n, value) {
						var name = value.name.split('').join("<br/>");
						$("#business_ly").append("<a target='_blank' href='business.jsp?id="+value.id+"'><div class='item'><img class='supplier_img' src='"+value.thum+"' alt='' /><font class='supplier_name'>"+value.name+"</font></div></a>")
					});
				}
			},
			dataType : "json"
		});
	}
	
	function IsPC() {
	    var userAgentInfo = navigator.userAgent;
	    var Agents = ["Android", "iPhone",
	                "SymbianOS", "Windows Phone",
	                "iPad", "iPod"];
	    var flag = true;
	    for (var v = 0; v < Agents.length; v++) {
	        if (userAgentInfo.indexOf(Agents[v]) > 0) {
	            flag = false;
	            break;
	        }
	    }
	    return flag;
	}
	
</script>
</body>
</html>