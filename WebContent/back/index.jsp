<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>阿里健 - 平台管理系统</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
    
    <!--[if lt IE 9]>
    <script src='<%=basePath%>assets/javascripts/html5shiv.js' type='text/javascript'></script>
    <![endif]-->
    <link href='<%=basePath%>assets/stylesheets/bootstrap/bootstrap.css' media='all' rel='stylesheet' type='text/css' />
    <link href='<%=basePath%>assets/stylesheets/bootstrap/bootstrap-responsive.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / jquery ui -->
    <link href='<%=basePath%>assets/stylesheets/jquery_ui/jquery-ui-1.10.0.custom.css' media='all' rel='stylesheet' type='text/css' />
    <link href='<%=basePath%>assets/stylesheets/jquery_ui/jquery.ui.1.10.0.ie.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / flatty theme -->
    <link href='<%=basePath%>assets/stylesheets/light-theme.css' id='color-settings-body-color' media='all' rel='stylesheet' type='text/css' />
    <!-- / demo -->
    <link href='<%=basePath%>assets/stylesheets/demo.css' media='all' rel='stylesheet' type='text/css' />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
<body class='contrast-red '>
<header>
    <div class='navbar' id='navbar'>
        <div class='navbar-inner'>
            <div class='container-fluid'>
                <a class='brand' href='#'>
                    <i class='icon-heart-empty'></i>
                    <span class='hidden-phone'>阿里健</span>
                </a>
                <a class='toggle-nav btn pull-left' href='#'>
                    <i class='icon-reorder'></i>
                </a>
            </div>
        </div>
    </div>
</header>
<div id='wrapper'>
<div id='main-nav-bg'></div>
<nav class='' id='main-nav'>
<div class='navigation'>
<div class='search'>
    <form accept-charset="UTF-8" action="search_results.html" method="get" /><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
        <div class='search-wrapper'>
            <input autocomplete="off" class="search-query" id="q" name="q" placeholder="Search..." type="text" value="" />
            <button class="btn btn-link icon-search" name="button" type="submit"></button>
        </div>
    </form>
</div>
<ul class='nav nav-stacked'>
<li class=''>
    <a class='dropdown-collapse' href='#'>
        <i class='icon-edit'></i>
        <span>分类管理</span>
        <i class='icon-angle-down angle-down'></i>
    </a>
    <ul class='nav nav-stacked in'>
        <li class=''>
            <a href='javascript:frameLink("type/TypeManage.jsp?type=0")'>
                <i class='icon-caret-right'></i>
                <span>模式分类</span>
            </a>
        </li>
        <li class=''>
            <a href='javascript:frameLink("type/TypeManage.jsp?type=1")'>
                <i class='icon-caret-right'></i>
                <span>商家分类</span>
            </a>
        </li>
        <li class=''>
            <a href='javascript:frameLink("type/TypeManage.jsp?type=2")'>
                <i class='icon-caret-right'></i>
                <span>讲师分类</span>
            </a>
        </li>
        <li class=''>
            <a href='javascript:frameLink("type/TypeManage.jsp?type=3")'>
                <i class='icon-caret-right'></i>
                <span>产品分类</span>
            </a>
        </li>
    </ul>
</li>
<li class=''>
    <a href='javascript:frameLink("lecturer/LecturerManage.jsp")'>
        <i class='icon-tint'></i>
        <span>讲师管理</span>
    </a>
</li>
<li class=''>
    <a class='dropdown-collapse' href='#'>
        <i class='icon-edit'></i>
        <span>供货商管理</span>
        <i class='icon-angle-down angle-down'></i>
    </a>
    <ul class='nav nav-stacked in'>
        <li class=''>
            <a href='javascript:frameLink("supplier/waiting.jsp")'>
                <i class='icon-caret-right'></i>
                <span>待审核列表</span>
            </a>
        </li>
        <li class=''>
            <a href='javascript:frameLink("supplier/manage.jsp")'>
                <i class='icon-caret-right'></i>
                <span>管理</span>
            </a>
        </li>
    </ul>
</li>
<li>
    <a class='dropdown-collapse ' href='#'>
        <i class='icon-tint'></i>
        <span>佣金结算</span>
    </a>
</li>
<li class=''>
    <a class='dropdown-collapse' href='#'>
        <i class='icon-edit'></i>
        <span>友情链接管理</span>
        <i class='icon-angle-down angle-down'></i>
    </a>
    <ul class='nav nav-stacked in'>
        <li class=''>
            <a href='javascript:frameLink("link/LinkInsert.jsp?is_edit=0")'>
                <i class='icon-caret-right'></i>
                <span>新增友情链接</span>
            </a>
        </li>
        <li class=''>
            <a href='javascript:frameLink("link/LinkManage.jsp")'>
                <i class='icon-caret-right'></i>
                <span>管理友情链接</span>
            </a>
        </li>
    </ul>
</li>
</ul>
</div>
</nav>
<div id="content">
<iframe src="type/TypeManage.jsp?type=0" id="myframe" width="100%" height="100%">
            
</iframe>
</div>
</div>
<!-- / jquery -->
<script src='<%=basePath%>assets/javascripts/jquery/jquery.min.js' type='text/javascript'></script>
<!-- / jquery mobile events (for touch and slide) -->
<script src='<%=basePath%>assets/javascripts/plugins/mobile_events/jquery.mobile-events.min.js' type='text/javascript'></script>
<!-- / jquery migrate (for compatibility with new jquery) -->
<script src='<%=basePath%>assets/javascripts/jquery/jquery-migrate.min.js' type='text/javascript'></script>
<!-- / jquery ui -->
<script src='<%=basePath%>assets/javascripts/jquery_ui/jquery-ui.min.js' type='text/javascript'></script>
<!-- / bootstrap -->
<script src='<%=basePath%>assets/javascripts/bootstrap/bootstrap.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/nav.js' type='text/javascript'></script>
<script type="text/javascript">

	$(document).ready(function(){
		$("#content").height($(document).height() - $("#navbar").height());
	});

	function frameLink(page){
		$("#myframe").attr("src",page);
	}
</script>
</body>
</html>
