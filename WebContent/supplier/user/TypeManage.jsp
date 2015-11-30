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
<title>分类管理</title>
<!-- base -->
<link
	href='<%=basePath%>assets/stylesheets/bootstrap/bootstrap.css'
	media='all' rel='stylesheet' type='text/css' />
<link
	href='<%=basePath%>assets/stylesheets/jquery_ui/jquery-ui-1.10.0.custom.css'
	media='all' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>assets/stylesheets/light-theme.css'
	id='color-settings-body-color' media='all' rel='stylesheet'
	type='text/css' />
<!-- ---- -->

<!-- amazeui -->
<link rel="stylesheet" href="<%=basePath%>assets/amazeui/assets/css/amazeui.min.css">

</head>
<body>
<button class="btn btn-danger" name="button" style="margin: 20px 20px;" onclick="window.location.href='TypeInsert.jsp?is_edit=0'">添加店铺分类</button>
	<br />
	<div class="span12 box bordered-box red-border"
		style="margin-bottom: 0;">
		<div class="box-header red-background">
			<div class="title">店铺分类列表</div>
			<div class="actions" >
                <a href="javascript:refresh()" class="btn box-remove btn-mini btn-link"><i class="icon-refresh"></i></a>
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
								<th>名称</th>
								<th><div class="text-right">操作</div></th>
							</tr>
						</thead>
						<thead id="nodata">
							<tr>
								<th colspan="2">无数据</th>
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
	var cookie = $.AMUI.utils.cookie;
	$(document).ready(function() {
		getTypeModelByType();
	});
	
	function pageHref(page){
		window.location.href = page;
	}
	
	function editModel(id){
		pageHref("TypeInsert.jsp?is_edit=1&id="+id);
	}
	
	function deleteModel(id){
		if(!confirm("确定要删除吗？")){return;}
		var path = "<%=basePath%>removeMyTypeById";
		var data = {"id":id};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				if(result.result = "ok"){
					getTypeModelByType();
				}else{
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}

	function getTypeModelByType(){
		$.AMUI.progress.start();
		var path = "<%=basePath%>getMyTypeByUid";
		var data = {"uid":cookie.get("uid")};
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
						$("#list_content").append("<tr><td>"+value.name+"</td><td><div class='text-right'><a class='btn btn-success btn-mini' href='javascript:editModel("+value.id+")'> <i class='icon-edit'></i></a> <a class='btn btn-danger btn-mini' href='javascript:deleteModel("+value.id+")'> <i class='icon-remove'></i></a></div></td></tr>");
					});
				}else{
					$("#nodata").show();
					$("#thread").hide();
				}
			},
			dataType : "json"
		});
	}
	
	function refresh(){
		getTypeModelByType();
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