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
<title>供货商 - 待审核</title>
<!-- base -->
<link href='<%=basePath%>assets/stylesheets/bootstrap/bootstrap.css' media='all' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>assets/stylesheets/jquery_ui/jquery-ui-1.10.0.custom.css' media='all' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>assets/stylesheets/light-theme.css' id='color-settings-body-color' media='all' rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="<%=basePath%>assets/amazeui/assets/css/amazeui.min.css">
<!-- ---- -->
<!-- <a href=\"javascript:preview('"+value.thum+ "')\"><img width='30' height='25' src="+value.thum+" /></a> -->

</head>
<body>

<div class="span12 box bordered-box red-border"
	style="margin-bottom: 0;margin-top: 20px;">
	<div class="box-header red-background">
		<div class="title">待审核供货商列表</div>
		<div class="actions" >
               <a href="javascript:getAllUser()" class="btn box-remove btn-mini btn-link"><i class="icon-refresh"></i></a>
               <Button href="#" class="btn btn-mini btn-link"></Button>
           </div>
	</div>
	<div class="box-content box-no-padding">
		<div class="table table-striped" style="margin-bottom:0;">
			<div class="scrollable-area">
				<table class="table table-hover table-striped"
					style="margin-bottom: 0;">
					<thead id="thread">
						<tr>
							<th>企业名称</th>
							<th>联系人电话</th>
							<th>地址</th>
							<th><div class="text-right">操作</div></th>
						</tr>
					</thead>
					<thead id="nodata">
						<tr>
							<th colspan="3">无数据</th>
						</tr>
					</thead>
					<tbody id="list_content">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script src='<%=basePath%>resources/jquery-1.8.2.min.js'></script>
<script src="<%=basePath%>assets/amazeui/assets/js/amazeui.min.js"></script> 

<script type="text/javascript">
	$(document).ready(function() {
		getAllUser();
	});
	
	function pass(uid){
		if(!confirm("确定执行此操作?")){return;}
		$.AMUI.progress.start();
		var path = "<%=basePath%>supplierPass";
		var data = {"uid":uid};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				if(result.result = "ok"){
					getAllUser();
				}else{
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
	
	function getAllUser(){
		$.AMUI.progress.start();
		var path = "<%=basePath%>getAllUser";
		var data = {"type":1,"status":0};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				$("#list_content").empty();
				if(result.result == "ok"){
					$("#nodata").hide();
					$("#thread").show();
					$.each(result.data, function(n, value) {
						$("#list_content").append("<tr><td>"+value.name+"</td><td>"+value.mobile+"</td><td>"+value.address+"</td><td><div class='text-right'><a class='btn btn-success btn-mini' href='javascript:pass("+value.id+")'> <i class='icon-ok'></i></a></div></td></tr>");
					});
				}else{
					$("#nodata").show();
					$("#thread").hide();
				}
			},
			dataType : "json"
		});
	}
	
</script>
</body>
</html>