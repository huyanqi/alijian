var currenttargetId;//当前聊天对象的ID
var userList = new Array();//当天聊天列表的数组,保存对象
var chatmap = new HashMap();//缓存聊天记录 key:用户ID，value:html内容


$(document).ready(function(){
	$.AMUI.progress.start();
	// 初始化。
    RongIMClient.init("n19jmcy59ovm9");
    
    initIMToken();
    
    $("#fileupload_input").fileupload({
        url: server+"fileupload",//文件上传地址，当然也可以直接写在input的data-url属性内
        //formData:{"name":"p1","age":2},//如果需要额外添加参数可以在这里添加
        done:function(e,result){
            //done方法就是上传完毕的回调函数，其他回调函数可以自行查看api
            //注意result要和jquery的ajax的data参数区分，这个对象包含了整个请求信息
            //返回的数据在result.result中，假设我们服务器返回了一个json对象
            var obj = eval('(' + result.result + ')');
            if(obj.result == "ok"){
            	sendImg(obj.data);
            }else{
            	alert(obj.data);
            }
        }
    });
    
});

function initIMToken(){
	$.ajax({
		type : 'POST',
		data : {},
		url : server+"getIMToken",
		success : function(result) {
			if (result.result == "ok") {
		    	var token = result.data;
			    
		    	// 消息监听器
			     RongIMClient.getInstance().setOnReceiveMessageListener({
			        // 接收到的消息
			        onReceived: function (message) {
			        	document.getElementById('im_ring').play();
			        	showRedPoint(message.getSenderUserId());
			            // 判断消息类型
			            switch(message.getMessageType()){
			                case RongIMClient.MessageType.TextMessage:
			                    // do something...
			                	addLeftTextMsg(message.getSenderUserId(),message.getContent(),message.getSentTime());
			                	savechathistory(message.getSenderUserId(),1,message.getContent(),0,message.getSentTime());
			                    break;
			                case RongIMClient.MessageType.ImageMessage:
			                	var url = server + message.getContent();
								var html = '<img style="max-width: 300px;" src="'+message.getImageUri()+'"/>';
								addLeftTextMsg(message.getSenderUserId(),html,message.getSentTime());
								savechathistory(message.getSenderUserId(), 2, message.getExtra(), 0,message.getSentTime());								
			                    break;
			                case RongIMClient.MessageType.VoiceMessage:
			                    // do something...
			                    break;
			                case RongIMClient.MessageType.RichContentMessage:
			                    // do something...
			                    break;
			                case RongIMClient.MessageType.LocationMessage:
			                    // do something...
			                    break;
			                case RongIMClient.MessageType.DiscussionNotificationMessage:
			                    // do something...
			                    break;
			                case RongIMClient.MessageType.InformationNotificationMessage:
			                    // do something...
			                    break;
			                case RongIMClient.MessageType.ContactNotificationMessage:
			                    // do something...
			                    break;
			                case RongIMClient.MessageType.ProfileNotificationMessage:
			                    // do something...
			                    break;
			                case RongIMClient.MessageType.CommandNotificationMessage:
			                    // do something...
			                    break;
			                case RongIMClient.MessageType.UnknownMessage:
			                    // do something...
			                    break;
			                default:
			                    // 自定义消息
			                    // do something...
			            }
			        }
			    });
			 
				  // 设置连接监听状态 （ status 标识当前连接状态）
				     // 连接状态
				     RongIMClient.setConnectionStatusListener({
				        onChanged: function (status) {
				            switch (status) {
				                    //链接成功
				                    case RongIMClient.ConnectionStatus.CONNECTED:
				                        console.log('链接成功');
				                        $.AMUI.progress.done();
				                        initUserList();
				                        getchathistory();
				                        break;
				                    //正在链接
				                    case RongIMClient.ConnectionStatus.CONNECTING:
				                        console.log('正在链接');
				                        break;
				                    //重新链接
				                    case RongIMClient.ConnectionStatus.RECONNECT:
				                        console.log('重新链接');
				                        break;
				                    //其他设备登陆
				                    case RongIMClient.ConnectionStatus.OTHER_DEVICE_LOGIN:
				                    //连接关闭
				                    case RongIMClient.ConnectionStatus.CLOSURE:
				                    //未知错误
				                    case RongIMClient.ConnectionStatus.UNKNOWN_ERROR:
				                    //登出
				                    case RongIMClient.ConnectionStatus.LOGOUT:
				                    //用户已被封禁
				                    case RongIMClient.ConnectionStatus.BLOCK:
				                        break;
				            }
				        }});
			    
			 	// 连接IM服务器。
		        RongIMClient.connect(token,{
		                onSuccess: function (userId) {
		                    // 此处处理连接成功。
		                    console.log("Login successfully." + userId);
		                },
		                onError: function (errorCode) {
		                    // 此处处理连接错误。
		                    var info = '';
		                    switch (errorCode) {
		                           case RongIMClient.callback.ErrorCode.TIMEOUT:
		                                info = '超时';
		                                break;
		                           case RongIMClient.callback.ErrorCode.UNKNOWN_ERROR:
		                                info = '未知错误';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.UNACCEPTABLE_PROTOCOL_VERSION:
		                                info = '不可接受的协议版本';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.IDENTIFIER_REJECTED:
		                                info = 'appkey不正确';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.SERVER_UNAVAILABLE:
		                                info = '服务器不可用';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.TOKEN_INCORRECT:
		                                info = 'token无效';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.NOT_AUTHORIZED:
		                                info = '未认证';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.REDIRECT:
		                                info = '重新获取导航';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.PACKAGE_ERROR:
		                                info = '包名错误';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.APP_BLOCK_OR_DELETE:
		                                info = '应用已被封禁或已被删除';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.BLOCK:
		                                info = '用户被封禁';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.TOKEN_EXPIRE:
		                                info = 'token已过期';
		                                break;
		                           case RongIMClient.ConnectErrorStatus.DEVICE_ERROR:
		                                info = '设备号错误';
		                                break;
		                    }
		                    console.log("失败:" + info);
		                }
		            });
			}else{
				$.AMUI.progress.done();
				alert(result.data);
			}
		},
		dataType : "json"
	});
}

