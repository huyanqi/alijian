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
<title>关于我们</title>

</head>
<body>
<div id="header_ly"></div>
<div class="am-container" style="background: #DDDDDD;height: 1px;"></div>
<div id="content" class="am-container">
	<h3 class="am-article-title blog-title">
      <a href="#">阿里健是什么？</a>
    </h3>
    
    <div class="am-g blog-content">
          <p>&emsp;&emsp;阿里健是一个大健康行业的产业链平台、比如阿里健由：材料商、包装商、生产商、招商平台、行业培训企业、招聘中心、项目合作单位、采购商、供货商、等组成的一个完整的行业服务体系。好处在于帮助商家和经销商快速自动对接行业需求、互通有无、提高商家与商家之间的相互合作机会！</p>

          <p>&emsp;&emsp;大健康包括所有属于健康的产品和技术与人才。产品如：药品、保健品、化妆品、绿色农产品、环保家具用品、环保家装建材、 
服务如：医院、药店、健康管理、项目合作、
人才如：厂家、经销商、行业讲师、等。</p>

          <p>采购商的天堂：一站式厂家直销.免去中间差价.</p>
          <p>讲师的天堂：一站式对接、资源无限放大！</p>
          <p>保健品公司的天堂：产、销一条龙大大提高企业效益.</p>
          <p>生产商的天堂：众多潜在客户主动找上门来、让您坐享其成！</p>
          <p>材料供应商的天堂：与众多生产商做邻居、近水楼台先得月。</p>
      </div>
</div>
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