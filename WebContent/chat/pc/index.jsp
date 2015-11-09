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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.5, user-scalable=yes"/>
    <title></title>

    <!-- Le styles -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="assets/css/docs.css" rel="stylesheet">
    <style type="text/css">
        @media (max-width: 767px){
            body {
                 padding-right: 0px;
                 padding-left: 0px;
            }
            .navbar-fixed-top,
            .navbar-fixed-bottom,
            .navbar-static-top {
                margin-right: 0px;
                margin-left: 0px;
            }
        }
        .navbar .brand{
            float: left;
            color: #eeeeee;
            margin-left: 0px;
        }
        .navbar-inverse .brand {
            color: #eeeeee;
        }
        .nav-list > .active > a, .nav-list > .active > a:hover, .nav-list > .active > a:focus{
            /*background-color: #fe3c23;*/
            background-color: #0044cc;
        }
        .nav > li > a{
            color: #000000;
        }
        .navbar-inverse .navbar-inner{
            /*border-color: #fe3c23;*/
            /*background-image: linear-gradient(to bottom, #fe3c23, #fe3c23);*/
            /*background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#fe3c23), to(#fe3c23));*/
            /*background-image: -webkit-linear-gradient(top, #fe3c23, #fe3c23);*/
            /*filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fffe3c23', endColorstr='#fffe3c23', GradientType=0); BACKGROUND-COLOR: #fe3c23;*/
            border-color: #0044cc;
            background-image: linear-gradient(to bottom, #0044cc, #0044cc);
            background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#0044cc), to(#0044cc));
            background-image: -webkit-linear-gradient(top, #0044cc, #0044cc);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ff0044cc', endColorstr='#ff0044cc', GradientType=0); BACKGROUND-COLOR: #0044cc;
        }
        .nav-pills > .active > a, .nav-pills > .active > a:hover, .nav-pills > .active > a:focus{
            /*background-color: #fe3c23;*/
            background-color: #0044cc;
        }
        .nav-tabs > li > a, .nav-pills > li > a{
            /*color: #fe3c23;*/
        }
        .hero-unit {
            /*background-color: #fcf8e3;*/
            background-color: #d9edf7;
            margin-bottom: 0px;
            padding: 0;
            height: 100%;
        }
        .scrollspy-contact-example{
            height: 330px;
            /*max-height: 330px;*/
            /*min-height: 330px;*/
            overflow: auto;
            position: relative;
            margin-bottom: 10px;
        }
        .scrollspy-content-example{
            height: 360px;
            /*max-height: 360px;*/
            /*min-height: 360px;*/
            overflow: auto;
            position: relative;
            margin-top: 12px;
            margin-bottom: 10px;
        }
        .alert{
            word-break:break-all;
            width: 60%;
            margin-top: 6px;
            margin-bottom: 6px;
        }
        .alert-right{
            float: right;
            margin-right: 12px;
            padding: 8px 14px 8px 14px;
        }
        .alert-left{
            float: left;
            margin-left: 12px;
            padding: 8px 14px 8px 14px;
        }
        div code{
            font-size:18px;
        }
        .modal-body div{
            height: 30px;
            padding-bottom: 6px;
        }
        #pop .table-striped{
            margin-bottom: 0px;
        }
        #pop .table-striped td{
             border-left: 0px solid #dddddd;
         }
        #pop .label{
            margin-left:10px;
            cursor:pointer;
            line-height:18px;
        }
        .emoji-img {
            width: 18px;
            height: 18px;
        }
        #im_send_content_copy{
            display: none;
        }
        .span8{
        	width: 100%;
        }
        #im_send_content{
            background-color:white;
            height:55px;
            max-width:750px;
            font-size:18px;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            margin:0 0 0 0;
            overflow-y: auto;
            overflow-x: hidden;
        }
        #im_content_list pre{
            font-size:18px;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            border: none;
            background: none;
            margin:0 0 0 0;
        }
        .row{
        	margin-left: 0px;
        }
    </style>
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <!--<script src="assets/js/html5shiv.js"></script>-->
    <!--[endif]-->
    <script src="http://app.cloopen.com/im50/ytx-web-im.min.js"></script>
    <script src="<%=basePath%>font/amazeui/js/amazeui.min.js"></script>
    <script src="<%=basePath%>font/amazeui/js/jweixin-1.0.0.js"></script>
    <script src="js/justdo.js"></script>
    <script src="js/emoji.js"></script>
    <link href="css/emoji.css" rel="stylesheet">

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="assets/ico/favicon.png">

