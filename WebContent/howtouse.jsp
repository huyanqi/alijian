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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"></meta>
<title>如何使用阿里健</title>

</head>
<body>
<div id="header_ly"></div>
<div class="am-container" style="background: #DDDDDD;height: 1px;"></div>
<img width="100%" src="<%=basePath%>font/imgs/howtouse.jpg">

<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script type="text/javascript">
if(!IsPC()){
	$("#header_ly").load("<%=basePath%>mobile/head_m.jsp");
}else{
	$("#header_ly").load("<%=basePath%>pc/head.jsp");
}
	
function IsPC() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ["Android", "iPhone",
                "SymbianOS", "Windows Phone",
                "iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;
}
</script>

</body>
</html>