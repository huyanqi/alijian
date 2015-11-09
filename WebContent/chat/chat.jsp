<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>阿里健 - IM聊天系统</title>
<link rel="stylesheet" href="<%=basePath%>font/amazeui/css/amazeui.min.css" />
<style type="text/css">
#content {
	width: 100%;
	top: 49px;
	bottom: 0px;
}
ul{
	margin: 0;
	list-style: none;
	overflow:auto;
	padding: 0;
}
.im_left{
	background: #D9EDF7;
	width:auto;
	display: table;
	padding: 10px;
	min-width: 50%;
	margin-bottom: 10px;
}
.user_name{
	background: #F7F7F9;
	color: red;
	width: auto;
	display: table;
	padding: 5px;
}
.im_right{
	background: #00BCD4;
	width:auto;
	display: table;
	padding: 10px;
	min-width: 50%;
	margin-bottom: 10px;
	float: right;
}
.im_right .user_name{
	float: right;
}
.user_list_ly li a{
	padding: 10px;
	color: red;
	display: block;
}

.user_list_ly li a:ACTIVE{
	background: #B2EBF2;
}

.active{
	background: #B2EBF2;
}
</style>
</head>
<body>

	<header data-am-widget="header" class="am-header am-header-default am-header-fixed" style="background: #F5F5F5;">

	<h1 class="am-header-title" id="header" style="color: #5ab963;">
		<img src="<%=basePath%>font/logo.png" style="max-width: 50px;max-height: 50px;" />
		阿里健IM
	</h1>

	</header>

	<div id="content">
		<div class="left" style="width: 30%; height: 100%;float: left;padding: 10px;">
		
			<div style="background: #03A9F4;padding: 10px;color: white;">聊天列表</div>
			<div style="width: 100%;height: 100%;border-left: solid 1px gray;border-bottom: solid 1px gray;border-right: solid 1px gray;">
				<ul id="user_list_ly" class="user_list_ly">
					
				</ul>
			</div>
		
		</div>
		<div class="right" style="width: 70%; height: 100%;float: left;padding: 10px;padding-left: 0;">

			<div style="background: #03A9F4;padding: 10px;color: white;" id="content_title">聊天窗口</div>
			<div style="width: 100%;height: 100%;border-left: solid 1px gray;border-bottom: solid 1px gray;border-right: solid 1px gray;">

				<!-- 展示聊天内容的区域 -->
				<ul id="show_ly" style="width: 100%;height: 70%;padding: 10px;padding-bottom: 10px;">
					
				</ul>
				
				<!-- 附加内容的区域 -->
				<div style="width: 100%;height: 10%;border-top: solid 1px #F8F8F8;">
					<span>表情框</span>
					<span>各种框</span> 
					<span style="position: absolute; right: 20px;">
						<button type="button" onclick="sendText()">发送</button>
					</span>
				</div>
				
				<!-- 文本输入框的区域 -->
				<div id="edit_text_ly" style="width: 100%;height: 20%;">
					<pre id="im_send_content" style="height: 100%;margin: 0;" contenteditable="true"></pre>
				</div>

			</div>

		</div>
	</div>

	<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
	<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
	<script src="http://res.websdk.rongcloud.cn/RongIMClient-0.9.13.min.js"></script>
	<script src="<%=basePath%>chat/chat.js"></script>
	<script type="text/javascript">
	
	var server = "<%=basePath%>";
	
	initHeight();
	
	function initHeight(){
		var screenHeight = $(window).height();
		var headerHeight = $("#header").height();
		$("#content").height(screenHeight - headerHeight - 40);
	}
	
	</script>

</body>
</html>