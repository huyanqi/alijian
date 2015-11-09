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
<title>已售出的商品列表</title>
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

</head>
<body>

<div class="row-fluid">
    <div class="span12 box bordered-box red-border" style="margin-bottom:0;">
        <div class="box-header red-background">
            <div class="title">待发货/收款列表</div>
            <div class="actions">
                <a href="javascript:refresh()" class="btn box-remove btn-mini btn-link"><i class="icon-refresh"></i></a>
                <Button href="#" class="btn btn-mini btn-link"></Button>
            </div>
        </div>
        <div class="box-content box-no-padding">
            <div class="responsive-table">
                <div class="scrollable-area">
                    <table class="table table-hover table-striped" style="margin-bottom:0;">
                        <thead>
                        <tr>
                            <th>
                                ID
                            </th>
                            <th>
								商品名称
                            </th>
                            <th>
								数量
                            </th>
                            <th>
								总价
                            </th>
                            <th>
								订单更新时间
                            </th>
                            <th>
								状态
                            </th>
                            <th>
								操作
                            </th>
                            <th></th>
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
        </div>
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
		var path = "<%=basePath%>get_my_sell";
		var data = {"pageNum":pageNum};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				$("#list_content").empty();
				if(result.result == "ok"){
					hasData = true;
					$("#nodata").hide();
					$("#thread").show();
					datas = result.data;
					$.each(result.data, function(n, value) {
						var update_time = moment(value.update_time.time).format("lll");
						var state;
						var opition = "";
						if(value.state == 0){
							state = "<font color='color'>等待买家付款</font>";
							//无可操作项目
						}else if(value.state == 1){
							state = "<font color='green'>买家已付款，等待卖家发货</font>";
							//需要发货按钮
							opition = "<a href='javascript:fahuo("+n+")'>发货</a>";
						}else if(value.state == 2){
							state = "<font color='black'>交易成功</font>";
							//无可操作项
						}else if(value.state == 3){
							state = "<font color='yellow'>已退款</font>";
							//无可操作项
							
						}else if(value.state == 4){
							state = "<font color='blue'>卖家已发货</font>";
							//无可操作项
							
						}
						$("#list_content").append("<tr><td>"+value.id+"</td><td><a target='_blank' href='<%=basePath%>pc/goods.jsp?id="+value.goods.id+"'>"+value.goods.name+"</a></td><td>"+value.amout+"</td><td>"+value.prices+"</td><td>"+update_time+"</td><td>"+state+"</td><td><div class='text-right'>"+opition+"</div></td></tr>");
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
	
	function fahuo(index){
		window.open('<%=basePath%>supplier/order/fahuo.jsp?id='+datas[index].orders_no);
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