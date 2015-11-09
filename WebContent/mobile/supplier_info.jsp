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
.top_ul {
	list-style: none;
	padding-left: 0;
	margin-left: 0;
	margin: 10px;
}

.table_left {
	color: #9D9D9D;
	padding-right: 20px;
}
</style>

</head>
<body class="am-with-topbar-fixed-top">

	<jsp:include page="head_m.jsp" flush="true" />

	<div data-am-widget="tabs" class="am-tabs am-tabs-default am-no-layout" style="margin: 0; background: #F5F5F5;">
		<ul class="am-tabs-nav am-cf">
			<li class="am-active"><a href="[data-tab-panel-0]"
				style="text-align: center;">基本信息</a></li>
			<li class=""><a href="[data-tab-panel-1]"
				style="text-align: center;">联系方式</a></li>
		</ul>
		<div class="am-tabs-bd"
			style="touch-action: pan-y; -webkit-user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
			<div data-tab-panel-0="" class="am-tab-panel am-active am-in">
				<table>
					<tr>
						<td class="table_left">公司名称:</td>
						<td id="gsmc"></td>
					</tr>
					<tr>
						<td class="table_left">公司地址:</td>
						<td id="gsdz"></td>
					</tr>
					<tr>
						<td class="table_left">经营模式:</td>
						<td id="jyms"></td>
					</tr>
					<tr>
						<td class="table_left">品牌名称:</td>
						<td id="ppmc"></td>
					</tr>
					<tr>
						<td class="table_left">年营业额:</td>
						<td id="nyye"></td>
					</tr>
					<tr>
						<td class="table_left">销售区域:</td>
						<td id="xsqy"></td>
					</tr>
					<tr>
						<td class="table_left">客户群体:</td>
						<td id="khqy"></td>
					</tr>
					<tr>
						<td class="table_left">注册地:</td>
						<td id="zcd"></td>
					</tr>
					<tr>
						<td class="table_left">法定代表:</td>
						<td id="fddb"></td>
					</tr>
					<tr>
						<td class="table_left">员工人数:</td>
						<td id="ygrs"></td>
					</tr>
					<tr>
						<td class="table_left">主营产品:</td>
						<td id="zycp"></td>
					</tr>
				</table>
				
				<div style="background: white;margin-top: 10px;border: solid 1px #D3D3D3;padding: 10px;">
					<font id="description"></font>
				</div>
			</div>
			<div data-tab-panel-1="" class="am-tab-panel">
				<table>
					<tr>
						<td class="table_left">联&nbsp;&nbsp;系&nbsp;&nbsp;人:</td>
						<td id="lxr"></td>
					</tr>
					<tr>
						<td class="table_left">电&emsp;&emsp;话:</td>
						<td><a id="lxrdh"></a></td>
					</tr>
					<tr>
						<td class="table_left">移动电话:</td>
						<td><a id="lxrsj"></a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>

	<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
	<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
	<script>
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
								$("#gsmc").html(result.name);
								$("#gsdz").html(result.address);
								$("#jyms").html(result.jyms);
								$("#ppmc").html(result.ppmc);
								$("#nyye").html(result.nyye);
								$("#xsqy").html(result.xsqy);
								$("#khqy").html(result.khqy);
								$("#zcd").html(result.zcd);
								$("#fddb").html(result.fddb);
								$("#ygrs").html(result.ygrs);
								$("#zycp").html(result.zycp);
								$("#lxr").html(result.contact_name);
								$("#lxrdh").html(result.contact_tel);
								$("#lxrdh").attr("href",
										"tel:" + result.contact_tel);
								$("#lxrsj").html(result.mobile);
								$("#lxrsj")
										.attr("href", "tel:" + result.mobile);

								$("#description").html(result.description);
								$("#description img").css("height", "").css(
										"width", "100%");
								
							} else {
								alert("错误的商家ID号");
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