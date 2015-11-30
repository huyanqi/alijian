<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html lang="zh">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
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
.emotion{
	background:url("<%=basePath%>font/emoji/icon.gif") no-repeat 2px 2px;
    width: 42px;
    height: 20px;
    padding-left: 20px;
    cursor: pointer;
    background-position: 2px -28px;
    line-height: 28px;
}
#facebox{
	background: #DCE6F4;
	border: solid 1px #DCE6F5;
}
</style>
</head>
<body>
<span><audio id="im_ring" src="ring.mp3"></audio></span>
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
				<ul id="user_list_ly" class="user_list_ly" style="height: 100%;">
					
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
					<span>
						<div class="com_form" >
					     	<span class="emotion">表情</span>&emsp;&emsp;
					     	<span style="display: none;"><input accept="image/jpeg" type="file" name="upload" id="fileupload_input"/></span>
					     	<span><img src="<%=basePath%>font/emoji/gallery.png"/><a href="javascript:selectImg();" style="margin-left: 3px;color: black;">图片</a></span>
				     	</div>
					</span>
					<span style="position: absolute; right: 20px;">
						<button type="button" id="sendBtn" onclick="sendText()">发送(Ctrl+Enter)</button>
					</span>
				</div>
				
				<!-- 文本输入框的区域 -->
				<div id="edit_text_ly" style="width: 100%;height: 20%;">
					<textarea id="im_send_content" style="height: 100%;margin: 0;width: 100%;display: table;"></textarea>
				</div>
				
			</div>

		</div>
	</div>

	<%-- <script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script> --%>
	<script type="text/javascript" src="<%=basePath%>font/emoji/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>font/emoji/jquery.qqFace.js"></script>
	<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
	<script src="http://res.websdk.rongcloud.cn/RongIMClient-0.9.13.min.js"></script>
	<script src="<%=basePath%>chat/chat.js"></script>
	<script type="text/javascript" src="<%=basePath%>font/emoji/jquery.qqFace.js"></script>
	
	<script src="<%=basePath%>assets/javascripts/jquery_ui/jquery-ui.min.js"></script>
	<script src="<%=basePath%>assets/javascripts/fileupload/jquery.iframe-transport.js"></script>
	<script src="<%=basePath%>assets/javascripts/fileupload/jquery.fileupload.js"></script>
	
	<script src="<%=basePath%>assets/underscore/underscore-min.js"></script>
	<script src="<%=basePath%>assets/javascripts/moment.js"></script>
	
	
	<script type="text/javascript">
	var server = "<%=basePath%>";
	initHeight();
	
	$(function(){
		$('.emotion').qqFace({
			id : 'facebox', //表情盒子的ID
			assign:'im_send_content', //给那个控件赋值
			path:'<%=basePath%>font/emoji/face/'	//表情存放的路径
		});
		
		$('#im_send_content').bind('keydown', function(event) {
	        if (event.ctrlKey && event.keyCode == 13) {
	            //回车执行查询
	            $('#sendBtn').click();
	        }
	    });
		
		moment.locale('zh-cn');
		
	});
	
	function initHeight(){
		var screenHeight = $(window).height();
		var headerHeight = $("#header").height();
		$("#content").height(screenHeight - headerHeight - 40);
	}
	
	function selectImg(){
		$('#fileupload_input').trigger('click');
	}
	
	</script>

</body>
</html>