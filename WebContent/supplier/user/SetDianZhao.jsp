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
<title>设置店招</title>
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
            <div class="title">已有店招</div>
            <div class="actions">
                <a href="javascript:refresh()" class="btn box-remove btn-mini btn-link"><i class="icon-refresh"></i></a>
                <Button href="#" class="btn btn-mini btn-link"></Button>
            </div>
        </div>
        
        <input accept="image/jpeg" type="file" name="upload" id="fileupload_input" style="visibility: hidden;"/>
        <button class="btn btn-success" name="button" style="margin-bottom:5px" type="submit" onclick="$('#fileupload_input').trigger('click');">添加店招(最大高度:150px)</button>
        
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
								店招图片
                            </th>
                            <th>
								操作
                            </th>
                        </tr>
                        </thead>
                        <thead id="nodata">
							<tr>
								<th colspan="2">还没有设置店招</th>
							</tr>
						</thead>
                        <tbody id="list_content">
                        
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src='<%=basePath%>resources/jquery-1.8.2.min.js'></script>
<script src="<%=basePath%>assets/amazeui/assets/js/amazeui.min.js"></script>
<script src="<%=basePath%>assets/javascripts/moment.js"></script>

<script src="<%=basePath%>assets/javascripts/jquery_ui/jquery-ui.min.js"></script>
<script src="<%=basePath%>assets/javascripts/fileupload/jquery.iframe-transport.js"></script>
<script src="<%=basePath%>assets/javascripts/fileupload/jquery.fileupload.js"></script>

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
		
		$("#fileupload_input").fileupload({
		    url:"<%=basePath%>fileupload",//文件上传地址，当然也可以直接写在input的data-url属性内
		    //formData:{"name":"p1","age":2},//如果需要额外添加参数可以在这里添加
		    done:function(e,result){
		        //done方法就是上传完毕的回调函数，其他回调函数可以自行查看api
		        //注意result要和jquery的ajax的data参数区分，这个对象包含了整个请求信息
		        //返回的数据在result.result中，假设我们服务器返回了一个json对象
		        var obj = eval('(' + result.result + ')');
		        if(obj.result == "ok"){
		        	var imgpath = obj.data;
		        	$.AMUI.progress.start();
		    		var path = "<%=basePath%>setdianzhao";
		    		var data = {"path":imgpath};
		    		$.ajax({
		    			type : 'POST',
		    			data : data,
		    			url : path,
		    			success : function(result) {
		    				$.AMUI.progress.done();
		    				if(result.result == "ok"){
		    					getData();
		    				}else{
		    					alert(result.data);
		    				}
		    			},
		    			dataType : "json"
		    		});
		        }else{
		        	alert(obj.data);
		        }
		    }
		});
		
		getData();
	});
	
	function getData(){
		$.AMUI.progress.start();
		var path = "<%=basePath%>getMine";
		$.ajax({
			type : 'POST',
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				$("#list_content").empty();
				if(result.result == "ok"){
					hasData = true;
					$("#nodata").hide();
					$("#thread").show();
					if(result.data.dianzhao != null && result.data.dianzhao != ""){
						$.each(result.data.dianzhao.split(","), function(n, value) {
							$("#list_content").append("<tr><td>"+(n+1)+"</td><td class='content_class' style='white-space: normal;'><img style='max-height:100px;' src='<%=basePath%>"+value+"'/></td><td><a href='javascript:removeDZ("+n+");'>删除</a></td></tr>");
						});
					}
					if(pageNum == 1){
						$("#pageselect").empty();
						for(var i=0;i<result.pageCount;i++){
							$("#pageselect").append("<option value="+(i+1)+">"+(i+1)+"/"+result.pageCount+"</option>");
						}
					}
				}else{
					alert(result.data);
					$("#nodata").show();
					$("#thread").hide();
					hasData = false;
				}
			},
			dataType : "json"
		});
	}
	
	function removeDZ(index){
		$.AMUI.progress.start();
		var path = "<%=basePath%>removeDZ";
		$.ajax({
			type : 'POST',
			url : path,
			data : {"index":index}, 
			success : function(result) {
				$.AMUI.progress.done();
				if(result.result == "ok"){
					getData();
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