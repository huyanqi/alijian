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
<title>添加友情链接</title>
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

<script src='<%=basePath%>resources/jquery-1.8.2.min.js'></script>

<!----- validate ----->
<script src='<%=basePath%>assets/javascripts/plugins/validate/jquery.validate.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/validate/additional-methods.js' type='text/javascript'></script>

<!-- / jquery ui -->
<script src='<%=basePath%>assets/javascripts/jquery_ui/jquery-ui.min.js' type='text/javascript'></script>
<link href='<%=basePath%>assets/stylesheets/plugins/xeditable/bootstrap-editable.css' media='all' rel='stylesheet' type='text/css' />
<script src='<%=basePath%>assets/javascripts/plugins/xeditable/wysihtml5.js' type='text/javascript'></script>
<!-- / fileinput -->
<script src='<%=basePath%>assets/javascripts/plugins/fileinput/bootstrap-fileinput.js' type='text/javascript'></script>
<!-- / datetime picker -->
<script src='<%=basePath%>assets/javascripts/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.js' type='text/javascript'></script>

<!-- / timeago -->
<script
	src='<%=basePath%>assets/javascripts/plugins/timeago/jquery.timeago.js'
	type='text/javascript'></script>
<!-- / autosize (for textareas) -->
<script
	src='<%=basePath%>assets/javascripts/plugins/autosize/jquery.autosize-min.js'
	type='text/javascript'></script>
<!-- / charCount -->
<script
	src='<%=basePath%>assets/javascripts/plugins/charCount/charCount.js'
	type='text/javascript'></script>
<!-- / max length -->
<script
	src='<%=basePath%>assets/javascripts/plugins/bootstrap_maxlength/bootstrap-maxlength.min.js'
	type='text/javascript'></script>
<!-- / flatty theme -->
<script src='<%=basePath%>assets/javascripts/theme.js' type='text/javascript'></script>
<script src='<%=basePath%>resources/jquery.form.min.js' type='text/javascript'></script>
<!----- --------- ----->

<script type="text/javascript">
	var is_edit = getUrlParam("is_edit");//0:添加 1:编辑
	var id = getUrlParam("id");
	$(document).ready(function() {
		if(is_edit == 0){
			$("#title").html("添加友情链接");
		}else{
			$("#title").html("编辑友情链接");
			getLinkById();
		}
		
		$("#myform").validate({
				submitHandler : function(form) {
					formSubmit();
				}
			});
	});
	
	function getLinkById(){
		var path = "<%=basePath%>getLinkById";
		var data = {"id":id};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				if (result.result == "ok") {
					$("#name").val(result.data.name);
					$("#url").val(result.data.url);
				} else {
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
	
	function formSubmit(){
		var path = "<%=basePath%>link_insert";
		var data = JSON.stringify({id:id,name:$("#name").val(),url:$("#url").val()});
		$.ajax({
			type : 'POST',
			dataType : "json",
			contentType : "application/json ; charset=utf-8",
			data : data,
			url : path,
			success : function(result) {
				if (result.result == "ok") {
					window.history.back();
				} else {
					alert(result.data);
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
</head>
<body>

	<div class="row-fluid">
		<div class="span12 box">
			<div class="box-header red-background">
				<div class="title">
					<div class="icon-expand-alt"></div>
					<font id="title"></font>
				</div>
			</div>
			<div class="box-content">
				<form id="myform" class="form form-horizontal" style="margin-bottom: 0;" >
					<div class="control-group">
						<label class="control-label" for="validation_name">链接名称</label>
						<div class="controls">
							<input data-rule-minlength="2" required id="name" placeholder="Name" type="text">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="validation_name">链接地址</label>
						<div class="controls">
							<input required id="url" placeholder="必须带http://" type="text">
						</div>
					</div>
					<div class="form-actions" style="margin-bottom: 0">
						<button class="btn btn-danger" type="submit" id="submit">
							<i class="icon-save"></i> 提交
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>