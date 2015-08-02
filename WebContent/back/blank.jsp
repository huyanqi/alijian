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
<title></title>
<!-- base -->
<link href='<%=basePath%>back/assets/stylesheets/bootstrap/bootstrap.css' media='all' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>back/assets/stylesheets/jquery_ui/jquery-ui-1.10.0.custom.css' media='all' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>back/assets/stylesheets/light-theme.css' id='color-settings-body-color' media='all' rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="<%=basePath%>back/assets/amazeui/assets/css/amazeui.min.css">
<!-- ---- -->
<!-- <a href=\"javascript:preview('"+value.thum+ "')\"><img width='30' height='25' src="+value.thum+" /></a> -->

</head>
<body>


<script src='<%=basePath%>resources/jquery-1.8.2.min.js'></script>
<script src="<%=basePath%>back/assets/amazeui/assets/js/amazeui.min.js"></script> 

<script type="text/javascript">
	$(document).ready(function() {
		
	});
</script>
</body>
</html>