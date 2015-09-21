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
<title>阿里健 - 求购信息</title>
<link rel="stylesheet" href="<%=basePath%>font/iscroll/pullToRefresh.css"/>
</head>
<body>
<jsp:include page="head_m.jsp" flush="true" />
<div id="wrapper" class="am-list-news">
	<ul id="result_ly">
		<li>
			<div style="width: 100%;padding: 10px;display: inline-block;">
				<button onclick="javascript:window.location.href='buy_insert.jsp'" type="button" class="am-btn am-btn-secondary am-radius" style="float: right;">发布求购信息</button>
			</div>
		</li>
	</ul>
</div>

<script src="<%=basePath%>font/iscroll/iscroll.js"></script>
<script src="<%=basePath%>font/iscroll/pullToRefresh.js"></script>
<script>
initScroll();

var pageNum = 1;
$(document).ready(function(){
	getData();
});

function initScroll(){
	$("#wrapper").css("height",$(document).height());
	
	refresher.init({
		id:"wrapper",
		pullDownAction:Refresh,
		pullUpAction:Load
	});
}

function Refresh(){
	pageNum = 1;
	getData();
}

function Load(){
	pageNum ++;
	getData();
}

function removeChild(){
	$("#result_ly").children().each(function(i,n){
		if(i > 0){
		     var obj = $(n);
		     obj.remove();
		}
    });
}

function getData(){
	$.AMUI.progress.start();
	$.ajax({
		type : 'POST',
		data : {"pageNum":pageNum},
		url : "<%=basePath%>getBuyModels",
		success : function(result) {
			$.AMUI.progress.done();
			if(pageNum == 1){
				removeChild();
			}
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					var url = "";
					$('#result_ly').append("<li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left'><div class=' am-u-sm-8 am-list-main'><h3 class='am-list-item-hd'><a target='_blank' class='title_name' >"+value.name+"</a></h3><div class='am-list-item-text base_info' style='color:red;'>"+"联系人:"+value.user_name+" 电话:"+value.user_mobile+"</div></div></li>");
				});
			} else {
				alert("没有更多数据");
			}
			myScroll.refresh();
		},
		dataType : "json"
	});
}

</script>
</body>
</html>