</head>
<!--oncontextmenu="return false" onpaste="return false"-->
<body id="im_body1" style="overflow-x: hidden; overflow-y: auto; height: 100%;" onkeydown="IM.EV_keyCode(event)">
    <div id="im_body" style="overflow: hidden;height: 100%;">
        <!--<body>-->
        <div id="navbar" class="navbar navbar-inverse navbar-fixed-top" style="z-index: 999999;margin-bottom: 0;">
            <div class="navbar-inner">
                <div class="container">
                    <span><audio id="im_ring" src="js/ring.mp3"></audio></span>
                    <a class="brand" href="#">阿里健 IM</a>
                    <div id="navbar_login_show" class="nav-collapse in collapse" style="display:none; height: auto; ">
                        <!--<ul class="nav">-->
                            <!--<li class="pull-right">-->
                                <a imtype="navbar_login_show" class="brand" style="color: #eeeeee;" href="#">您好</a>
                            <!--</li>-->
                            <!--<li class="pull-right">-->
                                <a class="brand" href="#" style="color: #eeeeee;" onclick="logout()">退出</a>
                            <!--</li>-->
                        <!--</ul>-->
                    </div>
                </div>
            </div>
        </div>

        <div id="hero-unit" class="hero-unit">
            <div class="container" style="padding: 0;margin: 0;width: 100%;height: 100%;">
                <div class="row" style="height: 100%;">
                    <div class="span12" style="margin-left: 0;width: 100%;height: 100%;">
                        <div style="z-index: 778888; position: relative; left: 0px; top: 0px; display: none;">
                            <div id="alert-error" class="alert alert-error text-center" style="display: none;">
                                <button type="button" class="close" data-dismiss="alert" onclick="IM.HTML_closeAlert('alert-error')">×</button>
                                <strong id="alert-error_content">Oh snap!...</strong>
                            </div>
                            <div id="alert-info" class="alert alert-info text-center" style="display: none;">
                                <button type="button" class="close" data-dismiss="alert" onclick="IM.HTML_closeAlert('alert-info')">×</button>
                                <strong id="alert-info_content">Oh snap!...</strong>
                            </div>
                            <div id="alert-warning" class="alert alert-warning text-center" style="display: none;">
                                <button type="button" class="close" data-dismiss="alert" onclick="IM.HTML_closeAlert('alert-warning')">×</button>
                                <strong id="alert-warning_content">Oh snap!...</strong>
                            </div>
                            <div id="alert-success" class="alert alert-success text-center" style="display: none;">
                                <button type="button" class="close" data-dismiss="alert" onclick="IM.HTML_closeAlert('alert-success')">×</button>
                                <strong id="alert-success_content">Oh snap!...</strong>
                            </div>
                        </div>

                        <div class="row" style="height: 100%;">
                            <!-- 注释内容 -->
                            <div class="span4" style="margin-left: 0;width: 30%;float: left;padding: 3px;height: 100%;">
                                <div>
                                    <ul id="im_contact_type" class="nav nav-pills" style="display: none;">
                                        <li contact_type="C" onclick="IM.DO_choose_contact_type('C')" class="active"><a href="#">沟通</a></li>
                                        <li contact_type="G" onclick="IM.DO_choose_contact_type('G')"><a href="#">群组</a></li>
                                        <li contact_type="M" onclick="IM.DO_choose_contact_type('M')"><a href="#">客服</a></li>
                                    </ul>
                                </div>
                                <div id="im_add" class="input-prepend" style="display: none;">
                                    <span class="add-on"><i class="icon-user"></i></span>
                                    <input class="span3" imtype="im_add_contact" type="text" placeholder="填写对方帐号，点击添加!">
                                    <input class="span3" imtype="im_add_group" type="text" placeholder="填写群组名称，创建群组!" style="display:none;">
                                    <input class="span3" imtype="im_add_mcm" type="text" placeholder="选择客服号咨询!" style="display:none;" disabled>
                                    <button class="btn" imtype="im_add_btn_contact" type="button" onclick="IM.DO_addContactToList()">Add</button>
                                    <div class="btn-group" imtype="im_add_btn_group" style="display: none;">
                                        <button class="btn dropdown-toggle" data-toggle="dropdown">Add<span class="caret"></span></button>
                                        <ul class="dropdown-menu">
                                            <li><a href="#" onclick="IM.DO_addGroupToList(1)">默认可直接加入</a></li>
                                            <li><a href="#" onclick="IM.DO_addGroupToList(2)">需要身份验证</a></li>
                                            <li><a href="#" onclick="IM.DO_addGroupToList(3)">私有群组,仅能管理员邀请</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div id="im_contact" data-spy="scroll" data-target="#navbarExample" data-offset="0" class="scrollspy-contact-example" style="background-color: white;height: 100%;">
                                <div style="text-align: center;background: #D9EDF7;font-size: 12px;">聊天列表</div>
                                    <ul id="im_contact_list" class="nav nav-list">
                                        <!--<li class="active"><a href="#"> Choose components</a></li>-->
                                        <!--<li class="">-->
                                            <!--<a href="#">-->
                                                <!--<span>Download</span><span class="badge badge-warning pull-right">99+</span>-->
                                            <!--</a>-->
                                        <!--</li>-->
                                        <!--<li class="">-->
                                            <!--<a href="#">-->
                                                <!--<span>Download</span>-->
                                                <!--<span class="pull-right"><i class="icon-wrench"></i></span>-->
                                                <!--<span class="badge badge-warning pull-right" style="margin-top:3px; margin-right:10px">4</span>-->
                                            <!--</a>-->
                                        <!--</li>-->
                                    </ul>
                                </div>
                            </div>
                            <div class="span8" style="width: 65%;margin: 0;float: left;padding: 3px;height: 100%;">
                                <div class="row" style="height: 60%;margin-top: 30px;">
                                    <div class="span8" style="width: 100%;height: 100%;">
                                        <div id="im_content_list" data-spy="scroll" data-target="#navbarExample" data-offset="0" class="scrollspy-content-example" style="background-color: white;margin-top: 0;height: 100%;">

                                            <!--<div class="alert alert-block" style="width: 60%; float: left; margin-left: 6px;">-->
                                            <!--Navbar links must have resolvable id targets. For example, a <code>&lt;a href="#home"&gt;home&lt;/a&gt;</code> must correspond to something in the dom like <code>&lt;div id="home"&gt;&lt;/div&gt;</code>.-->
                                            <!--</div>-->

                                            <!--<div>-->
                                            <!--<div class="alert alert-success" style="width: 60%; float: right; margin-right: 6px;">-->
                                            <!--<span class="add-on" style="cursor:pointer; position: relative; left: -40px; top: 0px;"><i class="icon-repeat"></i></span>-->
                                            <!--<code>Navbar</code> links <span class="str">must</span> have resolvable id targets. For example, a <code>&lt;a href="#home"&gt;home&lt;/a&gt;</code> must correspond to something in the dom like <code>&lt;div id="home"&gt;&lt;/div&gt;</code>.-->
                                            <!--</div>-->
                                            <!--</div>-->

                                            <!--<img src="" id="img" width="270px" height="200px"/>-->
                                            <!--<video autoplay id="video" width="300px" height="200px"></video>-->
                                            <!--<audio style="display:none;" id="audio" controls="controls" autoplay="autoplay"></audio>-->
                                            <!--<canvas style="display:none;" id="canvas" width="270px" height="200px"></canvas>-->

                                            <script>

                                                //检测浏览器支持
