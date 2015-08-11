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
<title>产品列表</title>
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
	<div class="span12 box bordered-box red-border"
		style="margin-bottom: 0;margin-top: 20px;">
		<div class="box-header red-background">
			<div class="title" id="title">模式列表</div>
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
								<th>ID</th>
								<th style="overflow: hidden;">标题</th>
								<th width="220">最后更新时间</th>
								<th width="70"><div class="text-right">操作</div></th>
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
					<ul class="am-pagination" style="margin-left: 10px;">
						<li><a href="javascript:page(0);">&laquo;上一页</a></li>
						<li><a href="javascript:page(1);">下一页 &raquo;</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
<script src='<%=basePath%>resources/jquery-1.8.2.min.js'></script>
<script src="<%=basePath%>assets/amazeui/assets/js/amazeui.min.js"></script>
<script src="<%=basePath%>assets/javascripts/moment.js"></script>

<script type="text/javascript">

	var pageNum = 1;
	var hasData = false;
	$(document).ready(function() {
		moment.locale('zh-cn');
		getMyModels();
	});
	
	function editModel(id){
		window.location.href= 'BusinessInsertOrUpdate.jsp?id='+id;
	}
	
	function deleteModel(id){
		if(!confirm("确定要删除吗？")){return;}
		var path = "<%=basePath%>removeBusinessById";
		var data = {"id":id};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				if(result.result = "ok"){
					pageNum = 1;
					getMyModels();
				}else{
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}

	function getMyModels(){
		$.AMUI.progress.start();
		var path = "<%=basePath%>getBusinessModels";
		var data = {"pageNum":pageNum,"pageSize":20,"types":""};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				$("#list_content").empty();
				if(result.result == "ok"){
					hasData = true;
					$("#nodata").hide();
					$("#thread").show();
					$.each(result.data, function(n, value) {
						var update_time = moment(value.update_time.time).format("lll");
						$("#list_content").append("<tr><td>"+value.id+"</td><td>"+value.name+"</td><td>"+update_time+"</td><td><div class='text-right'><a class='btn btn-success btn-mini' href='javascript:editModel("+value.id+")'> <i class='icon-edit'></i></a> <a class='btn btn-danger btn-mini' href='javascript:deleteModel("+value.id+")'> <i class='icon-remove'></i></a></div></td></tr>");
					});
				}else{
					$("#nodata").show();
					$("#thread").hide();
					hasData = false;
				}
			},
			dataType : "json"
		});
	}
	
	function page(type){
		if(type == 0){
			//上一页
			if(pageNum == 1)return;
			pageNum--;
		}else{
			//下一页
			if(!hasData)
				return;
			pageNum++;
		}
		getMyModels();
	}
	
	function refresh(){
		getMyModels();
	}
	
</script>
</body>
</html>