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
<title>讲师管理页</title>
<!-- base -->
<link href='<%=basePath%>assets/stylesheets/bootstrap/bootstrap.css' media='all' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>assets/stylesheets/jquery_ui/jquery-ui-1.10.0.custom.css' media='all' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>assets/stylesheets/light-theme.css' id='color-settings-body-color' media='all' rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="<%=basePath%>assets/amazeui/assets/css/amazeui.min.css">
<!-- ---- -->

</head>
<body>

<div class="row-fluid">
    <div class="span12 box bordered-box red-border">
        <div class="box-header red-background">
            <div class="title">
                <i class="icon-coffee"></i>
                商品信息编辑表单
            </div>
        </div>
        <div class="box-content box-double-padding">
            <form class="form" style="margin-bottom: 0;">
                <fieldset>
                    <div class="span4">
                        <div class="lead">
                            <i class="icon-github text-contrast"></i>
                            商品基本信息
                        </div>
                        <input accept="image/jpeg" type="file" name="upload" id="fileupload_input" style="visibility: hidden;"/>
                        <a href="javascript:toUpload();"><img id="thum" src="<%=basePath%>assets/images/avatar_default.png" width="260px" height="300px" /></a>
                    </div>
                    <div class="span7 offset1">
                        <div class="control-group">
                            <label class="control-label">商品名称</label>
                            <div class="controls">
                                <input class="span12" id="full-name" type="text">
                                </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">单价</label>
                            <div class="controls">
                                <input class="span12" id="price" type="text" placeholder="如:10">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">单位</label>
                            <div class="controls">
                                <input class="span12" id="units" type="text" placeholder="如:箱">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">运费</label>
                            <div class="controls">
                                <input class="span12" id="freight" type="text" placeholder="如:包邮、10箱包邮、10元/箱">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">商品所属类型(按住ctrl可多选)</label>
                            <div class="controls">
                                <select id="inputSelectMulti" multiple="multiple">
                                </select>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <hr class="hr-normal">
                <fieldset>
                <div class="span4">
                        <div class="lead">
                            <i class="icon-github text-contrast"></i>
                            商品详细信息
                        </div>
                    </div>
                    <div class="row-fluid">
                    <div class="span12 box">
                        <div class="box-content">
                            <textarea name="editor1" id="editor1" style="width: 100%;" rows="10">
				            </textarea>
                        </div>
                    </div>
                </div>
                </fieldset>
                <div class="form-actions" style="margin-bottom: 0;">
                    <div class="text-right">
                        <div class="btn btn-danger btn-large" onclick="save();">
                            <i class="icon-save"></i>
                            Save
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script src='<%=basePath%>resources/jquery-1.8.2.min.js'></script>
<script src="<%=basePath%>assets/amazeui/assets/js/amazeui.min.js"></script>
<script src="<%=basePath%>assets/javascripts/ckeditor/ckeditor.js"></script>

<script src="<%=basePath%>assets/javascripts/jquery_ui/jquery-ui.min.js"></script>
<script src="<%=basePath%>assets/javascripts/fileupload/jquery.iframe-transport.js"></script>
<script src="<%=basePath%>assets/javascripts/fileupload/jquery.fileupload.js"></script>

<script type="text/javascript">
	var id; 
	$(document).ready(function() {
		
		id = getUrlParam("id");
		
		CKEDITOR.replace( 'editor1' ,{
		    filebrowserBrowseUrl: '/browser/browse.php',
		    filebrowserUploadUrl: '<%=basePath%>ckfileupload',
		});
		
		CKEDITOR.on('instanceReady', function(e) {
			getTypeModelByType();
		})
		
		$("#fileupload_input").fileupload({
		    url:"<%=basePath%>fileupload",//文件上传地址，当然也可以直接写在input的data-url属性内
		    //formData:{"name":"p1","age":2},//如果需要额外添加参数可以在这里添加
		    done:function(e,result){
		        //done方法就是上传完毕的回调函数，其他回调函数可以自行查看api
		        //注意result要和jquery的ajax的data参数区分，这个对象包含了整个请求信息
		        //返回的数据在result.result中，假设我们服务器返回了一个json对象
		        var obj = eval('(' + result.result + ')');
		        if(obj.result == "ok"){
		        	$("#thum").attr("src",obj.data);
		        	$("#thum").attr("alt",obj.data);
		        }else{
		        	alert(obj.data);
		        }
		    }
		});
		
	});
	
	function getGoodsModelById(){
		$.AMUI.progress.start();
		var path = "<%=basePath%>getGoodsModelById";
		var data = {"id":id};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				if (result.result == "ok") {
					var data = result.data;
					$("#thum").attr("src",data.thum);
					$("#thum").attr("alt",data.thum);
					$("#full-name").val(data.name);
					$("#price").val(data.price);
					$("#units").val(data.units);
					$("#freight").val(data.freight);
					
					CKEDITOR.instances.editor1.setData(data.description);
					var types = data.types.split(",");
					$.each(types, function(n, value) {
						$("#inputSelectMulti").find("option[value="+value+"]").attr("selected",true);
					});
				} else {
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
	
	function getUrlParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg); //匹配目标参数
		if (r != null)
			return unescape(r[2]);
		return null; //返回参数值
	}
	
	function toUpload(){
		$("#fileupload_input").trigger("click");
	}
	
	function getTypeModelByType(){
		$.AMUI.progress.start();
		var path = "<%=basePath%>getTypeModelByType";
		var data = {"type":3};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				$.AMUI.progress.done();
				if(result.result == "ok"){
					$("#inputSelectMulti").empty();
					$.each(result.data, function(n, value) {
						$("#inputSelectMulti").append("<option value="+value.id+">"+value.name+"</option>");
					});
					
					if(id != null){
						getGoodsModelById();
					}
				}else{
					$("#nodata").show();
					$("#thread").hide();
				}
			},
			dataType : "json"
		});
	}
	
	function save(){
		
		var thum = $("#thum").attr("alt");
		var name = $("#full-name").val();
		var price = $("#price").val();
		var units = $("#units").val();
		var freight = $("#freight").val();
		var stem = CKEDITOR.instances.editor1.getData();
		if(thum == null){
			alert("请上传商品图片");
			return;
		}
		if(name == ""){
			alert("请输入商品名称");
			return;
		}
		if(price == ""){
			alert("请输入商品价格");
			return;
		}
		if(units == ""){
			alert("请填写商品单位");
			return;
		}
		if(freight == ""){
			alert("请设置运费");
			return;
		}
		var group_list = "";
		$('#inputSelectMulti option:selected').each(function(){
			group_list += $(this).val()+",";
		});
		if(group_list != ""){
			group_list = group_list.substring(0, group_list.length - 1);
		}
		if(group_list == ""){
			alert("请选择商品类型");
			return;
		}
		if(stem == ""){
			alert("请录入商品详细信息");
			return;
		}
		
		var data = JSON.stringify({id:id,name:name,price:price,types:group_list,units:units,freight:freight,thum:thum,description:stem});

		$.ajax({
			type : 'POST',
			data : data,
			dataType : "json",
			contentType : "application/json ; charset=utf-8", 
			url : "<%=basePath%>insertGoods",
			success : function(result) {
				if(result.result = "ok"){
					alert("商品信息已保存.");
					if(id != null){
						history.go(-1); 
						location.reload();
					}else{
						location.reload();
					}
				}else{
					alert(result.data);
				}
			},
			dataType : "json"
		});
	}
	
</script>
</body>
</html>