//                                                function hasGetUserMedia() {
//                                                    //请注意:在Opera浏览器中不使用前缀
//                                                    return !!(navigator.getUserMedia || navigator.webkitGetUserMedia ||
//                                                    navigator.mozGetUserMedia || navigator.msGetUserMedia);
//                                                }
//                                                if (hasGetUserMedia()) {
//                                                    alert('您的浏览器支持getUserMedia方法');
//                                                }
//                                                else {
//                                                    alert('您的浏览器不支持getUserMedia方法');
//                                                }


                                                //获取访问设备的权限
//                                                var onFailSoHard = function() {
//                                                    alert('设备拒绝访问');
//                                                };
//                                                window.URL = window.URL || window.webkitURL || window.mozURL || window.msURL;
//                                                navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
                                                //视频
//                                                var video = document.getElementById('video');
//                                                if (navigator.getUserMedia) {
//                                                    navigator.getUserMedia({audio: true, video: true}, function(stream) {
//                                                        video.src = window.URL.createObjectURL(stream);
//                                                    }, onFailSoHard);
//                                                }
//                                                else {
//                                                    alert('您的浏览器不支持getUserMedia方法');
//                                                }

                                                //拍照
//                                                var video = document.getElementById('video');
//                                                var canvas = document.getElementById('canvas');
//                                                var ctx = canvas.getContext('2d');
//                                                var localMediaStream = null;
//                                                function snapshot() {
//                                                    if (localMediaStream) {
//                                                        ctx.drawImage(video, 0, 0, 270, 200);
//                                                        document.getElementById('img').src = canvas.toDataURL('image/png');
//                                                    }
//                                                }
//                                                video.addEventListener('click', snapshot, false);
//                                                //不使用供应商前缀
//                                                navigator.getUserMedia({video: true}, function(stream) {
//                                                    video.src = window.URL.createObjectURL(stream);
//                                                    localMediaStream = stream;
//                                                }, onFailSoHard);

