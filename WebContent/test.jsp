<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script src="<%=basePath%>resources/jquery-form.js"></script>
<%-- <%
out.println("<form action='"+basePath+"change_order_state' id='autoform'><input type='hidden' name='out_trade_no' value='out_trade_no'/><input type='hidden' name='trade_no' value='trade_no'/><input type='hidden' name='trade_status' value='trade_status'/></form><script>document.forms['autoform'].submit();</script>");
%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试自动提交</title>
</head>
<body>
	<form action="<%=basePath%>change_order_state" id='autoform'>
		<input type='hidden' name='out_trade_no' value='out_trade_no' /><input
			type='hidden' name='trade_no' value='trade_no' /><input type='hidden'
			name='trade_status' value='trade_status' />
	</form>
	<script>
		$('#autoform').ajaxForm(function() {   
		       alert("Thank you for your comment!");  
		    }); 
		document.forms['autoform'].submit();
	</script>
</body>
</html>