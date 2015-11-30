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
  <title>入驻到 阿里健 - 大健康产业链</title>
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
    <h1>阿里健 - 大健康产业链</h1>
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
      <label for="email">点击下图上传营业执照:</label>
      <input accept="image/jpeg" type="file" name="upload" id="zhizhao" style="visibility: hidden;">
      <a style="display: inline-block;" href="javascript:$('#zhizhao').trigger('click');"><img id="yyzz" src="<%=basePath%>font/imgs/yyzz.jpg" width="400px" height="300px" /></a>
      <br>
      <label for="email">点击下图上传经营者身份证正面照片:</label>
      <input accept="image/jpeg" type="file" name="upload" id="shenfenzhengzhengmian" style="visibility: hidden;">
      <a style="display: inline-block;" href="javascript:$('#shenfenzhengzhengmian').trigger('click');"><img id="sfzzm" src="<%=basePath%>font/imgs/sfz_zm.jpg" width="400px" height="300px" /></a>
      <br>
      <label for="email">经营者身份证反面照片:</label>
      <input accept="image/jpeg" type="file" name="upload" id="shenfenzhengfanmian" style="visibility: hidden;">
      <a style="display: inline-block;" href="javascript:$('#shenfenzhengfanmian').trigger('click');"><img id="sfzfm" src="<%=basePath%>font/imgs/sfz_fm.jpg" width="400px" height="300px" /></a>
      <br>
      <label for="email">办公室照片(选填):</label>
      <input accept="image/jpeg" type="file" name="upload" id="bangongshizhaopian" style="visibility: hidden;">
      <a style="display: inline-block;" href="javascript:$('#bangongshizhaopian').trigger('click');">
      	<img id="bgszp" src="" width="400px" height="300px" style="display: none;"/>
      </a>
      <button type="button" class="am-btn am-btn-primary" onclick="$('#bangongshizhaopian').trigger('click');" id="bgszpbtn">点击上传办公室照片</button>
      <br>
      <label for="email">仓库照片(选填):</label>
      <input accept="image/jpeg" type="file" name="upload" id="cangkuzhaopian" style="visibility: hidden;">
      <a style="display: inline-block;" href="javascript:$('#cangkuzhaopian').trigger('click');">
      	<img id="ckzp" src="" width="400px" height="300px" style="display: none;"/>
      </a>
      <button type="button" class="am-btn am-btn-primary" onclick="$('#cangkuzhaopian').trigger('click');" id="ckzpbtn">点击上传仓库照片</button>
      <br>
      <label for="email">所属领域(按住ctrl可多选):</label>
      <div class="controls">
          <select id="inputSelectMulti" multiple="multiple">
          </select>
      </div>
      <br>
      <label for="email">企业联系人:</label>
      <input type="text" id="contact_name" placeholder="声音甜美的阿里健工作人员将会与您联系">
      <br>
      <label for="email">联系人电话:</label>
      <input type="text" id="mobile" class="js-pattern-mobile" placeholder="声音甜美的阿里健工作人员将会与您联系" required>
      <br>
      <label for="email">联系人座机:</label>
      <input type="text" id="contact_tel" placeholder="声音甜美的阿里健工作人员将会与您联系">
      <br>
      <label for="email">登录账号:</label>
      <input type="text" id="username" minlength="6" required placeholder="举例：成都百岁堂6688"/>
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
    <p>© 2015 <a href="#" target="_blank">阿里健 - 大健康产业链.</a> Powered by Frankie.</p>
  </div>
</div>

<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
<script src="<%=basePath%>assets/javascripts/jquery_ui/jquery-ui.min.js"></script>
<script src="<%=basePath%>assets/javascripts/fileupload/jquery.iframe-transport.js"></script>
<script src="<%=basePath%>assets/javascripts/fileupload/jquery.fileupload.js"></script>

<script>
	if ($.AMUI && $.AMUI.validator) {
	    $.AMUI.validator.patterns.mobile = /^\s*1\d{10}\s*$/;
	}
	
	$(function() {
		$('#myform').submit(function(evt) {
			if ($('form').data('amui.validator').isFormValid()){
				var yyzz = $("#yyzz").attr("alt");
				var sfzzm = $("#sfzzm").attr("alt");
				var sfzfm = $("#sfzfm").attr("alt");
				if(yyzz == null){
					alert("请上传企业营业执照照片");
					return false;
				}
				if(sfzzm == null){
					alert("请上传企业经营者身份证正面照片");
					return false;
				}
				if(sfzfm == null){
					alert("请上传企业经营者身份证反面照片");
					return false;
				}
				toSubmit();
				return false;
			}
		});
		$("#zhizhao").fileupload({
		    url:"<%=basePath%>fileupload",
		    done:function(e,result){
		        var obj = eval('(' + result.result + ')');
		        if(obj.result == "ok"){
		        	$("#yyzz").attr("src",obj.data);
		        	$("#yyzz").attr("alt",obj.data);
		        }else{
		        	alert(obj.data);
		        }
		    }
		});
		$("#shenfenzhengzhengmian").fileupload({
		    url:"<%=basePath%>fileupload",
		    done:function(e,result){
		        var obj = eval('(' + result.result + ')');
		        if(obj.result == "ok"){
		        	$("#sfzzm").attr("src",obj.data);
		        	$("#sfzzm").attr("alt",obj.data);
		        }else{
		        	alert(obj.data);
		        }
		    }
		});
		$("#shenfenzhengfanmian").fileupload({
		    url:"<%=basePath%>fileupload",
		    done:function(e,result){
		        var obj = eval('(' + result.result + ')');
		        if(obj.result == "ok"){
		        	$("#sfzfm").attr("src",obj.data);
		        	$("#sfzfm").attr("alt",obj.data);
		        }else{
		        	alert(obj.data);
		        }
		    }
		});
		$("#bangongshizhaopian").fileupload({
		    url:"<%=basePath%>fileupload",
		    done:function(e,result){
		        var obj = eval('(' + result.result + ')');
		        if(obj.result == "ok"){
		        	$("#bgszp").attr("src",obj.data);
		        	$("#bgszp").attr("alt",obj.data);
		        	$("#bgszp").show();
		        	$("#bgszpbtn").hide();
		        }else{
		        	alert(obj.data);
		        }
		    }
		});
		$("#cangkuzhaopian").fileupload({
		    url:"<%=basePath%>fileupload",
		    done:function(e,result){
		        var obj = eval('(' + result.result + ')');
		        if(obj.result == "ok"){
		        	$("#ckzp").attr("src",obj.data);
		        	$("#ckzp").attr("alt",obj.data);
		        	$("#ckzp").show();
		        	$("#ckzpbtn").hide();
		        }else{
		        	alert(obj.data);
		        }
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
		var contact_name = $("#contact_name").val();
		var contact_tel = $("#contact_tel").val();
		var yyzz = $("#yyzz").attr("alt");
		var sfzzm = $("#sfzzm").attr("alt");
		var sfzfm = $("#sfzfm").attr("alt");
		var bgszp = $("#bgszp").attr("alt");
		var ckzp = $("#ckzp").attr("alt");
		var group_list = "";
		$('#inputSelectMulti option:selected').each(function(){
			group_list += $(this).val()+",";
		});
		
		var data = JSON.stringify({username:username,password:password,name:name,address:address,mobile:mobile,type:1,types:group_list,yyzz:yyzz,sfzzm:sfzzm,sfzfm:sfzfm,contact_name:contact_name,contact_tel:contact_tel,bgszp:bgszp,ckzp:ckzp});
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