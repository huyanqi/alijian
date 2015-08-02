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
<head lang="en">
  <meta charset="UTF-8">
  <title>注册到 阿里健 - 淘资源</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta name="format-detection" content="telephone=no">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link rel="stylesheet" href="font/amazeui/css/amazeui.min.css"/>
  <style>
    .header {
      text-align: center;
    }
    .header h1 {
      font-size: 200%;
      color: #333;
      margin-top: 30px;
    }
    .header p {
      font-size: 14px;
    }
  </style>
</head>
<body>
<div class="header">
  <div class="am-g">
    <h1>阿里健 - 淘资源</h1>
    <p>打造健康产业中的<br/>阿里巴巴</p>
  </div>
  <hr />
</div>
<div class="am-g">
  <div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
    <h3>请填写注册信息</h3>
    <hr>
    <br>

    <form id="myform" method="post" class="am-form" data-am-validator>
      <label for="email">账户:</label>
      <input type="text" id="username"  minlength="6" required >
      <br>
      <label for="password">密码:</label>
      <input type="password" id="password" minlength="6" required >
      <br>
      <label for="password">确认密码:</label>
      <input type="password" data-equal-to="#password" required >
      <br>
      <div class="am-cf">
        <input type="submit" value="提交" class="am-btn am-btn-primary am-btn-sm am-fl">
      </div>
    </form>
    <hr>
    <p>© 2015 <a href="#" target="_blank">阿里健 - 淘资源.</a> Powered by Frankie.</p>
  </div>
</div>

<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>

<script>

	$(function() {
		$('#myform').submit(function(evt) {
			if ($('form').data('amui.validator').isFormValid()){
				toSubmit();
				return false;
			}
		});
	});
	
	function toSubmit(){
		$.AMUI.progress.start();
		
		var username = $("#username").val();
		var password = $("#password").val();
		
		var data = '{"username":"'+username+'","password":"'+password+'"}';
		var path = "<%=basePath%>regUser";
		var data = data;
		$.ajax({
			type : 'POST',
			dataType : "json",
			contentType : "application/json ; charset=utf-8",
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					alert("恭喜你，已成功成为阿里健会员!");
					window.location.replace("login.jsp");
				} else {
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
</script>
</body>
</html>