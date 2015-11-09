<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>阿里健 - 用户管理后台</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
    
    <link href='<%=basePath%>assets/stylesheets/bootstrap/bootstrap.css' media='all' rel='stylesheet' type='text/css' />
    <link href='<%=basePath%>assets/stylesheets/bootstrap/bootstrap-responsive.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / jquery ui -->
    <link href='<%=basePath%>assets/stylesheets/jquery_ui/jquery-ui-1.10.0.custom.css' media='all' rel='stylesheet' type='text/css' />
    <link href='<%=basePath%>assets/stylesheets/jquery_ui/jquery.ui.1.10.0.ie.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / switch buttons -->
    <link href='<%=basePath%>assets/stylesheets/plugins/bootstrap_switch/bootstrap-switch.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / xeditable -->
    <link href='<%=basePath%>assets/stylesheets/plugins/xeditable/bootstrap-editable.css' media='all' rel='stylesheet' type='text/css' />
    <link href='<%=basePath%>assets/stylesheets/plugins/common/bootstrap-wysihtml5.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / wysihtml5 (wysywig) -->
    <link href='<%=basePath%>assets/stylesheets/plugins/common/bootstrap-wysihtml5.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / jquery file upload -->
    <link href='<%=basePath%>assets/stylesheets/plugins/jquery_fileupload/jquery.fileupload-ui.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / full calendar -->
    <link href='<%=basePath%>assets/stylesheets/plugins/fullcalendar/fullcalendar.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / select2 -->
    <link href='<%=basePath%>assets/stylesheets/plugins/select2/select2.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / mention -->
    <link href='<%=basePath%>assets/stylesheets/plugins/mention/mention.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / tabdrop (responsive tabs) -->
    <link href='<%=basePath%>assets/stylesheets/plugins/tabdrop/tabdrop.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / jgrowl notifications -->
    <link href='<%=basePath%>assets/stylesheets/plugins/jgrowl/jquery.jgrowl.min.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / datatables -->
    <link href='<%=basePath%>assets/stylesheets/plugins/datatables/bootstrap-datatable.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / dynatrees (file trees) -->
    <link href='<%=basePath%>assets/stylesheets/plugins/dynatree/ui.dynatree.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / color picker -->
    <link href='<%=basePath%>assets/stylesheets/plugins/bootstrap_colorpicker/bootstrap-colorpicker.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / datetime picker -->
    <link href='<%=basePath%>assets/stylesheets/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.min.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / daterange picker) -->
    <link href='<%=basePath%>assets/stylesheets/plugins/bootstrap_daterangepicker/bootstrap-daterangepicker.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / flags (country flags) -->
    <link href='<%=basePath%>assets/stylesheets/plugins/flags/flags.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / slider nav (address book) -->
    <link href='<%=basePath%>assets/stylesheets/plugins/slider_nav/slidernav.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / fuelux (wizard) -->
    <link href='<%=basePath%>assets/stylesheets/plugins/fuelux/wizard.css' media='all' rel='stylesheet' type='text/css' />
    <!-- / flatty theme -->
    <link href='<%=basePath%>assets/stylesheets/light-theme.css' id='color-settings-body-color' media='all' rel='stylesheet' type='text/css' />
    <!-- / demo -->
    <link href='<%=basePath%>assets/stylesheets/demo.css' media='all' rel='stylesheet' type='text/css' />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
<body class='contrast-red main-nav-closed'>
<header>
    <div class='navbar'>
        <div class='navbar-inner'>
            <div class='container-fluid'>
                <a class='brand' href='javascript:history.back();' style="font-size: 12px;">
                    	返回
                </a>
                <a class='toggle-nav btn pull-left' href='#'>
                    <i class='icon-reorder'></i>
                </a>
                <ul class='nav pull-right'>
                    <li class='user-menu'>
                        <a>欢迎<span id="name"></span></a>
                    </li>
                    <li class='user-menu'>
                        <a href="javascript:logout();">退出登录</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>
<div id='wrapper'>
<div id='main-nav-bg'></div>
<nav class='' id='main-nav'>
<div class='navigation'>
<ul class='nav nav-stacked'>
<li class=''>
	<a href='javascript:toChat();'>
        <i class='icon-smile'></i>
        <span>登录聊天系统</span>
    </a>
</li>
<li class=''>
	<a href='javascript:updateUserInfo();'>
        <i class='icon-user'></i>
        <span>修改资料信息</span>
    </a>
</li>
<li class=''>
	<a href='javascript:frameLink("goods/CartList.jsp")'>
        <i class='icon-shopping-cart'></i>
        <span>采购列表</span>
    </a>
