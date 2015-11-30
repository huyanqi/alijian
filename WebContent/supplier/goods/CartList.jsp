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
<title>采购列表</title>
<!-- base -->
<link
	href='<%=basePath%>assets/stylesheets/bootstrap/bootstrap.css'
	media='all' rel='stylesheet' type='text/css' />
<link
	href='<%=basePath%>assets/stylesheets/jquery_ui/jquery-ui-1.10.0.custom.css'
	media='all' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>assets/stylesheets/light-theme.css'
	id='color-settings-body-color' media='all' rel='stylesheet'
	type='text/css' />
<!-- ---- -->

<!-- amazeui -->
<link rel="stylesheet" href="<%=basePath%>assets/amazeui/assets/css/amazeui.min.css">
<style>
#buylist tr{
	background: #F9F9F9;
}
#buylist th{
	background: white;
}
</style>
</head>
<body>

<div class="row-fluid">
    <div class="span12 box bordered-box red-border" style="margin-bottom:0;">
        <div class="box-header red-background">
            <div class="title">采购列表</div>
            <div class="actions">
                <a href="javascript:refresh()" class="btn box-remove btn-mini btn-link"><i class="icon-refresh"></i></a>
                <Button href="#" class="btn btn-mini btn-link"></Button>
            </div>
        </div>
        
        <div class="box-content box-no-padding">
            <div class="responsive-table">
                <div class="scrollable-area">
                    <table class="table table-hover table-striped" style="margin-bottom:0;" id="buylist">
                    </table>
                </div>
            </div>
        </div>
        
        <!-- <div class="box-content box-no-padding">
            <div class="responsive-table">
                <div class="scrollable-area">
                    <table class="table table-hover table-striped" style="margin-bottom:0;">
                        <thead>
                        <tr>
                            <th>
                                ID
                            </th>
                            <th>
								订单号
                            </th>
                        </tr>
                        <tr>
                        	<td>
								数量
                            </td>
                            <td>
								总价
                            </td>
                            <td>
								物流
                            </td>
                            <td>
								订单更新时间
                            </td>
                            <td>
								状态
                            </td>
                            <th>
								操作
                            </th>
                        
                        </tr>
                        </thead>
                        <thead id="nodata">
							<tr>
								<th colspan="2">无数据</th>
							</tr>
						</thead>
                        <tbody id="list_content">
                        
                        </tbody>
                    </table>
                    <ul class="am-pagination" style="margin-left: 10px;">
						<li><a href="javascript:page(0);">&laquo;上一页</a></li>
						<li>
							<select style="width: 100px;" id="pageselect">
							</select>
						</li>
						<li><a href="javascript:page(1);">下一页 &raquo;</a></li>
					</ul>
                </div>
            </div>
        </div> -->
    </div>
</div>

<script src='<%=basePath%>resources/jquery-1.8.2.min.js'></script>
<script src="<%=basePath%>assets/amazeui/assets/js/amazeui.min.js"></script>
<script src="<%=basePath%>assets/javascripts/moment.js"></script>