function sendText() {
	var content = $("#im_send_content").val();
	if (content == "")
		return;
	var msg = RongIMClient.TextMessage.obtain(content);
	var conversationtype = RongIMClient.ConversationType.PRIVATE; // 私聊
	var targetId = currenttargetId; // 目标 Id
	RongIMClient.getInstance().sendMessage(conversationtype, targetId, msg,
			null, {
				// 发送消息成功
				onSuccess : function() {
					console.log("Send successfully");
					addRightTextMsg(targetId, content);
					$("#im_send_content").val("");
					savechathistory(targetId, 1, content, 1, new Date().getTime());
				},
				onError : function(errorCode) {
					var info = '';
					switch (errorCode) {
					case RongIMClient.callback.ErrorCode.TIMEOUT:
						info = '超时';
						break;
					case RongIMClient.callback.ErrorCode.UNKNOWN_ERROR:
						info = '未知错误';
						break;
					case RongIMClient.SendErrorStatus.REJECTED_BY_BLACKLIST:
						info = '在黑名单中，无法向对方发送消息';
						break;
					case RongIMClient.SendErrorStatus.NOT_IN_DISCUSSION:
						info = '不在讨论组中';
						break;
					case RongIMClient.SendErrorStatus.NOT_IN_GROUP:
						info = '不在群组中';
						break;
					case RongIMClient.SendErrorStatus.NOT_IN_CHATROOM:
						info = '不在聊天室中';
						break;
					default:
						info = x;
						break;
					}
					alert("发送失败:"+info);
				}
			});
}

function sendImg(url) {
	var htmlUrl = server+url;
	var image = new RongIMClient.ImageMessage({"content":"","imageUri":htmlUrl,"extra":url});
	var conversationtype = RongIMClient.ConversationType.PRIVATE; // 私聊
	var targetId = currenttargetId; // 目标 Id
	RongIMClient.getInstance().sendMessage(conversationtype, targetId, image,
			null, {
				// 发送消息成功
				onSuccess : function() {
					console.log("Send successfully");
					var html = '<img style="max-width: 300px;" src="'+htmlUrl+'"/>';
					addRightTextMsg(targetId, html);
					savechathistory(targetId, 2, url, 1,new Date().getTime());
				},
				onError : function(errorCode) {
					var info = '';
					switch (errorCode) {
					case RongIMClient.callback.ErrorCode.TIMEOUT:
						info = '超时';
						break;
					case RongIMClient.callback.ErrorCode.UNKNOWN_ERROR:
						info = '未知错误';
						break;
					case RongIMClient.SendErrorStatus.REJECTED_BY_BLACKLIST:
						info = '在黑名单中，无法向对方发送消息';
						break;
					case RongIMClient.SendErrorStatus.NOT_IN_DISCUSSION:
						info = '不在讨论组中';
						break;
					case RongIMClient.SendErrorStatus.NOT_IN_GROUP:
						info = '不在群组中';
						break;
					case RongIMClient.SendErrorStatus.NOT_IN_CHATROOM:
						info = '不在聊天室中';
						break;
					default:
						info = x;
						break;
					}
					console.alert('发送失败:' + info);
				}
			});
}

function getUrlParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg); // 匹配目标参数
	if (r != null)
		return unescape(r[2]);
	return null; // 返回参数值
}

