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
#container{
	margin: 10px 10px 10px 10px;
}
a{
	size: 12px;
}
#keys_ly>a{
	padding: 10px;
	display:inline-block;
	border: 1px solid #E8E8E8;
	background: white;
}
#am-list li:first-child {
	border-top: 0px;
}
#am-list a{
	color: black;
}
</style>

</head>
<body>

<jsp:include page="head_m.jsp" flush="true" />

<div id="container" style="display: inline-block;width: 100%;height: 39px;">
	
	<div class="am-form-group am-form-select" style="float: left;">
		<select name="select-native-3" id="type_selector" style="height: 39px;border: 0px;border: 1px solid #E6E6E6;background: transparent;">
			<option value="3">产品</option>
			<option value="1">厂家</option>
			<option value="2">讲师</option>
			<option value="0">模式</option>
		</select>
	</div>
	
	<input type="text" id="keyword_et" class="am-form-field" placeholder="关键字" style="float: left;width: 60%;border-color: #E6E6E6;border-left: 0px;"/>
	
	<button type="button" onclick="search('');" class="am-btn am-btn-default" style="float: left;height: 39px;background: transparent;color: black;border: 0px;">搜索</button>
	
</div>
<div style="width: 100%;background: #F1F1F1;display: inline-block;padding: 10px;">

	<div>
		<a style="color: #8F8F8F;float: left;">大家都在搜</a>
		
		<div style="float: right;"><i class="am-icon-refresh"></i><a style="color: #8F8F8F;margin-left: 5px;">换一组</a></div>
	</div>
	<div style="clear: both;"></div>
	<div id="keys_ly" style="margin-top: 10px;">
		
	</div>
	<a style="color: #8F8F8F;margin-top: 10px;display: inline-block;">搜索历史</a>

</div>

<div data-am-widget="list_news" class="am-list-news am-list-news-default">
	<div class="am-list-news-bd">
		<ul id="am-list" class="am-list">
		</ul>
	</div>

</div>

	<script type="text/javascript">
		var type = 3;//默认是产品
		$(document).ready(function() {

			$('#type_selector').change(function() {
				type = $("#type_selector").val()
			});
			
			getHistory();
			getKeywords();
		});
		
		function getHistory(){
			var history = $.AMUI.utils.cookie.get("history");
			if(history == null) return;
			var histories = history.split(",");
			$('#am-list').empty();
			for(var i=histories.length-1;i>-1;i--){
				var h = histories[i];
				if(h == null || h == "") continue;
				$('#am-list').append('<li class="am-g am-list-item-dated" onclick=search("'+h+'");><a class="am-list-item-hd">'+h+'</a></li>');
			}
		}
		
		function search(keyword){
			if(keyword == ""){
				keyword = $("#keyword_et").val();
			}
			if(keyword == null || keyword == "") return;
			var history = $.AMUI.utils.cookie.get("history");
			if(history == null){
				history = "";
			}else{
			}
			history += keyword+",";
			var tempArray = [];
			var hissp = history.split(",").length;
			for(var i=0;i<hissp;i++){
				var his = history.split(",")[i];
				if(his == null || his == "" || tempArray.indexOf(his) != -1){
					continue;
				}
				tempArray.push(his);
			}
			history = "";
			for(var i=0;i<tempArray.length;i++){
				history += tempArray[i]+",";
			}
			if(history.length > 0) history.substring(0,history.length-1);
			$.AMUI.utils.cookie.set("history", history, Infinity);
			getHistory();
			searchData(keyword);
		}
		
		var pageNum = 1;
		function getKeywords(){
			$.AMUI.progress.start();
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : "<%=basePath%>getKeyWords",
				data : {"pageNum":pageNum},
				success : function(result) {
					$.AMUI.progress.done();
					$("#keys_ly").empty();
					if(result.result == "ok"){
						$.each(result.data, function(n, value) {
							$("#keys_ly").append('<a href=javascript:search("'+value.name+'");>'+value.name+'</a>');
						});
					}else{
						//没有数据
						if(pageNum != 1){
							pageNum = 1;
							getKeywords();
						}
					}
				}
			});
		}
		
		function searchData(keywords){
			window.open("search_result.jsp?type="+type+"&keyword="+escape(keywords));
		}
	</script>

</body>
</html>