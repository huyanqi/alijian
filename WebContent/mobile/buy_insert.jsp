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
<title>阿里健 - 求购信息发布</title>
</head>
<body>
<jsp:include page="head_m.jsp" flush="true" />

<div style="width: 100%;padding: 10px;">
    <div class="control-group">
        <label class="control-label">需要购买的商品名称:</label>
        <div class="controls">
            <input class="am-form-field" id="name" type="text" placeholder="">
        </div>
    </div>
    
    <div class="control-group">
        <label class="control-label">联系人:</label>
        <div class="controls">
            <input class="am-form-field" id="user_name" type="text" placeholder="">
        </div>
    </div>
    
    <div class="control-group">
        <label class="control-label">联系电话:</label>
        <div class="controls">
            <input class="am-form-field" id="user_mobile" type="text" placeholder="">
        </div>
    </div>
    
    <div style="width: 100%;padding: 10px;padding-right: 0px;">
    	<button type="button" style="float: right;" onclick="save();" class="am-btn am-btn-secondary am-radius">确认发布</button>
    </div>
</div>
<script>
	function save(){
		var name = $("#name").val();
		var user_name = $("#user_name").val();
		var user_mobile = $("#user_mobile").val();
		
		if(name == "" || user_name == "" || user_mobile == ""){
			alert("请填写完表单内容");
			return;
		}
		var data = JSON.stringify({name:name,user_name:user_name,user_mobile:user_mobile});
		$.AMUI.progress.start();
		$.ajax({
			type : 'POST',
			dataType : "json",
			contentType : "application/json ; charset=utf-8",
			data : data,
			url : "<%=basePath%>insertBuyModel",
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					alert("求购信息已发布，请等候相关供应商与您联系。");
					window.history.back();
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