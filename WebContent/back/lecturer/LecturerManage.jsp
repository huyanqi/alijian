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
<title>讲师管理页</title>
<!-- base -->
<link href='<%=basePath%>assets/stylesheets/bootstrap/bootstrap.css' media='all' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>assets/stylesheets/jquery_ui/jquery-ui-1.10.0.custom.css' media='all' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>assets/stylesheets/light-theme.css' id='color-settings-body-color' media='all' rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="<%=basePath%>assets/amazeui/assets/css/amazeui.min.css">
<!-- ---- -->


</head>
<body>
<button class="btn btn-danger" name="button" style="margin: 20px 20px;" onclick="window.location.href = 'LecurerInsertOrUpdate.jsp' ">添加讲师</button>
<br />
<div class="span12 box bordered-box red-border"
	style="margin-bottom: 0;">
	<div class="box-header red-background">
		<div class="title">讲师列表</div>
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
							<th>名字</th>
							<th>领域</th>
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
		refresh();
	});
	
	function preview(thum){
		alert(thum);
	}
	
	function editModel(id){
		window.location.href = "LecurerInsertOrUpdate.jsp?id="+id;
	}
	
	function deleteModel(id){
		if(!confirm("确定要删除该讲师信息吗？")){return;}
		var path = "<%=basePath%>removeLecturerById";
		var data = {"id":id};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				if(result.result = "ok"){
					refresh();
				}else{
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
	
	function refresh(){
		$.AMUI.progress.start();
		var path = "<%=basePath%>getAllLecturers";
		$.ajax({
			type : 'POST',
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				$("#list_content").empty();
				if(result.result == "ok"){
					$("#nodata").hide();
					$("#thread").show();
					$.each(result.data, function(n, value) {
						var types = "";
						$.each(value.typeModels, function(n, value) {
							types += value.name+" ";
						});
						$("#list_content").append("<tr><td>"+value.name+"</td><td>"+ types +"</td><td><div class='text-right'><a class='btn btn-success btn-mini' href='javascript:editModel("+value.id+")'> <i class='icon-edit'></i></a> <a class='btn btn-danger btn-mini' href='javascript:deleteModel("+value.id+")'> <i class='icon-remove'></i></a></div></td></tr>");
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