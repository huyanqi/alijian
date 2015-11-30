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
<title>收到的留言列表</title>
<!-- base -->
<link href='<%=basePath%>assets/stylesheets/bootstrap/bootstrap.css' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>assets/stylesheets/jquery_ui/jquery-ui-1.10.0.custom.css' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>assets/stylesheets/light-theme.css' id='color-settings-body-color' media='all' rel='stylesheet' type='text/css' />
<!-- ---- -->

<!-- amazeui -->
<link rel="stylesheet" href="<%=basePath%>assets/amazeui/assets/css/amazeui.min.css">
<style>
.content_class{
	
}
</style>
</head>
<body>

<div class="row-fluid">
    <div class="span12 box bordered-box red-border" style="margin-bottom:0;">
        <div class="box-header red-background">
            <div class="title">收到的留言列表</div>
            <div class="actions">
                <a href="javascript:refresh()" class="btn box-remove btn-mini btn-link"><i class="icon-refresh"></i></a>
                <Button href="#" class="btn btn-mini btn-link"></Button>
            </div>
        </div>
        <div class="box-content box-no-padding">
            <div class="responsive-table">
                <div class="scrollable-area">
                    <table class="table table-hover table-striped" style="margin-bottom:0;">
                        <thead>
                        <tr>
                            <th>
                                ID
                            </th>
                            <th>
								内容
                            </th>
                            <th>
								用户
                            </th>
                            <th>
								时间
                            </th>
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
						<li>
							<select style="width: 100px;" id="pageselect">
							</select>
						</li>
						<li><a href="javascript:page(1);">下一页 &raquo;</a></li>
					</ul>
                </div>
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
		//分页选择监听
		$('#pageselect').change(function(){ 
			pageNum = $("#pageselect").val();
			getData();
		});
		getData();
	});
	
	function getData(){
		$.AMUI.progress.start();
		var path = "<%=basePath%>getMyComments";
		var data = {"pageNum":pageNum};
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
						var name = "游客";
						if(value.userModel != null) name = value.userModel.name;
						$("#list_content").append("<tr><td>"+value.id+"</td><td class='content_class' style='white-space: normal;'>"+value.content+"</td><td>"+name+"</td><td>"+update_time+"</td></tr>");
					});
					if(pageNum == 1){
						$("#pageselect").empty();
						for(var i=0;i<result.pageCount;i++){
							$("#pageselect").append("<option value="+(i+1)+">"+(i+1)+"/"+result.pageCount+"</option>");
						}
					}
				}else{
					alert(result.models);
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
		getMyGoods();
	}
	
	function refresh(){
		getMyGoods();
	}
	
</script>
</body>
</html>