</li>
<li class=''>
    <a class='dropdown-collapse' href='#' onclick="openOrClose();">
        <i class='icon-edit'></i>
        <span>商品管理</span>
        <i class='icon-angle-down angle-down'></i>
    </a>
    <ul class='nav nav-stacked'>
        <li class=''>
            <a href='javascript:frameLink("goods/GoodsInsertOrUpdate.jsp")'>
                <i class='icon-caret-right'></i>
                <span>新增商品</span>
            </a>
        </li>
        <li class=''>
            <a href='javascript:frameLink("goods/GoodsManage.jsp")'>
                <i class='icon-caret-right'></i>
                <span>商品列表</span>
            </a>
        </li>
        <li class=''>
            <a href='javascript:frameLink("order/SoldList.jsp")'>
                <i class='icon-caret-right'></i>
                <span>待发货/收款列表</span>
            </a>
        </li>
    </ul>
</li>
<li>
    <a class='dropdown-collapse ' href='#' onclick="openOrClose();">
        <i class='icon-tint'></i>
        <span>商业模式</span>
        <i class='icon-angle-down angle-down'></i>
    </a>
    <ul class='nav nav-stacked'><!-- 加in 则是打开 -->
        <li class=''>
            <a href='javascript:frameLink("business/BusinessInsertOrUpdate.jsp")'>
                <i class='icon-caret-right'></i>
                <span>新模式发布</span>
            </a>
        </li>
        <li class=''>
            <a href='javascript:frameLink("business/BusinessManage.jsp")'>
                <i class='icon-caret-right'></i>
                <span>已有列表查看</span>
            </a>
        </li>
    </ul>
</li>
</ul>
</div>
</nav>
<section id='content'>
    <div class='container-fluid' id="content_ly" style="margin: 0px;padding: 0px;">
        <!-- <div class='row-fluid' id='content-wrapper'>
            <div class='span12'>

            </div>
        </div> -->
        <iframe src="" id="myframe" width="100%" height="100%" style="border: 0px;">
            
		</iframe>
    </div>
