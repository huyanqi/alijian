<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>Js烟花特效</title>
</head>
<style type="text/css">
.fire{display:block; overflow:hidden; font-size:12px; position:absolute};
</style>
<body>
</body>
<script src="<%=basePath%>font/amazeui/js/jquery.min.js"></script>
<script type="text/javascript">
var Fire = function(r, color) {
	this.radius = r || 12;
	this.color = color;
	this.xpos = 0;
	this.ypos = 0;
	this.zpos = 0;
	this.vx = 0;
	this.vy = 0;
	this.vz = 0;
	this.mass = 1;
	this.x =0;
	this.y=0;
	this.p = document.createElement("span");
	this.p.className = "fire";
	this.p.innerHTML = "*";
	this.p.style.fontSize = this.radius + "px";
	this.p.style.color = "#" + this.color;
}
var flower_x = $(document).width()/2;
Fire.prototype = {
	append: function(parent) {
		parent.appendChild(this.p);
	},
	setSize: function(scale) {
		this.p.style.fontSize = this.radius * scale + "px";
	},
	setPosition:function(x, y) {
		this.p.style.left = x + "px";
		this.p.style.top =  y + "px";
	},
	setVisible: function(b) {
		this.p.style.display = b ? "block" : "none";
	}
}
var fireworks = function() {
	var fires = new Array();
	var count = 150;
	var fl = 250;
	var vpx = 500;
	var vpy = 300;
	var gravity = .5;
	var floor = 200;
	var bounce = -.8;
	var timer;
	var wind = ((Math.floor(Math.random()*3) + 3)/10)*(Math.random()*2 - 1 > 0 ? 1 : -1)*.25;
	var wpos = 0;
	var wcount;
	return {
		init: function() {
			wcount = 50 + Math.floor(Math.random() * 100);
			for (var i=0; i<count; i++) {
				var color = 0xFF0000;
				color = (Math.random() * 0xFFFFFF).toString(16).toString().split(".")[0];
				while(color.length < 6) {
					color = "0" + color;
				}
				var fire = new Fire(12, color);
				fires.push(fire);
				fire.ypos = -100;
				fire.vz = Math.random() * 6 - 3;
				fire.vx = (Math.random()*2 - 1)*2 ;
				fire.vy = Math.random()*-15 - 15;
				fire.x = flower_x;
				fire.y = 600;
				fire.append(document.body);
			}
			var that = this;
			timer = setInterval(function() {
				wpos++;
				if (wpos >= wcount) {
					wpos = 0;
					wcount = 50 + Math.floor(Math.random() * 100);
					wind = ((Math.floor(Math.random()*3) + 3)/10)*(Math.random()*2 - 1 > 0 ? 1 : -1)*.25;
				}
				for (var i=0;i<count; i++) {
					that.move(fires[i]);
				}
			}, 30);
		},
		move: function(fire) {
			fire.vy += gravity;
			fire.x += fire.vx;
			fire.y += fire.vy;
			fire.vx += wind;
			fire.setPosition(fire.x, fire.y);
				if (fire.x < 0 || fire.x >1000 || fire.y  < 0 || fire.y  > 600) {
					fire.vx = (Math.random()*2 - 1)*2;
					fire.vy = Math.random()*-15 - 15;
					fire.x = flower_x;
					fire.y = 600;
					fire.setPosition(fire.x, fire.y);
				}
		}
	}
}
fireworks().init();
</script>
</html>