<script type="text/javascript">

	var pageNum = 1;
	var hasData = false;
	$(document).ready(function() {
		moment.locale('zh-cn');
		//分页选择监听
		$('#pageselect').change(function(){
			pageNum = $("#pageselect").val();
			getMyGoods();
		});
		getMyGoods();
	});
	
	function editModel(id){
		window.location.href= 'GoodsInsertOrUpdate.jsp?id='+id;
	}
	
	function deleteModel(id){
		if(!confirm("确定要删除吗？")){return;}
		var path = "<%=basePath%>removeGoodsById";
		var data = {"id":id};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				if(result.result = "ok"){
					pageNum = 1;
					getMyGoods();
				}else{
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}

	var datas;
	function getMyGoods(){
		$.AMUI.progress.start();
		var path = "<%=basePath%>get_my_buy";
		var data = {"pageNum":pageNum};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				$("#buylist").empty();
				if(result.result == "ok"){
					hasData = true;
					$("#nodata").hide();
					$("#thread").show();
					datas = result.data;
					$.each(result.data, function(n, value) {
						var html = "";
						var create_time = moment(value.create_time.time).format("lll");
						html += "<thead><tr><th>订单号："+value.orders_no+"</th><th>订单创建时间:"+create_time+"</th></tr></thead>";
						$.each(value.goodsList,function(n0,value0){
							var type = "默认";
							if(value.goods_type != null){
								type = value.goods_type;
							}
							html += "<tbody><tr><td><img width='50' height='50' src='<%=basePath%>"+value0.goodsModel.thum+"'/></td><td><a target='_blank' href='<%=basePath%>goods/"+value0.goodsModel.id+"'>"+value0.goodsModel.name+"</a></td><td>购买数量:"+value0.amout+"</td><td>规格:"+type+"</td><td>价格:"+value0.prices+"</td></tr></tbody>";
						});
						
						var state;
						var opition = "";//<a href='javascript:showdetail("+n+")'>订单详情</a> 
						var wuliu = "无";
						if(value.state == 0){
							state = "<font color='color'>等待买家付款</font>";
							//提供付款按钮
							opition += "<a href='javascript:jixufukuan("+n+")'>继续付款</a> &emsp;&emsp;<a href='javascript:shanchu("+value.id+")'>删除订单</a>";
						}else if(value.state == 1){
							state = "<font color='green'>买家已付款，等待卖家发货</font>";
							//无可操作项
							
						}else if(value.state == 2){
							state = "<font color='black'>交易成功</font>";
							if(value.comment_id == 0){
								//还没评论
								opition += "<a href='javascript:pingjia("+value.id+")'>评价此商品</a>";
							}
							wuliu = value.cnumber;
						}else if(value.state == 3){
							state = "<font color='yellow'>已退款</font>";
							//无可操作项
							
						}else if(value.state == 4){
							state = "<font color='blue'>卖家已发货</font>";
							//提供确认收货按钮
							opition += "<a href='javascript:querenshouhuo("+n+")'>确认收货</a>";
							wuliu = value.cnumber;
						}
						
						html += "<tr><td colspan='2'></td><td><font color='green'>订单总额："+value.prices+"元</font></td><td colspan='2'>"+state+"  "+opition+"</td></tr>";
						
						$("#buylist").append(html);
						<%-- var update_time = moment(value.update_time.time).format("lll");
						var state;
						var opition = "<a href='javascript:showdetail("+n+")'>订单详情</a> ";
						var wuliu = "无";
						if(value.state == 0){
							state = "<font color='color'>等待买家付款</font>";
							//提供付款按钮
							opition += "<a href='javascript:jixufukuan("+n+")'>继续付款</a> &emsp;&emsp;<a href='javascript:shanchu("+value.id+")'>删除订单</a>";
						}else if(value.state == 1){
							state = "<font color='green'>买家已付款，等待卖家发货</font>";
							//无可操作项
							
						}else if(value.state == 2){
							state = "<font color='black'>交易成功</font>";
							if(value.comment_id == 0){
								//还没评论
								opition += "<a href='javascript:pingjia("+value.id+")'>评价此商品</a>";
							}
							wuliu = value.cnumber;
						}else if(value.state == 3){
							state = "<font color='yellow'>已退款</font>";
							//无可操作项
							
						}else if(value.state == 4){
							state = "<font color='blue'>卖家已发货</font>";
							//提供确认收货按钮
							opition += "<a href='javascript:querenshouhuo("+n+")'>确认收货</a>";
							wuliu = value.cnumber;
						}
						
						$("#buylist").append("<tr><td>"+value.id+"</td><td><a target='_blank' href='<%=basePath%>goods"+value.goods.id+"'>"+value.goods.name+"</a></td><td>"+value.amout+"</td><td>"+value.prices+"</td><td>"+wuliu+"</td><td>"+update_time+"</td><td>"+state+"</td><td><div>"+opition+"</div></td></tr>"); --%>
					});
					if(pageNum == 1){
						$("#pageselect").empty();
						for(var i=0;i<result.pageCount;i++){
							$("#pageselect").append("<option value="+(i+1)+">"+(i+1)+"/"+result.pageCount+"</option>");
						}
					}
				}else{
					alert(result.data);
					$("#nodata").show();
					$("#thread").hide();
					hasData = false;
				}
			},
			dataType : "json"
		});
	}
	
	function pingjia(id){
		window.location.href="Comment.jsp?id="+id;
	}
	
	function shanchu(id){
		if(!confirm("确定要删除吗？")){return;}
		$.AMUI.progress.start();
		var path = "<%=basePath%>shanchu";
		var data = {"orderid":id};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				if(result.result == "ok"){
					alert("订单已删除");
					refresh();
				}else{
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
	
	function jixufukuan(index){
		$.AMUI.progress.start();
		var path = "<%=basePath%>jixufukuan";
		var data = {"orderno":datas[index].orders_no};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				if(result.result == "ok"){
					$("body").append(result.data);
				}else{
					self.location="<%=basePath%>welcome.jsp";
				}
			},
			dataType : "json"
		});
	}
	
	function querenshouhuo(index){
		if(!confirm("确定要确认收货吗？")){return;}
		var path = "<%=basePath%>querenshouhuo";
		var data = {"no":datas[index].orders_no};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				if(result.result == "ok"){
					refresh();
				}else{
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
	
	function page(type){
		if(type == 0){
			//上一页
			if(pageNum == 1)return;
			pageNum--;
		}else{
			//下一页
			if(!hasData)
				return;
			pageNum++;
		}
		getMyGoods();
	}
	
	function refresh(){
		getMyGoods();
	}
	
</script>
</body>
</html>