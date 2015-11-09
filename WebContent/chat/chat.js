var currenttargetId;//当前聊天对象的ID
var userList = new Array();//当天聊天列表的数组,保存对象
var chatmap = new HashMap();//缓存聊天记录 key:用户ID，value:html内容


$(document).ready(function(){
	$.AMUI.progress.start();
	// 初始化。
    RongIMClient.init("n19jmcy59ovm9");
    
    initIMToken();
	    
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
			            // 判断消息类型
			            switch(message.getMessageType()){
			                case RongIMClient.MessageType.TextMessage:
			                    // do something...
			                	addLeftTextMsg(message.getSenderUserId(),message.getContent());
			                	savechathistory(message.getSenderUserId(),1,message.getContent(),0);
			                    break;
			                case RongIMClient.MessageType.ImageMessage:
			                    // do something...
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
				alert(result.data);
				window.close();
			}
		},
		dataType : "json"
	});
}

function sendText(){
	var content = $("#im_send_content").html();
	if(content == "") return;
	var msg = RongIMClient.TextMessage.obtain(content);
	var conversationtype = RongIMClient.ConversationType.PRIVATE; // 私聊
	var targetId = currenttargetId; // 目标 Id
	RongIMClient.getInstance().sendMessage(conversationtype, targetId, msg, null, {
        // 发送消息成功
        onSuccess: function () {
            console.log("Send successfully");
            addRightTextMsg(targetId,content);
            $("#im_send_content").empty();
            savechathistory(targetId,1,content,1);
        },
        onError: function (errorCode) {
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
                default :
                    info = x;
                    break;
            }
            console.alert('发送失败:' + info);
        }
    }
);
}

function getUrlParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg); //匹配目标参数
	if (r != null)
		return unescape(r[2]);
	return null; //返回参数值
}

/**
 * 添加别人发送的消息到列表中
 * @param userid 对方ID
 * @param content 文本内容
 */
function addLeftTextMsg(userid,content){
	var user = getLocalUser(userid);
	if(user != null){
		//存在有这个用户
		var html = "<li class='im_left'><div class='user_name'>"+user.name+":</div><div>"+content+"</div></li>";
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
					var html = "<li class='im_left'><div class='user_name'>"+user.name+":</div><div>"+content+"</div></li>";
					insertChatMap(userid,html);
					if(getLocalUser(userid) == null){
						userList.push(user);
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
	var html = "<li class='im_right'><div class='user_name'>:"+myname+"</div><div style='clear: both;'/><div class='content_right'>"+content+"</div></li><div style='clear: both;'/>";
	//$("#show_ly").append();
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
	var path = server+"getUserById";
	var data = {"uid":toid};
	$.ajax({
		type : 'POST',
		data : data,
		url : path,
		success : function(result) {
			if (result.result == "ok") {
				result = result.data;
				userList.push(result);
				$("#user_list_ly").append("<li><a id='user_"+result.id+"' onclick='javascript:selectUser("+result.id+")'>"+result.name+"</a></li>");
			}
		},
		dataType : "json"
	});
}

function insertUserListFromObject(userObject){
	userList.push(userObject);
	$("#user_list_ly").append("<li><a id='user_"+userObject.id+"' onclick='javascript:selectUser("+userObject.id+")'>"+userObject.name+"</a></li>");
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

/**
 * 获取聊天列表
 */
function getUserList(){
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
}

/**
 * 保存聊天记录
 * @param targetid 对方ID
 * @param type 消息类型
 * @param content 消息内容
 * @param ismy 是否是我发送的 0:不是 1:是我发送的
 */
function savechathistory(targetid,type,content,ismy){
	var path = server+"savechathistory";
	var data = '{"targetid":"'+targetid+'","type":'+type+',"ismy":'+ismy+',"content":"'+content+'"}';
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
							addLeftTextMsg(value.targetid,value.content);
						}else{
							addRightTextMsg(value.targetid,value.content);
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