</section>
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
<script src='<%=basePath%>assets/javascripts/plugins/flot/excanvas.js' type='text/javascript'></script>
<!-- / sparklines -->
<script src='<%=basePath%>assets/javascripts/plugins/sparklines/jquery.sparkline.min.js' type='text/javascript'></script>
<!-- / flot charts -->
<script src='<%=basePath%>assets/javascripts/plugins/flot/flot.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/flot/flot.resize.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/flot/flot.pie.js' type='text/javascript'></script>
<!-- / bootstrap switch -->
<script src='<%=basePath%>assets/javascripts/plugins/bootstrap_switch/bootstrapSwitch.min.js' type='text/javascript'></script>
<!-- / fullcalendar -->
<script src='<%=basePath%>assets/javascripts/plugins/fullcalendar/fullcalendar.min.js' type='text/javascript'></script>
<!-- / datatables -->
<script src='<%=basePath%>assets/javascripts/plugins/datatables/jquery.dataTables.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/datatables/jquery.dataTables.columnFilter.js' type='text/javascript'></script>
<!-- / wysihtml5 -->
<script src='<%=basePath%>assets/javascripts/plugins/common/wysihtml5.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/common/bootstrap-wysihtml5.js' type='text/javascript'></script>
<!-- / select2 -->
<script src='<%=basePath%>assets/javascripts/plugins/select2/select2.js' type='text/javascript'></script>
<!-- / color picker -->
<script src='<%=basePath%>assets/javascripts/plugins/bootstrap_colorpicker/bootstrap-colorpicker.min.js' type='text/javascript'></script>
<!-- / mention -->
<script src='<%=basePath%>assets/javascripts/plugins/mention/mention.min.js' type='text/javascript'></script>
<!-- / input mask -->
<script src='<%=basePath%>assets/javascripts/plugins/input_mask/bootstrap-inputmask.min.js' type='text/javascript'></script>
<!-- / fileinput -->
<script src='<%=basePath%>assets/javascripts/plugins/fileinput/bootstrap-fileinput.js' type='text/javascript'></script>
<!-- / modernizr -->
<script src='<%=basePath%>assets/javascripts/plugins/modernizr/modernizr.min.js' type='text/javascript'></script>
<!-- / retina -->
<%-- <script src='<%=basePath%>assets/javascripts/plugins/retina/retina.js' type='text/javascript'></script> --%>
<!-- / fileupload -->
<script src='<%=basePath%>assets/javascripts/plugins/fileupload/tmpl.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/fileupload/load-image.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/fileupload/canvas-to-blob.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/fileupload/jquery.iframe-transport.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/fileupload/jquery.fileupload.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/fileupload/jquery.fileupload-fp.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/fileupload/jquery.fileupload-ui.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/fileupload/jquery.fileupload-init.js' type='text/javascript'></script>
<!-- / timeago -->
<script src='<%=basePath%>assets/javascripts/plugins/timeago/jquery.timeago.js' type='text/javascript'></script>
<!-- / slimscroll -->
<script src='<%=basePath%>assets/javascripts/plugins/slimscroll/jquery.slimscroll.min.js' type='text/javascript'></script>
<!-- / autosize (for textareas) -->
<script src='<%=basePath%>assets/javascripts/plugins/autosize/jquery.autosize-min.js' type='text/javascript'></script>
<!-- / charCount -->
<script src='<%=basePath%>assets/javascripts/plugins/charCount/charCount.js' type='text/javascript'></script>
<!-- / validate -->
<script src='<%=basePath%>assets/javascripts/plugins/validate/jquery.validate.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/validate/additional-methods.js' type='text/javascript'></script>
<!-- / naked password -->
<script src='<%=basePath%>assets/javascripts/plugins/naked_password/naked_password-0.2.4.min.js' type='text/javascript'></script>
<!-- / nestable -->
<script src='<%=basePath%>assets/javascripts/plugins/nestable/jquery.nestable.js' type='text/javascript'></script>
<!-- / tabdrop -->
<script src='<%=basePath%>assets/javascripts/plugins/tabdrop/bootstrap-tabdrop.js' type='text/javascript'></script>
<!-- / jgrowl -->
<script src='<%=basePath%>assets/javascripts/plugins/jgrowl/jquery.jgrowl.min.js' type='text/javascript'></script>
<!-- / bootbox -->
<script src='<%=basePath%>assets/javascripts/plugins/bootbox/bootbox.min.js' type='text/javascript'></script>
<!-- / inplace editing -->
<script src='<%=basePath%>assets/javascripts/plugins/xeditable/bootstrap-editable.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/xeditable/wysihtml5.js' type='text/javascript'></script>
<!-- / ckeditor -->
<script src='<%=basePath%>assets/javascripts/plugins/ckeditor/ckeditor.js' type='text/javascript'></script>
<!-- / filetrees -->
<script src='<%=basePath%>assets/javascripts/plugins/dynatree/jquery.dynatree.min.js' type='text/javascript'></script>
<!-- / datetime picker -->
<script src='<%=basePath%>assets/javascripts/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.js' type='text/javascript'></script>
<!-- / daterange picker -->
<script src='<%=basePath%>assets/javascripts/plugins/bootstrap_daterangepicker/moment.min.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/plugins/bootstrap_daterangepicker/bootstrap-daterangepicker.js' type='text/javascript'></script>
<!-- / max length -->
<script src='<%=basePath%>assets/javascripts/plugins/bootstrap_maxlength/bootstrap-maxlength.min.js' type='text/javascript'></script>
<!-- / dropdown hover -->
<script src='<%=basePath%>assets/javascripts/plugins/bootstrap_hover_dropdown/twitter-bootstrap-hover-dropdown.min.js' type='text/javascript'></script>
<!-- / slider nav (address book) -->
<script src='<%=basePath%>assets/javascripts/plugins/slider_nav/slidernav-min.js' type='text/javascript'></script>
<!-- / fuelux -->
<script src='<%=basePath%>assets/javascripts/plugins/fuelux/wizard.js' type='text/javascript'></script>
<!-- / flatty theme -->
<script src='<%=basePath%>assets/javascripts/nav.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/tables.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/theme.js' type='text/javascript'></script>
<!-- / demo -->
<script src='<%=basePath%>assets/javascripts/demo/jquery.mockjax.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/demo/inplace_editing.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/demo/charts.js' type='text/javascript'></script>
<script src='<%=basePath%>assets/javascripts/demo/demo.js' type='text/javascript'></script>
<script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		$("#content_ly").height($(document).height());// - $("#navbar").height()
		getSession();
	});
	
	function getSession(){
		
		var cookie = $.AMUI.utils.cookie;
		if(cookie.get("accesstoken") != null){
			//已登录
			$("#name").html(cookie.get("name"));
		}else{
			//未登录
			window.close();
		}
		
	}

	function frameLink(page){
		$("#myframe").attr("src",page);
	}
	
	function openOrClose(){
		var hasClose = $("body").hasClass("main-nav-closed");
		//是关闭的状态，则打开
		//先删除关闭class,再插入打开class
		if(hasClose){
			$("body").removeClass("main-nav-closed");
			$("body").addClass("main-nav-opened");
		}
	}
	
	function logout(){
		$.ajax({
			type : 'POST',
			dataType : "json",
			contentType : "application/json ; charset=utf-8",
			url : "<%=basePath%>logout",
			success : function(result) {
				if (result.result == "ok") {
					window.location = "<%=basePath%>welcome.jsp";
				}
			},
			dataType : "json"
		});
	}
	
	function toChat(){
		if (!IsPC()) {
			window.open("<%=basePath%>chat/pc/index.jsp",'newindow');
		}else{
			var iHeight = 575;
			var iWidth = 900;
			var iTop = (window.screen.height-30-iHeight)/2; //获得窗口的垂直位置;  
			var iLeft = (window.screen.width-10-iWidth)/2; //获得窗口的水平位置;  
			window.open("<%=basePath%>chat/pc/index.jsp",'newindow','height='+iHeight+',width='+iWidth+',top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no,top='+iTop+',left='+iLeft);
		}
	}
	
	function updateUserInfo(){
		$("#myframe").attr("src","<%=basePath%>back/supplier/supplier_update.jsp?uid="+$.AMUI.utils.cookie.get("uid"));
	}
	
	function IsPC() {
		var userAgentInfo = navigator.userAgent;
		var Agents = [ "Android", "iPhone", "SymbianOS", "Windows Phone",
				"iPad", "iPod" ];
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