//                                                video.addEventListener('play', function() {
//                                                    var i = window.setInterval(function() {
//                                                        ctx.drawImage(video, 0, 0, 270, 200)
//                                                    },20);
//                                                },false);

                                                //音频
//                                                var audio = document.getElementById('audio');
//                                                if (navigator.getUserMedia) {
//                                                    navigator.getUserMedia({audio: true}, function(stream) {
//                                                        audio.src = window.URL.createObjectURL(stream);
//                                                    }, onFailSoHard);
//                                                }
//                                                else {
//                                                    alert('您的浏览器不支持getUserMedia方法');
//                                                }

                                            </script>

                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="margin-top: 10px;margin-bottom: 10px;">
                                    <div class="span8" style="margin-left: 0px;">
                                        <div class="input-append span8" style="position: relative; margin:0 0 2px 0;">
                                            <div class="row">
                                                <div class="span8">
                                                    <div id="emoji_div" class="span8 popover top" style="display:none; top: -50px; max-width: 750px; margin-left: 5px;">
                                                        <div class="arrow" style="display: none;"></div>
                                                        <div class="popover-content" style="max-height: 120px; font-size:18px; overflow-y: auto">
                                                            <!--<p>-->
                                                            <!--<span class="emoji-outer emoji-sizer"><span class="emoji-inner" style="background: url(img/sheet_apple_64.png);background-position:41.1764705882353% 50%;background-size:3500%"></span></span>-->
                                                            <!--<span class="emoji-outer emoji-sizer"><span class="emoji-inner" style="background: url(img/sheet_apple_64.png);background-position:41.1764705882353% 50%;background-size:3500%"></span></span>-->
                                                            <!--<span class="emoji-outer emoji-sizer"><span class="emoji-inner" style="background: url(img/sheet_apple_64.png);background-position:41.1764705882353% 50%;background-size:3500%"></span></span>-->
                                                            <!--</p>-->
                                                        </div>
                                                    </div>
                                                    <span class="add-on" onclick="IM.HTML_showOrHideEmojiDiv()"><label><i class="icon-heart"></i></label></span>
                                                    <span class="add-on"><label for="im_image_file"><i class="icon-camera"></i></label></span>
                                                    <span class="add-on"><label for="im_attachment_file"><i class="icon-folder-open"></i></label></span>
                                                    <!--<span class="add-on"><i class="icon-comment"></i></span>-->
                                                    <!--<input class="span6" id="im_send_content" type="text" placeholder="Ctrl+Enter 发送">-->
                                                    <span style="position:absolute; right: 0px;">
                                                    <button class="btn" type="button" onclick="IM.DO_sendMsg()">发送</button></span>
                                                    <!-- <span class="add-on" style="position:absolute; right: 58px;">Ctrl+Enter 发送</span> -->

                                                    <input type="hide" name="im_image_file" id="im_image_file" style="display:none;margin: 0 auto;" onclick="IM.DO_im_image_file()">
                                                    <input type="hide" name="im_attachment_file" id="im_attachment_file" style="display:none;margin: 0 auto;" onclick="IM.DO_im_attachment_file()">
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="span8">
                                        <pre id="im_send_content" contenteditable="true"></pre>
                                        <pre id="im_send_content_copy"></pre>
                                    </div>
                                </div>

                            </div>
                            <div style="clear: both;"/>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!--<div id="lvjing" style="background-color: #999999; z-index: 1; position: relative; left: 0px; top: 0px; height: 0px; width: 0px;" ></div>-->
        <div id="lvjing" style="display: block; z-index: 668888; position: absolute; margin-left: 0px; padding-left: 0px; left: 0px; top: 0px; height: 0px; width: 0px;">
            <canvas id="lvjing_canvas" style="border:1px solid #aaa; display: block;"></canvas>
            <img style="display: block;position: absolute; top:0px; left:0px;" src="assets/img/logo-blue.png" />
        </div>

        <div id="pop" style="display:none; z-index: 888887; width: 100%; position: absolute; top: 0px;left: 0px; margin: 20px 0 20px 0;">
            <div class="container">
                <div class="row" style="margin: 20px 30px 20px 30px;">
                    <!--<div class="modal" style="position: relative; top: auto; left: auto; right: auto; margin: 0 auto 20px; z-index: 1; max-width: 100%;">-->
                        <!--<div class="modal-header">-->
                            <!--<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="IM.HTML_pop_hide();">×</button>-->
                            <!--<h3>Modal header</h3>-->
                        <!--</div>-->
                        <!--<div class="modal-body">-->
                            <!--<p>One fine body…</p>-->
                            <!--<p>One fine body…</p>-->
                        <!--</div>-->
                        <!--<div class="modal-footer">-->
                            <!--<a href="#" class="btn">Close</a>-->
                            <!--<a href="#" class="btn btn-primary">Save changes</a>-->
                        <!--</div>-->
                    <!--</div>-->
                </div>
            </div>
        </div>

        <div id="pop_photo" style="display:none; z-index: 888888; width: 100%; height:auto; position: absolute; top: 0px;left: 0px; margin: 5px 0 5px 0;">
            <div class="carousel slide" imtype="pop_photo_top" style="position: relative; top: auto; left: auto; right: auto; margin: 0 auto 0px; z-index: 1; max-width: 100%;">
                <div class="carousel-inner">
                    <div class="carousel slide" style="text-align: center;">
                        <img src="assets/img/bootstrap-mdo-sfmoma-03.jpg" alt="" />
                    </div>
                </div>
                <a class="left carousel-control" href="#myCarousel" data-slide="prev" onclick="IM.DO_pop_photo_up()">‹</a>
                <a class="right carousel-control" href="#myCarousel" data-slide="next" onclick="IM.DO_pop_photo_down()">›</a>
                <a class="right carousel-control" href="#myCarousel" data-slide="next" style="top:5%; height:auto;" onclick="IM.HTML_pop_photo_hide()">×</a>
            </div>
        </div>


        <!--<footer class="text-center">-->
        <!--<p>&copy; Company 2013</p>-->
        <!--</footer>-->
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
        	var uid = 0;
        	if(getUrlParam("chat") != null)
        		uid = getUrlParam("chat");
        	if($.AMUI.utils.cookie.get("username") == null){
        		alert("请先登录");
        		history.back();
        		return;
        	}
            IM.init(uid);
        });
        
        function logout(){
        	history.go(-2);
        	//IM.EV_logout()
        }
        
        function getUrlParam(name) {
    		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    		var r = window.location.search.substr(1).match(reg); //匹配目标参数
    		if (r != null)
    			return unescape(r[2]);
    		return null; //返回参数值
    	}
    </script>