/**
 * 添加别人发送的消息到列表中
 * 
 * @param userid
 *            对方ID
 * @param content
 *            文本内容
 */
function addLeftTextMsg(userid,content,timestamp){
	if(timestamp != null){
		timestamp = moment(timestamp).format("YYYY MMMM Do h:mm:ss");
	}
	
	var user = getLocalUser(userid);
	if(content.indexOf("<img ") != 0){
		content = text2emoji(content);
	}
	if(user != null){
		//存在有这个用户
		var html = "<li class='im_left'><div class='user_name'>"+user.name+":</div><div style='margin-top:5px;'>"+content+"</div><div style='margin-top:5px;'>"+timestamp+"</div></li>";
		insertChatMap(userid,html);
	}else{
		var path = server+"getUserById";
		var data = {"uid":userid};
		$.ajax({
			type : 'POST',
			data : data,
			url : path,
			success : function(result) {
				if (result.result == "ok") {
					var user = result.data;
					var html = "<li class='im_left'><div class='user_name'>"+user.name+":</div><div style='margin-top:5px;'>"+content+"</div><div style='margin-top:5px;'>"+timestamp+"</div></li>";
					addUserListToServer(user.id);
					insertChatMap(userid,html);
					if(getLocalUser(userid) == null){
						insertUserListFromObject(user);
					}
				}
			},
			dataType : "json"
		});
	}
}

/**
 * 调价我发送的消息到列表中
 * @param userid 对方ID
 * @param content 文本内容
 */
function addRightTextMsg(userid,content){
	var myname = "我";
	if(content.indexOf("<img ") != 0){
		content = text2emoji(content);
	}
	var html = "<li class='im_right'><div class='user_name'>:"+myname+"</div><div style='clear: both;'/><div class='content_right' style='margin-top:5px;'>"+content+"</div></li><div style='clear: both;'/>";
	insertChatMap(userid,html);
}

/**
 * 初始化用户列表，可以从网络获取
 */
function initUserList(){
	
	var toid = getUrlParam("chat");
	currenttargetId = toid+"";
	//直接添加当前对象到聊天列表中
	insertUserListFromServer(toid);
	//再添加到服务器聊天列表中
	addUserListToServer(toid);
	
	//从服务器获取以往聊天列表
	getUserListFromServer();
	
}

/**
 * 添加聊天对象到列表中
 * @param UserModel
 */
function insertUserListFromServer(toid){
	if(toid == null) return;
	var path = server+"getUserById";
	var data = {"uid":toid};
	$.ajax({
		type : 'POST',
		data : data,
		url : path,
		success : function(result) {
			if (result.result == "ok") {
				result = result.data;
				insertUserListFromObject(result);
			}
		},
		dataType : "json"
	});
}

function insertUserListFromObject(userObject){
	if(getLocalUser(userObject.id) != null) return;
	userList.unshift(userObject);
	//userList.push(userObject);
	$("#user_list_ly").append("<li><a id='user_"+userObject.id+"' onclick='javascript:selectUser("+userObject.id+")'><img id='dot"+userObject.id+"' style='margin-right:10px;display:none;' src='"+server+"chat/dot_red.png' />"+userObject.name+"</a></li>");
}

function getLocalUser(userid){
	for(var i=0;i<userList.length;i++){
		 if(userList[i].id == userid){
			 return userList[i];
		 }
	}
	return null;
}

/**
 * 保存用户到聊天列表中
 * @param userid
 */
function addUserListToServer(userid){
	if(userid == null) return;
	var path = server+"saveUserList";
	var data = {"userid":userid};
	$.ajax({
		type : 'POST',
		data : data,
		url : path,
		success : function(result) {
			if (result.result == "ok") {
				//聊天列表已保存
			}
		},
		dataType : "json"
	});
}

function selectUser(userid){
	$("#user_"+currenttargetId).removeClass("active");//清除之前聊天对象的选中状态
	currenttargetId = userid+"";
	$("#user_"+currenttargetId).addClass("active");//设置选中状态
	//修改标题显示为当前聊天对象名称：
	$("#content_title").html(getLocalUser(userid).name);
	//刷新界面右侧栏的聊天内容
	showUserMsg(userid);
	//隐藏小红点
	hideRedPoint(userid);
}

/**
 * 保存聊天记录
 * @param targetid 对方ID
 * @param type 消息类型
 * @param content 消息内容
 * @param ismy 是否是我发送的 0:不是 1:是我发送的
 * @param senttime 消息发送时间戳
 */
