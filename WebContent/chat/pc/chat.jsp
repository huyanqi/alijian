<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.5, user-scalable=yes"/>
<title>阿里健 - IM聊天</title>
<style>
	body {
		margin: 0;
		padding: 0;
	}
</style>
</head>
<body id="im_body1" style="overflow-x: hidden; overflow-y: auto; height: 500px;" onkeydown="IM.EV_keyCode(event)">
	<div id="im_body" style="overflow: hidden;">
		<div id="navbar" style="width: 100%;background: #0044CC;height: 70px;line-height: 70px;">
			<audio id="im_ring" src="js/ring.mp3"></audio>
			<font color="white" style="font-size: 25px;margin-left: 20px;">阿里健 - IM</font>
			<div id="navbar_login_show" style="height: auto; ">
	            <a imtype="navbar_login_show" class="brand" style="color: #eeeeee;" href="#">您好</a>
	            <a class="brand" href="#" style="color: #eeeeee;" onclick="IM.EV_logout()">退出</a>
            </div>
            <div style="clear: both;"/>
		</div>
		<div style="width: 100%;height: 200px;background: #04aeda;">
			<div style="width: 30%;height: 100%;background: red;float: left;">
				
			</div>
			<div style="width: 70%;height: 100%;background: gray;float: left;">
				
			</div>
		</div>
		<div style="clear: both;"/>
	</div>
</body>
</html>