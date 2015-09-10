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
  <title>入驻到 阿里健 - 淘资源</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"></meta>
  <meta name="format-detection" content="telephone=no"></meta>
  <meta name="renderer" content="webkit"></meta>
  <meta http-equiv="Cache-Control" content="no-siteapp" ></meta>
  <link rel="stylesheet" href="<%=basePath%>font/amazeui/css/amazeui.min.css"></link>
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
    <h3>请填写入驻信息</h3>
    <hr>
    <br>

    <form method="post" class="am-form" id="myform" data-am-validator>
      <label for="email">企业名称:</label>
      <input type="text" id="name" value="" required>
      <br>
      <label for="email">地址:</label>
      <input type="text" id="address" value="" required>
      <br>
      <label for="email">所属领域(按住ctrl可多选):</label>
      <div class="controls">
          <select id="inputSelectMulti" multiple="multiple">
          </select>
      </div>
      <br>
      <label for="email">联系人电话:</label>
      <input type="text" id="mobile" value="" class="js-pattern-mobile" placeholder="声音甜美的阿里健工作人员将会与您联系" required>
      <br>
      <label for="email">登录账号:</label>
      <input type="text" id="username" minlength="6" required />
      <br>
      <label for="password">登录密码:</label>
      <input type="password" id="password" minlength="6" required />
      <br>
      <label for="password">确认密码:</label>
      <input type="password" id="doc-vld-pwd-2" minlength="6" placeholder="请与上面输入的值一致" data-equal-to="#password" required />
      <br>
      <div class="am-cf">
        <input type="submit" name="" value="提交" class="am-btn am-btn-primary am-btn-sm am-fl"/>
      </div>
    </form>
    <hr>
    <p>© 2015 <a href="#" target="_blank">阿里健 - 淘资源.</a> Powered by Frankie.</p>
  </div>
</div>

<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>

<script>
	if ($.AMUI && $.AMUI.validator) {
	    $.AMUI.validator.patterns.mobile = /^\s*1\d{10}\s*$/;
	}
	
	$(function() {
		$('#myform').submit(function(evt) {
			if ($('form').data('amui.validator').isFormValid()){
				toSubmit();
				return false;
			}
		});
		getTypeModelByType();
	});
	
	function toSubmit(){
		$.AMUI.progress.start();
		
		var name = $("#name").val();
		var address = $("#address").val();
		var mobile = $("#mobile").val();
		var username = $("#username").val();
		var password = $("#password").val();
		var group_list = "";
		$('#inputSelectMulti option:selected').each(function(){
			group_list += $(this).val()+",";
		});
		
		var data = JSON.stringify({username:username,password:password,name:name,address:address,mobile:mobile,type:1,types:group_list});
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
					alert("入驻信息提交成功，稍后会有工作人员与您联系，请保持电话畅通，感谢您对阿里健的关注。");
					window.location.replace("login.jsp");
				} else {
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
	
	function getTypeModelByType(){
		$.AMUI.progress.start();
		var path = "<%=basePath%>getTypeModelByType";
		var data = {"type":1};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				if(result.result == "ok"){
					$("#inputSelectMulti").empty();
					$.each(result.data, function(n, value) {
						$("#inputSelectMulti").append("<option value="+value.id+">"+value.name+"</option>");
					});
				}
			},
			dataType : "json"
		});
	}
</script>

</body>
</html>