</body>
</html>


<!-- <div class="span4" style="margin-left: 0;width: 30%;float: left;padding: 3px;">
                                <div>
                                    <ul id="im_contact_type" class="nav nav-pills">
                                        <li contact_type="C" onclick="IM.DO_choose_contact_type('C')" class="active"><a href="#">沟通</a></li>
                                        <li contact_type="G" onclick="IM.DO_choose_contact_type('G')"><a href="#">群组</a></li>
                                        <li contact_type="M" onclick="IM.DO_choose_contact_type('M')"><a href="#">客服</a></li>
                                    </ul>
                                </div>
                                <div id="im_add" class="input-prepend">
                                    <span class="add-on"><i class="icon-user"></i></span>
                                    <input class="span3" imtype="im_add_contact" type="text" placeholder="填写对方帐号，点击添加!">
                                    <input class="span3" imtype="im_add_group" type="text" placeholder="填写群组名称，创建群组!" style="display:none;">
                                    <input class="span3" imtype="im_add_mcm" type="text" placeholder="选择客服号咨询!" style="display:none;" disabled>
                                    <button class="btn" imtype="im_add_btn_contact" type="button" onclick="IM.DO_addContactToList()">Add</button>
                                    <div class="btn-group" imtype="im_add_btn_group" style="display: none;">
                                        <button class="btn dropdown-toggle" data-toggle="dropdown">Add<span class="caret"></span></button>
                                        <ul class="dropdown-menu">
                                            <li><a href="#" onclick="IM.DO_addGroupToList(1)">默认可直接加入</a></li>
                                            <li><a href="#" onclick="IM.DO_addGroupToList(2)">需要身份验证</a></li>
                                            <li><a href="#" onclick="IM.DO_addGroupToList(3)">私有群组,仅能管理员邀请</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div id="im_contact" data-spy="scroll" data-target="#navbarExample" data-offset="0" class="scrollspy-contact-example" style="background-color: white;margin-bottom: 0;height: 100%;">
                                	<div style="text-align: center;background: #D9EDF7;font-size: 12px;">聊天列表</div>
                                    <ul id="im_contact_list" class="nav nav-list">
                                        <li class="active"><a href="#"> Choose components</a></li>
                                        <li class="">
                                            <a href="#">
                                                <span>Download</span><span class="badge badge-warning pull-right">99+</span>
                                            </a>
                                        </li>
                                        <li class="">
                                            <a href="#">
                                                <span>Download</span>
                                                <span class="pull-right"><i class="icon-wrench"></i></span>
                                                <span class="badge badge-warning pull-right" style="margin-top:3px; margin-right:10px">4</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div> -->