function savechathistory(targetid,type,content,ismy,senttime){
	var path = server+"savechathistory";
	var data = '{"targetid":"'+targetid+'","type":'+type+',"ismy":'+ismy+',"content":"'+content+'","sentTime":'+senttime+'}';
	$.ajax({
		type : 'POST',
		dataType : "json",
		contentType : "application/json ; charset=utf-8",
		data : data,
		url : path,
		success : function(result) {
			if (result.result == "ok") {
				console.log('聊天记录已保存');
			} else {
				alert(result.data);
			}
		},
		dataType : "json"
	});
}

function getchathistory(){
	var path = server+"getchathistory";
	var data = {};
	$.ajax({
		type : 'POST',
		data : data,
		url : path,
		success : function(result) {
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					/*if(getLocalUser(value.targetModel.id) == null){
						insertUserListFromObject(value.targetModel);
					}*/
					if(value.type == 1){
						if(value.ismy == 0){
							addLeftTextMsg(value.targetid,value.content,value.sentTime);
						}else{
							addRightTextMsg(value.targetid,value.content);
						}
					}else if(value.type == 2){
						var url = server + value.content;
						var html = '<img style="max-width: 300px;" src="'+url+'"/>';
						if(value.ismy == 0){
							addLeftTextMsg(value.targetid,html,value.sentTime);
						}else{
							addRightTextMsg(value.targetid,html);
						}
					}
				});
			}
		},
		dataType : "json"
	});
}

/**
 * 从服务器获取我的聊天列表
 */
function getUserListFromServer(){
	var path = server+"getUserList";
	$.ajax({
		type : 'POST',
		data : {},
		url : path,
		success : function(result) {
			if (result.result == "ok") {
				$.each(result.data, function(n, value) {
					if(getLocalUser(value.targetModel.id) == null){
						insertUserListFromObject(value.targetModel);
					}
				});
			}
		},
		dataType : "json"
	});
}

/**
 * 添加聊天记录到缓存中
 */
function insertChatMap(userid,html){
	if(chatmap.get(userid) != null){
		chatmap.put(userid,chatmap.get(userid)+html);
	}else{
		chatmap.put(userid,html);
	}
	if(userid == currenttargetId){
		//当前聊天对象就是新存消息的对象，直接显示html
		//showUserMsg(userid);
		selectUser(userid);
	}
}

/**
 * 消息该聊天对象的聊天内容
 * @param userid
 */
function showUserMsg(userid){
	$("#show_ly").empty();
	$("#show_ly").append(chatmap.get(userid));
	$("#show_ly").scrollTop($("#show_ly")[0].scrollHeight);
}

/**
 * 文本转表情的img标签
 */
function text2emoji(str){
	str = str.replace(/\</g,'&lt;');
	str = str.replace(/\>/g,'&gt;');
	str = str.replace(/\n/g,'<br/>');
	str = str.replace(/\[em_([0-9]*)\]/g,'<img src="'+server+'font/emoji/face/$1.gif" border="0" />');
	return str;
}

/**
 * 显示小红点
 * @param userid
 */
function showRedPoint(userid){
	//alert("显示用户"+userid+"的小红点");
	if(currenttargetId != userid)
		$("#dot"+userid).show();
}

function hideRedPoint(userid){
	$("#dot"+userid).hide();
}

function HashMap(){
	//定义长度
	var length = 0;
	//创建一个对象
	var obj = new Object();

	/**
	* 判断Map是否为空
	*/
	this.isEmpty = function(){
		return length == 0;
	};

	/**
	* 判断对象中是否包含给定Key
	*/
	this.containsKey=function(key){
		return (key in obj);
	};

	/**
	* 判断对象中是否包含给定的Value
	*/
	this.containsValue=function(value){
		for(var key in obj){
			if(obj[key] == value){
				return true;
			}
		}
		return false;
	};

	/**
	*向map中添加数据
	*/
	this.put=function(key,value){
		if(!this.containsKey(key)){
			length++;
		}
		obj[key] = value;
	};

	/**
	* 根据给定的Key获得Value
	*/
	this.get=function(key){
		return this.containsKey(key)?obj[key]:null;
	};

	/**
	* 根据给定的Key删除一个值
	*/
	this.remove=function(key){
		if(this.containsKey(key)&&(delete obj[key])){
			length--;
		}
	};

	/**
	* 获得Map中的所有Value
	*/
	this.values=function(){
		var _values= new Array();
		for(var key in obj){
			_values.push(obj[key]);
		}
		return _values;
	};

	/**
	* 获得Map中的所有Key
	*/
	this.keySet=function(){
		var _keys = new Array();
		for(var key in obj){
			_keys.push(key);
		}
		return _keys;
	};

	/**
	* 获得Map的长度
	*/
	this.size = function(){
		return length;
	};

	/**
	* 清空Map
	*/
	this.clear = function(){
		length = 0;
		obj = new Object();
	};
}