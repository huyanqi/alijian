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
<style>
#links a{
	font-size: 12px;
	padding: 5px;
}
</style>
</head>
<body>

<div id="links_ly" style="padding: 10px;width: 980px;margin-top: 10px;border: 1px solid #eeeeee;">
	<font style="font-size:12px;">友情链接</font>
	<div id="links">
		
	</div>
</div>

<footer class="footer">
	<p style="text-align: center;font-size: 12px;">© 2015 <a href="#" target="_blank">阿里健 - 淘资源.</a> Powered by Frankie.</p>
	<p style="text-align: center;font-size: 12px;margin-top: 0;"><a href="<%=basePath%>about_us.jsp">关于我们</a></p>
	<div class="jiathis_style" style="padding: 10px;display: inline-block;width: 100%;text-align: center;">
		<a href="http://www.jiathis.com/share" style="float: none;" class="jiathis jiathis_txt" target="_blank"><img src="http://v2.jiathis.com/code_mini/images/btn/v1/jiathis5.gif" border="0" /></a>
	</div>
</footer>
<script>

	$(document).ready(function(){
		getLinks();
	});
	
	function getLinks(){
		var path = "<%=basePath%>getLinks";
		var data = {};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$("#links").empty();
				if(result.result == "ok"){
					$.each(result.data, function(n, value) {
						$("#links").append("<a target='_blank' href='"+value.url+"'>"+value.name+"</a>");
					});
				}
			},
			dataType : "json"
		});
	}
</script>
<script type="text/javascript" >
var url = window.location.href;
var title = document.title;
var jiathis_config={
	siteNum:4,
	sm:"copy,fav,cqq,weixin",
	url:url,
	summary:"",
	title:title,
	boldNum:3,
	shortUrl:true,
	hideMore:true
}
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jia.js" charset="utf-8"></script>
<!-- JiaThis Button END -->


</body>
</html>