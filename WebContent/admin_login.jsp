<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js">

<head>

<meta charset="utf-8">
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- CSS -->
<link rel='stylesheet' href='resources/login/css/login.css'>
<link rel="stylesheet" href="resources/login/css/reset.css">
<link rel="stylesheet" href="resources/login/css/supersized.css">
<link rel="stylesheet" href="resources/login/css/style.css">

<!-- Toast -->
<link rel="stylesheet" href="resources/toast/css/custom.css">
<link rel="stylesheet" href="resources/toast/css/iosOverlay.css">
<link rel="stylesheet" href="resources/toast/css/prettify.css">


<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
</head>

<body>

	<div class="page-container">
		<h1>Login</h1>
		<form action="" method="post" id="loginForm">
			<input type="text" name="username" class="username" id="username" placeholder="管理员账号" value="admin"> 
			<input type="password" name="password" class="password" id="password" placeholder="密码" value="password">
			<button type="submit">登&emsp;&emsp;录</button>
			<div class="error">
				<span>+</span>
			</div>
		</form>
		<div class="connect">
			<p>Powered by Frankie</p>
			<p>
				<!-- <a class="facebook" href=""></a> <a class="twitter" href=""></a> -->
			</p>
		</div>
	</div>

	<!-- Javascript -->
	<script src="resources/jquery-1.8.2.min.js"></script>
	<script src="resources/jquery-form.js"></script>
	<script src="resources/login/js/supersized.3.2.7.min.js"></script>
	<script src="resources/login/js/supersized-init.js"></script>
	<script src="resources/login/js/scripts.js"></script>
	
	<!-- toast -->
	<script src="resources/toast/js/modernizr-2.0.6.min.js"></script>
	<script src="resources/toast/js/iosOverlay.js"></script>
	<script src="resources/toast/js/spin.min.js"></script>
	<script src="resources/toast/js/prettify.js"></script>
	<script src="resources/toast/js/custom.js"></script>
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			// bind 'loginForm' and provide a simple callback function   
			$('#loginForm').ajaxForm(function() {
				var opts = {
						lines: 13, // The number of lines to draw
						length: 11, // The length of each line
						width: 5, // The line thickness
						radius: 17, // The radius of the inner circle
						corners: 1, // Corner roundness (0..1)
						rotate: 0, // The rotation offset
						color: '#FFF', // #rgb or #rrggbb
						speed: 1, // Rounds per second
						trail: 60, // Afterglow percentage
						shadow: false, // Whether to render a shadow
						hwaccel: false, // Whether to use hardware acceleration
						className: 'spinner', // The CSS class to assign to the spinner
						zIndex: 2e9, // The z-index (defaults to 2000000000)
						top: 'auto', // Top position relative to parent in px
						left: 'auto' // Left position relative to parent in px
					};
					var target = document.createElement("div");
					document.body.appendChild(target);
					var spinner = new Spinner(opts).spin(target);
					var overlay = iosOverlay({
						text: "Loading",
						spinner: spinner
					});
				
				var path = "<%=basePath%>admin_login";
				var data = {"username":$("#username").val(),"password":$("#password").val()};
				$.ajax({
					type : 'POST',
					data : data,
					url : path,
					success : function(result) {
						if(result.result == "ok"){
							overlay.update({
								icon: "resources/toast/img/check.png",
								text: "Success"
							});
							self.location="back/index.jsp";
						}else{
							overlay.update({
								text: "Error!",
								icon: "resources/toast/img/cross.png"
							});
							
							window.setTimeout(function() {
								overlay.hide();
							}, 2e3);
						}
					},
					dataType : "json"
				});
			});
		});
	</script>

</body>

</html>