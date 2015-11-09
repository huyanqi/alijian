/**
 * Created by JKZ on 2015/6/9.
 */

(function()
{
	var chatuid = 0;
	//var host = "http://"+location.hostname+"/";
	var host = "http://"+location.hostname+":8080/ALiJian/";
    window.IM = window.IM ||
        {
            _appid : '8a48b5514ff923b4014ffa403f410481', //应用ID
            _onUnitAccount : 'KF10089', //多渠道客服帐号，目前只支持1个
            _3rdServer : host+'genSig', //3rdServer，主要用来虚拟用户服务器获取SIG

            /** 以下不要动，不需要改动 */
            _timeoutkey : null,
            _username : null,
            _user_account : null,
            _contact_type_c : 'C', //代表联系人
            _contact_type_g : 'G', //代表群组
            _contact_type_m : 'M', //代表多渠道客服
            _onMsgReceiveListener : null,
            _onDeskMsgReceiveListener : null,
            _noticeReceiveListener : null,
            _onConnectStateChangeLisenter : null,
            _isMcm_active : false,
            _local_historyver : 0,
            _msgId : null,//消息ID，查看图片时有用
            _pre_range : null,//pre的光标监控对象
            _pre_range_num : 0, //计数，记录pre中当前光标位置，以childNodes为单位

            /**
             * 初始化
             * @private
             */
            init : function(uid){
            	chatuid = uid;
                //if(!window.applicationCache){
                //    var r = confirm('您的浏览器不支持HTML5，请升级浏览器版本或更换其他浏览器！');
                //    if(r == true || r == false) window.close();
                //    return;
                //}
                //if(!(window.WebSocket) ){
                //    alert('您的浏览器不支持HTML5，请升级浏览器版本或更换其他浏览器！');
                //    window.close();
                //    return;
                //}

                //初始化SDK
                var resp = RL_YTX.init(IM._appid);
                if(!resp){
                    alert('SDK初始化错误');
                    return;
                }

                if(211001 == resp.code){//不支持HTML5
                    //console.log(resp.msg);
                    var r = confirm(resp.msg);
                    if(r == true || r == false) window.close();
                }else if(211002 == resp.code){//缺少必要参数
                    console.log(resp.msg);
                }else if(200 == resp.code){//初始化成功
                    $('#navbar_login').show();
                    $('#navbar_login_show').hide();

                    //重置页面高度变化
                    IM.HTML_resetHei();

                    window.onresize = function(){
                        IM.HTML_resetHei();
                    };

                    //初始化表情
                    IM.initEmoji();
                    //初始化一些页面需要绑定的事件
                    IM.initEvent();
                    //登录
                    IM.DO_login();
                }else{
                    console.log('未知状态码');
                }
            },

            /**
             * 初始化一些页面需要绑定的事件
             */
            initEvent : function(){
                //群组add按钮下拉框，显示与隐藏的事件
                var im_add = $('#im_add');
                im_add.find('button[data-toggle="dropdown"]').focus(function(){
                    $(this).parent().addClass('open');
                });
                im_add.find('ul').focus(function(){
                    $(this).parent().addClass('open');
                });
                im_add.find('button[data-toggle="dropdown"]').blur(function(){
                    setTimeout(function(){
                        $('#im_add').find('button[data-toggle="dropdown"]').parent().removeClass('open');
                    }, 200);
                });

                //pre内光标插入事件绑定
                //IM._pre_range = new TextareaEditor( document.getElementById('im_send_content') );
                $('#im_send_content')
                    //.bind('mouseup', function(){
                    //    IM.DO_pre_replace_content();
                    //    IM.DO_pre_range_num('mouseup');
                    //})
                    //.bind('keyup', function(){
                    //    IM.DO_pre_replace_content();
                    //    IM.DO_pre_range_num('keyup');
                    //})
                    //.bind('focus', function(){
                    //    IM.DO_pre_range_num('focus');
                    //})
                    .bind('paste', function(){
                        IM.DO_pre_replace_content();
                    });
            },

            /**
             * 初始化表情
             */
            initEmoji : function(){
                var emoji_div = $('#emoji_div').find('div[class="popover-content"]');
                for(var i in emoji.show_data){
                    var c = emoji.show_data[i];
                    var out = emoji.replace_unified(c[0][0]);

                    var content_emoji = '<span style="cursor:pointer; margin: 0 2px 0 4px;" onclick="IM.DO_chooseEmoji(\''+ i +'\', \''+ c[0][0] +'\')" imtype="content_emoji">'+ out +'</span>';

                    emoji_div.append(content_emoji);
                }

            },

            /**
             * 监控键盘
             * @param event
             * @constructor
             */
            _keyCode_1 : 0,
            _keyCode_2 : 0,
            EV_keyCode : function(event){
                IM._keyCode_1 = IM._keyCode_2;
                IM._keyCode_2 = event.keyCode;

                //17=Ctrl  13=Enter
                if(17 == IM._keyCode_1 && 13 == IM._keyCode_2){
                    if('none' == $('#navbar_login').css('display')){
                        IM.DO_sendMsg();
                    }
                }else if(17 != IM._keyCode_1 && 13 == IM._keyCode_2){
                    if('block' == $('#navbar_login').css('display')){
                        IM.DO_login();
                    }
                }
            },

            DO_login : function(){
                //$('#navbar_user_account').attr("readonly","readonly");
            	var user_account = encodeURI($.AMUI.utils.cookie.get("username"));
            	alert(user_account);
                IM._login(user_account);
            },

            /**
             * 正式处理登录逻辑，此方法可供断线监听回调登录使用
             * 获取时间戳，获取SIG，调用SDK登录方法
             * @param user_account
             * @private
             */
            _login : function(user_account){
                var timestamp = IM._getTimeStamp();
                IM._privateLogin(user_account, timestamp, function(obj){
                    IM.EV_login(user_account, obj.sig, timestamp);
                }, function(obj){
                    $('#navbar_user_account').removeAttr("readonly");
                    alert(obj.msg);
                });
            },

            /**
             * SIG获取
             * 去第三方（客服）服务器获取SIG信息
             * 并将SIG返回，传给SDK中的登录方法做登录使用
             * @param user_account
             * @param timestamp -- 时间戳要与SDK登录方法中使用的时间戳一致
             * @param callback
             * @param onError
             * @private
             */
            _privateLogin : function(user_account, timestamp, callback, onError){
                console.log("_privateLogin:"+user_account);
                var data={"appid":IM._appid,
                    "username":user_account,
                    "timestamp":timestamp};
                var url = IM._3rdServer;
                $.ajax({
                    url:url,
                    dataType:'json',
                    data:data,
                    success:function(result) {
                    	console.log("result:"+result);
                        if(result.code!=000000){
                            var resp = {};
                            resp.code=result.code;
                            resp.msg="Get SIG fail from 3rd server!...";
                            onError(resp);
                            return ;
                        }else{
                            var resp = {};
                            resp.code=result.code;
                            resp.sig=result.sig;
                            callback(resp);
                            return ;
                        }
                    },
                    error:function(){
                        var resp = {};
                        resp.msg='Get SIG fail from 3rd server!';
                        onError(resp);
                    },
                    timeout:5000
                });
            },

            /**
             * 事件，登录
             * 去SDK中请求登录
             * @param user_account
             * @param sig
             * @param timestamp -- 时间戳要与生成SIG参数的时间戳保持一致
             * @constructor
             */
            EV_login :　function(user_account, sig, timestamp){
                console.log("EV_login");

                //$('#navbar_user_account').addClass('input-xlarge');
                var loginBuilder = new RL_YTX.LoginBuilder(1, user_account, '', sig, timestamp);
                RL_YTX.login(loginBuilder, function(obj){
                    console.log("EV_login succ...");

                    IM._user_account = user_account;
                    IM._username = user_account;
                    //注册PUSH监听
                    IM._onMsgReceiveListener = RL_YTX.onMsgReceiveListener(function(obj){
                        IM.EV_onMsgReceiveListener(obj);
                    });
                    //注册客服消息监听
                    IM._onDeskMsgReceiveListener = RL_YTX.onDeskMsgReceiveListener(function(obj){
                        IM.EV_onMsgReceiveListener(obj);
                    });
                    //注册群组通知事件监听
                    IM._noticeReceiveListener = RL_YTX.onNoticeReceiveListener(function(obj){
                        IM.EV_noticeReceiveListener(obj);
                    });
                    //服务器连接状态变更时的监听
                    IM._onConnectStateChangeLisenter = RL_YTX.onConnectStateChangeLisenter(function(obj){
                        //obj.code;//变更状态 1 断开连接 2 重练中 3 重练成功 4 被踢下线 5 断线需要人工重连
                        if(1 == obj.code){
                            console.log('onConnectStateChangeLisenter obj.code:'+ obj.msg);
                        }else if(2 == obj.code){
                            IM.HTML_showAlert('alert-warning', '网络状况不佳，正在试图重连服务器', 10*60*1000);
                            //IM.HTML_closeAlert();
                        }else if(3 == obj.code){
                            IM.HTML_showAlert('alert-success', '连接成功');
                        }else if(4 == obj.code){
                            IM.DO_logout();
                            alert(obj.msg);
                        }else if(5 == obj.code){
                            IM.HTML_showAlert('alert-warning', '网络状况不佳，正在试图重连服务器');
                            IM._login(IM._user_account);
                        }else{
                            console.log('onConnectStateChangeLisenter obj.code:'+ obj.msg);
                        }
                    });

                    $('#navbar_user_account').removeAttr("readonly");

                    $('#navbar_login').hide();
                    $('#navbar_login_show').show();
                    IM.EV_getMyInfo();
                    IM.HTML_LJ_none();

                    //登录后拉取群组列表
                    IM.EV_getGroupList();

                    //登录后拉取未读过的消息
                    if(IM._local_historyver <= parseInt(obj.historyver) && parseInt(obj.historyver) < parseInt(obj.version)){
                        IM._local_historyver = parseInt(obj.historyver)
                        IM.EV_syncMsg(parseInt(obj.historyver)+1, obj.version);
                    }

                    //添加客服号到列表中
                    IM.HTML_addContactToList(IM._onUnitAccount, IM._onUnitAccount, IM._contact_type_m, false, false, false, null, null);
                    //添加聊天对象到列表中
                    IM.ADD_CHAT_TOLIST();
                }, function(obj){
                    $('#navbar_user_account').removeAttr("readonly");

                    alert("error code: "+ obj.code);
                });
            },
            
            ADD_CHAT_TOLIST : function(){
            	var path = host+"getUserById";
        		var data = {"uid":chatuid};
        		$.ajax({
        			type : 'POST',
        			data : data,
        			url : path,
        			success : function(result) {
        				if (result.result == "ok") {
        					var data = result.data;
        					IM.DO_addContactToList(data.username);
        				}
        			},
        			dataType : "json"
        		});
            },

            /**
             * 事件，登出
             * @constructor
             */
            EV_logout : function(){
                console.log("EV_logout");
                //IM.DO_logout();
                RL_YTX.logout(function(){
                    console.log("EV_logout succ...");
                    
                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 登出
             * @constructor
             */
            DO_logout : function(){
                //销毁PUSH监听
                IM._onMsgReceiveListener = null;
                //注册客服消息监听
                IM._onDeskMsgReceiveListener = null;
                //销毁注册群组通知事件监听
                IM._noticeReceiveListener = null;
                //服务器连接状态变更时的监听
                IM._onConnectStateChangeLisenter = null;

                //wx.closeWindow();
                //window.close();
                //history.go(-2);
                
                /*//清理左侧数据
                $('#im_contact_list').empty();
                //清理右侧数据
                $('#im_content_list').empty();

                //隐藏图片层
                IM.HTML_pop_photo_hide();

                //隐藏群组详情页面
                IM.HTML_pop_hide();

                //隐藏表情框
                $('#emoji_div').hide();

                //隐藏提示框
                IM.HTML_closeAlert('all');

                //联系人列表切换到沟通
                IM.DO_choose_contact_type('C');

                $('#navbar_login').show();
                $('#navbar_login_show').hide();
                IM.HTML_LJ_block('black');*/
            },

            /**
             * 事件，push消息的监听器，被动接收信息
             * @param obj
             * @constructor
             */
            EV_onMsgReceiveListener : function(obj){
                console.log('Receive message sender:['+ obj.msgSender +']...version:['+ obj.version +']...content['+ obj.msgContent +']');
                IM.DO_push_createMsgDiv(obj);

                //播放铃声前，查看是否是群组，如果不是直接播放，如果是查看自定义提醒类型，根据类型判断是否播放声音
                var b_isGroupMsg = ('g' == obj.msgReceiver.substr(0,1));
                if(b_isGroupMsg){
                    //1提醒，2不提醒
                    var isNotice = $('#im_contact_'+obj.msgReceiver).attr('im_isnotice');
                    if(2 != isNotice){
                        document.getElementById('im_ring').play();
                    }
                }else{
                    document.getElementById('im_ring').play();
                }
            },

            /**
             * 事件，notice群组通知消息的监听器，被动接收消息
             * @param obj
             * @constructor
             */
            EV_noticeReceiveListener : function(obj){
                console.log('notice message groupId:['+ obj.groupId +']...auditType['+ obj.auditType +']...version:['+ obj.version +']...');
                IM.DO_notice_createMsgDiv(obj);
                //播放铃声
                document.getElementById('im_ring').play();
            },

            /**
             * 事件，发送消息
             * @param msgid
             * @param text
             * @param receiver
             * @constructor
             */
            EV_sendTextMsg : function(msgid, text, receiver){
                console.log('send Text message: receiver:['+ receiver +']...connent['+ text +']...');

                var obj = new RL_YTX.MsgBuilder();
                obj.setId(msgid);
                obj.setText(text);
                obj.setType(1);
                obj.setReceiver(receiver);

                RL_YTX.sendMsg(obj, function(){
                    $('#'+receiver+'_'+msgid).find('span[imtype="resend"]').css('display', 'none');
                    console.log('send Text message succ');
                }, function(obj){
                    $('#'+receiver+'_'+msgid).find('span[imtype="resend"]').css('display', 'block');
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 事件，重发消息
             * @param msgid
             * @constructor
             */
            EV_resendMsg : function(msgid){
                var msg = $('#'+msgid);
                msgid = msgid.substring(msgid.lastIndexOf('_')+1);

                //消息类型1:文本消息 2：语音消息 3：视频消息  4：图片消息  5：位置消息  6：文件
                var msgtype = msg.attr('im_msgtype');
                var receiver = msg.attr('content_you');
                if(1 == msgtype){//文本消息
                    msg.find('span[imtype="resend"]').css('display', 'none');
                    var text = msg.find('pre[msgtype="content"]').html();
                    console.log('resend message: text['+ text +']...receiver:['+ receiver +']');
                    IM.EV_sendTextMsg(msgid, text, receiver);
                }else if(4 == msgtype || 6 == msgtype){
                    //查找当前选中的contact_type值 1、IM上传 2、MCM上传
                    var contact_type = msg.attr('content_type');
                    var oFile = msg.find('input[imtype="msg_attach_resend"]')[0].files[0];
                    console.log('resend Attach message: msgtype['+ msgtype +']...receiver:['+ receiver +']');
                    if(IM._contact_type_m == contact_type){
                        IM.EV_sendToDeskAttachMsg(msgid, oFile, msgtype, receiver);
                    }else{
                        IM.EV_sendAttachMsg(msgid, oFile, msgtype, receiver);
                    }
                }else{
                    console.log('暂时不支持附件类型消息重发');
                }
            },

            /**
             * 发送附件
             * @param msgid
             * @param file -- file对象
             * @param type -- 附件类型 2 语音消息 3 视频消息 4 图片消息 5 位置消息 6 文件消息
             * @param receiver -- 接收者
             * @constructor
             */
            EV_sendAttachMsg : function(msgid, file, type, receiver){
                console.log('send Attach message: type['+ type +']...receiver:['+ receiver +']');
                var obj = new RL_YTX.MsgBuilder();
                obj.setId(msgid);
                obj.setFile(file);
                obj.setType(type);
                obj.setReceiver(receiver);

                var msg = $('#'+receiver+'_'+msgid);
                msg.attr('msg', 'msg');
                msg.css('display', 'block');
                $('#im_content_list').scrollTop( $('#im_content_list')[0].scrollHeight );

                RL_YTX.sendMsg(obj, function(){//成功
                    msg.find('span[imtype="resend"]').css('display', 'none');
                    msg.find('div[class="bar"]').parent().css('display', 'none');
                    msg.find('span[imtype="msg_attach"]').css('display', 'block');
                    console.log('send Attach message succ');
                }, function(obj){//失败
                    msg.find('span[imtype="resend"]').css('display', 'block');
                    msg.find('div[class="bar"]').parent().css('display', 'none');
                    msg.find('span[imtype="msg_attach"]').css('display', 'block');
                    alert("error code: "+ obj.code);
                }, function(sended, total){//进度条
                    console.log('send Attach message progress:' + (sended/total*100+'%'));
                    //sended;//已发送字节数
                    //total;//总字节数
                    if(sended < total){
                        msg.find('div[class="bar"]').css('width', (sended/total*100+'%') );
                    }else{
                        msg.find('div[class="bar"]').parent().css('display', 'none');
                        msg.find('span[imtype="msg_attach"]').css('display', 'block');
                    }
                });
            },

            /**
             * 发送附件
             * @param msgid
             * @param file -- file对象
             * @param type -- 附件类型 2 语音消息 3 视频消息 4 图片消息 5 位置消息 6 文件消息
             * @param receiver -- 接收者
             * @constructor
             */
            EV_sendToDeskAttachMsg : function(msgid, file, type, receiver){
                console.log('send Attach message: type['+ type +']...receiver:['+ receiver +']');
                var obj = new RL_YTX.DeskMessageBuilder();
                obj.setMsgId(msgid);
                obj.setFile(file);
                obj.setType(type);
                obj.setOsUnityAccount(receiver);

                var msg = $('#'+receiver+'_'+msgid);
                msg.attr('msg', 'msg');
                msg.css('display', 'block');
                $('#im_content_list').scrollTop( $('#im_content_list')[0].scrollHeight );

                RL_YTX.sendToDeskMessage(obj, function(){//成功
                    msg.find('span[imtype="resend"]').css('display', 'none');
                    msg.find('div[class="bar"]').parent().css('display', 'none');
                    msg.find('span[imtype="msg_attach"]').css('display', 'block');
                    msg.attr('msg', 'msg');
                    console.log('send Attach message succ');
                }, function(obj){//失败
                    msg.find('span[imtype="resend"]').css('display', 'block');
                    msg.find('div[class="bar"]').parent().css('display', 'none');
                    msg.find('span[imtype="msg_attach"]').css('display', 'block');
                    alert("error code: "+ obj.code);
                }, function(sended, total){//进度条
                    console.log('send Attach message progress:' + (sended/total*100+'%'));
                    //sended;//已发送字节数
                    //total;//总字节数
                    if(sended < total){
                        msg.find('div[class="bar"]').css('width', (sended/total*100+'%') );
                    }else{
                        msg.find('div[class="bar"]').parent().css('display', 'none');
                        msg.find('span[imtype="msg_attach"]').css('display', 'block');
                    }
                });
            },

            /**
             * 事件，客服开始咨询
             * @param receiver -- 客服号
             * @constructor
             */
            EV_startMcmMsg : function(receiver){
                console.log('start MCM message...');
                var obj = new RL_YTX.DeskMessageStartBuilder();
                obj.setOsUnityAccount(receiver);
                obj.setUserData('');

                RL_YTX.startConsultationWithAgent(obj, function(){
                    console.log('start MCM message succ...');
                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 事件，客服停止咨询
             * @param receiver -- 客服号
             * @constructor
             */
            EV_stopMcmMsg : function(receiver){
                console.log('stop MCM message...');
                var obj = new RL_YTX.DeskMessageStopBuilder();
                obj.setOsUnityAccount(receiver);
                obj.setUserData('');

                RL_YTX.finishConsultationWithAgent(obj, function(){
                    console.log('stop MCM message succ...');
                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 事件，客服发送消息
             * @param msgid
             * @param text
             * @param receiver -- 客服号
             * @constructor
             */
            EV_sendMcmMsg : function(msgid, text, receiver){
                console.log('send MCM message...');
                var obj = new RL_YTX.DeskMessageBuilder();
                obj.setContent(text);
                obj.setUserData();
                obj.setMsgId(msgid);
                obj.setType(1);
                obj.setOsUnityAccount(receiver);

                RL_YTX.sendToDeskMessage(obj, function(){
                    $('#'+msgid).find('span[imtype="resend"]').css('display', 'none');
                    console.log('send MCM message succ...');
                }, function(obj){
                    $('#'+msgid).find('span[imtype="resend"]').css('display', 'block');
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 事件，主动拉取消息
             * @param sv
             * @param ev
             * @constructor
             */
            EV_syncMsg : function(sv, ev){
                var obj = new RL_YTX.SyncMsgBuilder();
                obj.setSVersion(sv);
                obj.setEVersion(ev);

                RL_YTX.syncMsg(obj, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 事件，获取登录者个人信息
             * @constructor
             */
            EV_getMyInfo : function(){
                RL_YTX.getMyInfo(function(obj){
                    if(!!obj && !!obj.nickName){
                        IM._username = obj.nickName;
                    }
                    $('#navbar_login_show').find('a[imtype="navbar_login_show"]').html('您好：'+ IM._username);
                    $("#hero-unit").height(document.body.scrollHeight-$("#navbar").height());
                }, function(obj){
                    if(520015 != obj.code){
                        alert("error code: "+ obj.code);
                    }
                });
            },

            /**
             * 事件，创建群组
             * @param groupName
             * @param permission
             * @constructor
             */
            EV_createGroup : function(groupName, permission){
                console.log('create group...groupName['+groupName+'] permission['+permission+']');

                var obj = new RL_YTX.CreateGroupBuilder();
                obj.setGroupName(groupName);
                obj.setPermission(permission);
                RL_YTX.createGroup(obj, function(obj){
                    var groupId = obj.data;

                    console.log('create group succ... groupId['+groupId+']');
                    IM.HTML_addContactToList(groupId, groupName, IM._contact_type_g, true, true, false, IM._user_account, 1);

                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 解散群组
             * @param groupId
             * @constructor
             */
            EV_dismissGroup : function(groupId){
                console.log('dismiss Group...');
                var obj = new RL_YTX.DismissGroupBuilder();
                obj.setGroupId(groupId);

                RL_YTX.dismissGroup(obj, function(){
                    console.log('dismiss Group SUCC...');
                    //将群组从列表中移除
                    IM.HTML_remove_contact(groupId);
                    //隐藏群组详情页面
                    IM.HTML_pop_hide();
                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 退出群组
             * @param groupId
             * @constructor
             */
            EV_quitGroup : function(groupId){
                console.log('quit Group...');
                var obj = new RL_YTX.QuitGroupBuilder();
                obj.setGroupId(groupId);

                RL_YTX.quitGroup(obj, function(){
                    console.log('quit Group SUCC...');
                    //将群组从列表中移除
                    IM.HTML_remove_contact(groupId);
                    //隐藏群组详情页面
                    IM.HTML_pop_hide();
                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 事件，获取群组详情
             * @param groupId
             * @constructor
             */
            EV_getGroupDetail : function(groupId){
                console.log('get Group Detail...');
                var obj = new RL_YTX.GetGroupDetailBuilder();
                obj.setGroupId(groupId);

                RL_YTX.getGroupDetail(obj, function(obj){
                    console.log('get Group Detail SUCC...');

                    IM.DO_pop_show_help_GroupDetail(obj, groupId);

                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 事件，获取群组列表
             * @constructor
             */
            EV_getGroupList : function(){
                var obj = new RL_YTX.GetGroupListBuilder();
                obj.setPageSize(1000)
                RL_YTX.getGroupList(obj, function(obj){
                    for(var i in obj){
                        var groupId = obj[i].groupId;
                        var groupName = obj[i].name;
                        var owner = obj[i].owner;
                        var isNotice = obj[i].isNotice;

                        IM.HTML_addContactToList(groupId, groupName, IM._contact_type_g, false, false, true, owner, isNotice);
                    }
                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 事件，获取群组成员列表
             * @param groupId
             * @param isowner
             * @constructor
             */
            EV_getGroupMemberList : function(groupId, isowner){
                console.log('get Group Member List...');
                var obj = new RL_YTX.GetGroupMemberListBuilder();
                obj.setGroupId(groupId);
                obj.setPageSize(2000);

                RL_YTX.getGroupMemberList(obj, function(obj){
                    console.log('get Group Member List SUCC...');

                    IM.DO_pop_show_help_GroupMemberList(obj,isowner, groupId);

                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 更新群组信息
             * @param groupId
             * @constructor
             */
            EV_updateGroupInfo : function(groupId){
                console.log("update groupInfo,groupId:["+groupId+"]");
                var obj = $('#pop').find('span[imtype="im_pop_group_declared"]');
                var declaredObj = obj.children();
                var declared = declaredObj.val();

                obj = $('#pop').find('div[imtype="im_pop_group_name"]');
                var nameObj = obj.children();
                var groupName = nameObj.val();

                var builder = new RL_YTX.ModifyGroupBuilder(groupId,groupName,null,null,null,null,declared);
                RL_YTX.modifyGroup(builder, function(){
                    console.log("update group info suc");
                    IM.HTML_addContactToList(groupId, groupName, IM._contact_type_g, false, true, true, null, null);
                    IM.HTML_pop_hide();
                },function(obj){
                    alert("modify group info error:"+obj.code);
                });

            },

            /**
             * 更新群组个性化设置
             * @param groupId
             * @param isNotice
             * @constructor
             */
            EV_groupPersonalization : function(groupId, isNotice){
                console.log("set group notice,groupId:["+groupId+"],isNotice["+isNotice+"]");
                var builder = new RL_YTX.SetGroupMessageRuleBuilder(groupId,isNotice);
                RL_YTX.setGroupMessageRule(builder,function(){
                    console.log("set groupNotice suc");
                    //切换btn样式
                    if(isNotice==2){
                        str =   '<a href="#" class="btn btn-primary" style="margin-left:10px;" >开启</a>' +
                            '<a href="#" class="btn" style="margin-left:10px;" onclick="IM.EV_groupPersonalization(\''+groupId+'\',1)">关闭</a>';
                    }else{
                        str =   '<a href="#" class="btn" style="margin-right:10px;" style="margin-left:10px;" onclick="IM.EV_groupPersonalization(\''+groupId+'\',2)">开启</a>' +
                            '<a href="#" class="btn btn-primary" >关闭</a>';
                    }
                    $('#pop').find('span[imtype="im_pop_group_notice"]').html(str);

                    //修改左侧联系人列表attr值
                    $('#im_contact_'+groupId).attr('im_isnotice', isNotice);
                },function(obj){
                    alert("set groupNotice error:"+obj.code);
                });
            },

            /**
             * 邀请成员加入群组
             * @param groupId
             * @param confirm
             * @constructor
             */
            EV_inviteGroupMember : function(groupId, confirm, isowner){
                var memberSts = $("#pop_invite_area").val();
                var memberArr = memberSts.split(",");
                if(memberArr.length>50){
                    alert("邀请用户过多！");
                    return ;
                }
                for(var i in memberArr){
                    if(!IM.DO_checkContact(memberArr[i])){
                        return ;
                    }
                }
                if(confirm==1){
                    confirm = 1;
                }else {
                    confirm = 2;
                }
                var builder = new RL_YTX.InviteJoinGroupBuilder(groupId,null,memberArr,confirm);
                RL_YTX.inviteJoinGroup(builder,function(){
                    IM.HTML_hideInviteArea();
                    $("#pop_invite_area").val("");
                    if(confirm == 1){
                        for(var i in memberArr){
                            IM.HTML_popAddMember(groupId,memberArr[i],memberArr[i],isowner);
                        }
                    }
                },function(obj){
                    alert("invite member error:"+obj.code)
                })
            },

            /**
             * 事件，用户申请加入确认操作
             * @param groupId 群组id 必选
             * @param memberId 成员id 必选
             * @param confirm 是否同意 必选 1 不同意 2同意
             * @constructor
             */
            EV_confirmJoinGroup : function(you_sender, version, groupId, memberId, confirm){
                console.log('confirm join group...groupId['+groupId+'] memberId['+memberId+'] confirm['+confirm+']');
                var obj = new RL_YTX.ConfirmJoinGroupBuilder();
                obj.setGroupId(groupId);
                obj.setMemberId(memberId);
                obj.setConfirm(confirm);

                RL_YTX.confirmJoinGroup(obj, function(){
                    var str = '';
                    if(1 == confirm) str = '{已拒绝}';
                    if(2 == confirm) str = '{已同意}';
                    $('#'+you_sender+'_'+ version).find('span[imtype="notice"]').html(str);
                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 事件，管理员是否同意加入群组
             * @param invitor 邀请者 必选
             * @param groupId 群组id 可选
             * @param confirm 是否同意 1 不同意 2同意
             * @constructor
             */
            EV_confirmInviteJoinGroup : function(you_sender, groupName, version, invitor, groupId, confirm){
                console.log('confirm invite join group...invitor['+invitor+'] groupId['+groupId+'] confirm['+confirm+']');
                var obj = new RL_YTX.ConfirmInviteJoinGroupBuilder();
                obj.setInvitor(invitor);
                obj.setGroupId(groupId);
                obj.setConfirm(confirm);

                RL_YTX.confirmInviteJoinGroup(obj, function(){
                    var str = '';
                    if(1 == confirm) str = '{已拒绝}';
                    if(2 == confirm) str = '{已同意}';
                    $('#'+you_sender+'_'+ version).find('span[imtype="notice"]').html(str);

                    if(2 == confirm){
                        //在群组列表中添加群组项
                        var current_contact_type = IM.HTML_find_contact_type();
                        var isShow = false;
                        if(IM._contact_type_g == current_contact_type){
                            isShow = true;
                        }
                        IM.HTML_addContactToList(groupId, groupName, IM._contact_type_g, false, isShow, false, null, null);
                    }
                }, function(obj){
                    alert("error code: "+ obj.code);
                });
            },

            /**
             * 更新群组成员禁言状态
             * @param groupId
             * @param memberId
             * @param status
             * @constructor
             */
            EV_forbidMemberSpeak : function(groupId, memberId, status){
                console.log('forbid member speakstatus groupId:['+groupId+'],memberId:['+memberId+'],status['+status+']');
                var builder = new RL_YTX.ForbidMemberSpeakBuilder(groupId,memberId,status);
                RL_YTX.forbidMemberSpeak(builder, function(){
                    var trobj = $('#pop').find('tr[contact_you="'+memberId+'"]');
                    var tdobj = trobj.children();
                    var spanobj = tdobj.children();
                    var deleobj = spanobj[1];
                    var speakobj = spanobj[2];
                    $(speakobj).remove();
                    console.log("修改成员禁言状态成功");
                    var str = '';
                    if(status==2){
                        str +=  '<span class="pull-right label label-success" imtype="im_pop_memberspeak'+memberId+'" onclick="IM.EV_forbidMemberSpeak(\''+groupId+'\',\''+memberId+'\',1)"> 恢复 </span>'
                    }else{
                        str +=  '<span class="pull-right label label-important" imtype="im_pop_memberspeak'+memberId+'" onclick="IM.EV_forbidMemberSpeak(\''+groupId+'\',\''+memberId+'\',2)"> 禁言 </span>'
                    }
                    tdobj.append(str);
                },function(obj){
                    alert('修改用户禁言状态失败 : '+obj.code);
                })
            },

            /**
             * 提出群组成语
             * @param groupId
             * @param memberId
             * @constructor
             */
            EV_deleteGroupMember : function(groupId, memberId){
                console.log("delete group member groupId:["+groupId+"],memberId:["+memberId+"]");
                var builder = new RL_YTX.DeleteGroupMemberBuilder(groupId,memberId);
                RL_YTX.deleteGroupMember(builder, function(){
                    console.log("delete group member suc");
                    IM.HTML_popDeleteMember(memberId);
                },function(obj){
                    alert("delete group member error:"+obj.code);
                });
            },





            /**
             * 事件，获取群组成员列表
             * @param obj
             * @param groupId
             * @constructor
             */
            DO_pop_show_help_GroupDetail : function(obj, groupId){
                var isowner = false;
                if(IM._user_account == obj.creator) {
                    isowner = true;
                }
                var str = '';
                if(isowner){
                    str = '<input type="text" class="pull-right" style="width:95%;" value="'+obj.groupName+'"/>';
                    $('#pop').find('div[imtype="im_pop_group_name"]').html(str);

                    if(!obj.declared){
                        obj.declared = '';
                    }
                    str = '<textarea class="pull-right" rows="5" style="width:95%;">'+obj.declared+'</textarea>';
                    $('#pop').find('span[imtype="im_pop_group_declared"]').html(str);

                    var str_add =   '<tr>' +
                                        '<td style="padding:0 0 0 0;"></td>' +
                                    '</tr>' +
                                    '<tr>' +
                                        '<td>' +
                                            '<span class="pull-left" style="width: 25%;"><a href="#" class="btn" style="font-size: 20px;" onclick="IM.HTML_showInviteArea()" >+</a></span>' +
                                            '<span class="pull-left" style="width: 25%; display: none;">' +
                                                '<a href="#" class="btn" onclick="IM.EV_inviteGroupMember(\''+groupId+'\','+obj.permission+',\''+isowner+'\')" >邀请</a>' +
                                            '</span>' +
                                            '<span class="pull-right" style="width: 75%; display: none;">' +
                                                '<textarea class="pull-left" id="pop_invite_area" style="width:95%;" rows=3 placeholder="请输入邀请用户账号，中间使用英文逗号\“,”\分隔，' +
                                                '最多邀请50个"></textarea>' +
                                            '</span>' +
                                        '</td>' +
                                    '</tr>';
                    $('#pop').find('table[imtype="im_pop_members_add"]').html(str_add);
                }else{
                    str = '<span class="pull-right" maxlength="128">'+obj.groupName+'</span>';
                    $('#pop').find('div[imtype="im_pop_group_name"]').html(str);

                    if(!obj.declared){
                        obj.declared = '';
                    }
                    str = '<span class="pull-right" maxlength="128">'+obj.declared+'</span>';
                    $('#pop').find('span[imtype="im_pop_group_declared"]').html(str);
                }
                if(obj.isNotice==1){
                    str =   '<a href="#" class="btn" style="margin-left:10px;" onclick="IM.EV_groupPersonalization(\''+groupId+'\',2)" >开启</a>' +
                        '<a href="#" class="btn btn-primary" style="margin-left:10px;">关闭</a>';
                }else{
                    str =   '<a href="#" class="btn btn-primary" style="margin-left:10px;">开启</a>' +
                        '<a href="#" class="btn" style="margin-left:10px;" onclick="IM.EV_groupPersonalization(\''+groupId+'\',1)">关闭</a>';
                }
                $('#pop').find('span[imtype="im_pop_group_notice"]').html(str);
            },

            getUnicodeCharacter : function(cp) {
                if (cp >= 0 && cp <= 0xD7FF || cp >= 0xE000 && cp <= 0xFFFF) {
                    return String.fromCharCode(cp);
                } else if (cp >= 0x10000 && cp <= 0x10FFFF) {

                    // we substract 0x10000 from cp to get a 20-bits number
                    // in the range 0..0xFFFF
                    cp -= 0x10000;

                    // we add 0xD800 to the number formed by the first 10 bits
                    // to give the first byte
                    var first = ((0xffc00 & cp) >> 10) + 0xD800

                    // we add 0xDC00 to the number formed by the low 10 bits
                    // to give the second byte
                    var second = (0x3ff & cp) + 0xDC00;

                    return String.fromCharCode(first) + String.fromCharCode(second);
                }
            },

            /**
             * 添加PUSH消息，只做页面操作
             * 供push和拉取消息后使用
             * @param obj
             * @constructor
             */
            DO_push_createMsgDiv : function(obj){
                var b_isGroupMsg = ('g' == obj.msgReceiver.substr(0,1));
                var you_sender = (b_isGroupMsg) ? obj.msgReceiver : obj.msgSender;
                var you_senderNickName = obj.senderNickName;
                var name = obj.msgSender;
                if(!!you_senderNickName){
                    name = you_senderNickName;
                }
                //push消息的联系人，是否是当前展示的联系人
                var b_current_contact_you = IM.DO_createMsgDiv_Help(you_sender, name, b_isGroupMsg);

                //是否为mcm消息 0普通im消息 1 start消息 2 end消息 3发送mcm消息
                var you_msgContent = obj.msgContent;
                var content_type = null;
                var version = obj.version;
                var time = obj.msgDateCreated;
                if(0 == obj.mcmEvent){//0普通im消息
                    //点对点消息，或群组消息
                    content_type = (b_isGroupMsg) ? IM._contact_type_g : IM._contact_type_c;
                    var msgType = obj.msgType;
                    var str = '';

                    //obj.msgType; //消息类型1:文本消息 2：语音消息 3：视频消息  4：图片消息  5：位置消息  6：文件
                    if(1 == msgType || 0 == msgType){
                        msgType = 1;
                        //str = you_msgContent;
                        //转换所有的html标记
                        //you_msgContent = you_msgContent.replace(/</g, '&lt;').replace(/>/g, '&gt;');

                        str = emoji.replace_unified(you_msgContent);
                        str = '<pre>'+ str +'</pre>';

                    }else if(2 == msgType){
                        var url = obj.msgFileUrl;
                        //str = '你接收了一条语音消息['+ url +']';
                        str = '<audio controls="controls" src="'+ url +'">your browser does not surpport the audio element</audio>';
                    }else if(3 == msgType){//3：视频消息
                        var url = obj.msgFileUrl;
                        str = '你接收了一条视频消息['+ url +']';
                    }else if(4 == msgType){//4：图片消息
                        var url = obj.msgFileUrl;
                        var windowWid = $(window).width();
                        var imgWid = 0;
                        var imgHei = 0;
                        if(windowWid < 666){
                            imgWid = 100;
                            imgHei = 150;
                        }else{
                            imgWid = 150;
                            imgHei = 200;
                        }
                        var str = '<img src="'+ url +'" style="max-width:'+ imgWid +'px; max-height:'+ imgHei +'px;" onclick="IM.DO_pop_phone(\''+you_sender+'\', \''+version+'\')"/>';
                    }else if(5 == msgType){//位置消息
                        str = '你接收了一条位置消息...';
                    }else if(6 == msgType){//文件
                        var url = obj.msgFileUrl;
                        var fileName = obj.msgFileName;
                        str = '<a href="'+ url +'" target="_blank">' +
                            '<span>' +
                            '<img style="width:32px; height:32px; margin-right:5px; margin-left:5px;" src="assets/img/attachment_icon.png" />' +
                            '</span>' +
                            '<span>'+ fileName +'</span>' +
                            '</a>';
                    }

                    IM.HTML_pushMsg_addHTML(msgType, you_sender, version, content_type, b_current_contact_you, name, str);
                }else if(1 == obj.mcmEvent){//1 start消息
                    IM.HTML_pushMsg_addHTML(obj.msgType, you_sender, version, IM._contact_type_m, b_current_contact_you, name, you_msgContent);
                }else if(2 == obj.mcmEvent){//2 end消息
                    IM.HTML_pushMsg_addHTML(obj.msgType, you_sender, version, IM._contact_type_m, b_current_contact_you, name, "结束咨询");
                }else if(3 == obj.mcmEvent){//3发送mcm消息
                    IM.HTML_pushMsg_addHTML(obj.msgType, you_sender, version, IM._contact_type_m, b_current_contact_you, name, you_msgContent);
                }else if(53 == obj.mcmEvent){//3发送mcm消息

                    content_type = IM._contact_type_m;
                    var msgType = obj.msgType;
                    var str = '';

                    //obj.msgType; //消息类型1:文本消息 2：语音消息 3：视频消息  4：图片消息  5：位置消息  6：文件
                    if(1 == msgType || 0 == msgType){
                        msgType = 1;
                        //str = you_msgContent;
                        //转换所有的html标记
                        //you_msgContent = you_msgContent.replace(/</g, '&lt;').replace(/>/g, '&gt;');

                        str = emoji.replace_unified(you_msgContent);
                        str = '<pre>'+ str +'</pre>';

                    }else if(2 == msgType){
                        var url = obj.msgFileUrl;
                        //str = '你接收了一条语音消息['+ url +']';
                        str = '<audio controls="controls" src="'+ url +'">your browser does not surpport the audio element</audio>';
                    }else if(3 == msgType){//3：视频消息
                        var url = obj.msgFileUrl;
                        str = '你接收了一条视频消息['+ url +']';
                    }else if(4 == msgType){//4：图片消息
                        var url = obj.msgFileUrl;
                        var windowWid = $(window).width();
                        var imgWid = 0;
                        var imgHei = 0;
                        if(windowWid < 666){
                            imgWid = 100;
                            imgHei = 150;
                        }else{
                            imgWid = 150;
                            imgHei = 200;
                        }
                        var str = '<img src="'+ url +'" style="max-width:'+ imgWid +'px; max-height:'+ imgHei +'px;" onclick="IM.DO_pop_phone(\''+you_sender+'\', \''+version+'\')"/>';
                    }else if(5 == msgType){//位置消息
                        str = '你接收了一条位置消息...';
                    }else if(6 == msgType){//文件
                        var url = obj.msgFileUrl;
                        var fileName = obj.msgFileName;
                        str =   '<a href="'+ url +'" target="_blank">' +
                                    '<span>' +
                                        '<img style="width:32px; height:32px; margin-right:5px; margin-left:5px;" src="assets/img/attachment_icon.png" />' +
                                    '</span>' +
                                    '<span>'+ fileName +'</span>' +
                                '</a>';
                    }

                    IM.HTML_pushMsg_addHTML(msgType, you_sender, version, content_type, b_current_contact_you, name, str);
                }
            },

            DO_pop_phone : function(you_sender, version){
                var msgId = you_sender+'_'+version;
                IM._msgId = msgId;

                //var content_list = $('#im_content_list');
                var msg = $('#'+msgId);
                var url = msg.find('img').attr('src');

                var pop_photo = $('#pop_photo');
                pop_photo.find('img').attr('src', url);

                IM.HTML_pop_photo_show();
            },

            /**
             * 向上选择图片，同一个对话框内
             * @constructor
             */
            DO_pop_photo_up : function(){
                var msg = $('#'+IM._msgId);
                if(msg.length < 1){
                    return;
                }

                //var prevMsg = msg.prevUntil('[im_msgtype="4"]');
                var index = -1;
                msg.parent().find('div[msg="msg"][im_msgtype="4"]:visible').each(function(){
                    //if('block' == $(this).css('display')){
                        index++;
                        if(IM._msgId == $(this).attr('id')){
                            index--;
                            return false;
                        }
                    //}
                });
                if(index < 0){
                    return;
                }
                var prevMsg = msg.parent().children('div[msg="msg"][im_msgtype="4"]:visible').eq(index);
                if(prevMsg.length < 1){
                    return;
                }

                var src = prevMsg.find('img').attr('src');
                $('#pop_photo').find('img').attr('src', src);

                IM._msgId = prevMsg.attr('id');
            },

            /**
             * 向下选择图片,同一个对话框内
             * @constructor
             */
            DO_pop_photo_down : function(){
                var msg = $('#'+IM._msgId);
                if(msg.length < 1){
                    return;
                }

                //var nextMsg = msg.nextUntil('[im_msgtype="4"]');
                var index = -1;
                msg.parent().find('div[msg="msg"][im_msgtype="4"]:visible').each(function(){
                    index++;
                    if(IM._msgId == $(this).attr('id')){
                        index++;
                        return false;
                    }
                });
                if(index < 0){
                    return;
                }
                var nextMsg = msg.parent().children('div[msg="msg"][im_msgtype="4"]:visible').eq(index);
                if(nextMsg.length < 1){
                    return;
                }

                var src = nextMsg.find('img').attr('src');
                $('#pop_photo').find('img').attr('src', src);

                IM._msgId = nextMsg.attr('id');
            },

            /**
             * 添加群组事件消息，只处理页面
             * @param obj
             * @constructor
             */
            DO_notice_createMsgDiv : function(obj){
                var you_sender = obj.serviceNo;
                var groupId = obj.groupId;
                var name = '系统通知';
                var groupName = obj.groupName;
                var version = obj.version;

                var peopleId = obj.member;
                var people = (!!obj.memberName)?obj.memberName:obj.member;
                var you_msgContent = '';
                //1,(1申请加入群组，2邀请加入群组，3直接加入群组，4解散群组，5退出群组，6踢出群组，7确认申请加入，8确认邀请加入，10管理员修改群组信息，11用户修改群组成员名片)
                var auditType = obj.auditType;
                if(1 == auditType){
                    you_msgContent = '['+ people + ']申请加入群组['+ groupName +'] <span imtype="notice">{<a style="color: red; cursor: pointer;" onclick="IM.EV_confirmJoinGroup(\''+you_sender+'\', \''+version+'\', \''+groupId+'\', \''+peopleId+'\', 2)">同意</a>}{<a style="color: red; cursor: pointer;" onclick="IM.EV_confirmJoinGroup(\''+you_sender+'\', \''+version+'\', \''+groupId+'\', \''+peopleId+'\', 1)">拒绝</a>}</span>';
                }else if(2 == auditType){
                    if(1 == obj.confirm){
                        you_msgContent = '群['+ groupName +']管理员邀请您加入群组';
                        //在群组列表中添加群组项
                        var current_contact_type = IM.HTML_find_contact_type();
                        var isShow = false;
                        if(IM._contact_type_g == current_contact_type){
                            isShow = true;
                        }
                        IM.HTML_addContactToList(groupId, groupName, IM._contact_type_g, false, isShow, false, null, null);
                    }else{
                        you_msgContent = '群['+ groupName +']管理员邀请您加入群组 <span imtype="notice">{<a style="color: red; cursor: pointer;" onclick="IM.EV_confirmInviteJoinGroup(\''+you_sender+'\', \''+groupName+'\', \''+version+'\', \''+obj.admin+'\', \''+groupId+'\', 2)">同意</a>}{<a style="color: red; cursor: pointer;" onclick="IM.EV_confirmInviteJoinGroup(\''+you_sender+'\', \''+groupName+'\', \''+version+'\', \''+obj.admin+'\', \''+groupId+'\', 1)">拒绝</a>}</span>';
                    }
                }else if(3 == auditType){
                    you_msgContent = '['+ people +']直接加入群组['+ groupName +']';
                    IM.DO_procesGroupNotice(auditType,groupId, peopleId, people);
                }else if(4 == auditType){
                    you_msgContent = '管理员解散了群组['+ groupName +']';
                    //将群组从列表中移除
                    IM.HTML_remove_contact(groupId);
                    IM.DO_procesGroupNotice(auditType,groupId, peopleId, people);
                }else if(5 == auditType){
                    you_msgContent = '['+ people +']退出了群组['+ groupName +']';
                    IM.DO_procesGroupNotice(auditType,groupId, peopleId, people);
                }else if(6 == auditType){
                    you_msgContent = '群['+ groupName +']管理员将['+ people +']踢出群组';
                    //将群组从列表中移除
                    if(IM._user_account == people){
                        IM.HTML_remove_contact(groupId);
                    }
                    IM.DO_procesGroupNotice(auditType,groupId, peopleId, people);
                }else if(7 == auditType){
                    you_msgContent = '管理员同意['+ people +']加入群组['+ groupName +']的申请';
                    IM.DO_procesGroupNotice(auditType,groupId, peopleId, people);
                }else if(8 == auditType){
                    if(2 != obj.confirm){
                        you_msgContent = '['+ people +']拒绝了群组['+ groupName +']的邀请';
                    }else{
                        you_msgContent = '['+ people +']同意了管理员的邀请，加入群组['+ groupName +']';
                        IM.DO_procesGroupNotice(auditType,groupId, peopleId, people);
                    }
                }else if(10 == auditType){
                    you_msgContent = '管理员修改群组['+ groupName +']信息';
                    if(!!obj.groupName){
                        IM.HTML_addContactToList(groupId, obj.groupName, IM._contact_type_g, false, isShow, true, null, null);
                    }
                    IM.DO_procesGroupNotice(auditType,groupId, peopleId, people, obj.groupName, obj.ext);
                }else if(11 == auditType){
                    you_msgContent = '用户['+ people +']修改群组成员名片';
                    //TODO obj.memberName有值，意味着要修改展示的名字
                    IM.DO_procesGroupNotice(auditType,groupId, peopleId, obj.memberName, obj.groupName, obj.ext);
                }else{
                    you_msgContent = '未知type['+ auditType +']';
                }

                //添加左侧消息
                //监听消息的联系人，是否是当前展示的联系人
                var b_current_contact_you = IM.DO_createMsgDiv_Help(you_sender, name, true);

                //添加右侧消息
                IM.HTML_pushMsg_addHTML(1, you_sender, version, IM._contact_type_g, b_current_contact_you, groupName, you_msgContent);
            },

            /**
             * 处理群组成员变更通知,只处理pop页面
             * @param type 通知类型 4解散群组，5退出群组，6踢出群组，7确认申请加入，8确认邀请加入 10管理员修改群组信息，11用户修改群组成员名片)
             * @param groupId 群组id
             * @param memberId 用户id
             * @param memberName 用户名称
             * @param groupName 群组名称
             * @param ext 扩展字段
             * @constructor
             */
            DO_procesGroupNotice : function(type, groupId, memberId, memberName, groupName, ext){
                if(!IM.DO_checkPopShow(groupId)){
                    return ;
                }
                if(type==4){
                    alert("管理员解散了该群组！");
                    IM.HTML_pop_hide();
                } else if(type == 5 || type == 6){
                    if(memberId == IM._user_account){
                        alert("您被管理员移出该群组！");
                        IM.HTML_pop_hide();
                    }else{
                        IM.HTML_popDeleteMember(memberId);
                    }
                } else if(type == 7 || type == 8){
                    var obj =  $('#pop').find('div[im_isowner]');
                    var isowner = obj.attr('im_isowner');
                    IM.HTML_popAddMember(groupId, memberId, memberName, isowner);
                } else if(type == 10){
                    var obj =  $('#pop').find('div[im_isowner]');
                    var isowner = obj.attr('im_isowner');
                    if(!!groupName){
                        IM.HTML_showGroupName(isowner, groupName);
                    }
                    if(!!ext){
                        var json = eval("("+ext+")");
                        if(!!json["groupDeclared"]){
                            IM.HTML_showGroupDeclared(isowner, json["groupDeclared"]);
                        }
                    }
                }else if(type == 11){
                    IM.HTML_showMemberName(memberId,memberName);
                }
            },

            DO_checkPopShow : function(groupId){
                if($('#pop_group_'+groupId).length<=0){
                    return false;
                }
                var display = $('#pop').css("display");
                if(display != 'block'){
                    return false;
                }
                return true;
            },

            /**
             * 删除联系人，包括左侧和右侧
             * @param id
             * @constructor
             */
            HTML_remove_contact : function(id){
                //删除左侧联系人列表
                $('#im_contact_'+ id).remove();
                //删除右侧相应消息
                $('#im_content_list').find('div[content_you="'+ id +'"]').each(function(){
                    $(this).remove();
                });
            },

            /**
             * 添加消息列表的辅助方法
             * 消息的联系人(you_sender)，是否是当前展示的联系人
             * 并处理左侧联系人列表的展示方式（新增条数，及提醒数字变化）
             * @param you_sender
             * @param b_isGroupMsg -- true:group消息列表   false:点对点消息列表
             * @returns {boolean} -- true:是当前展示的联系人；false:不是
             * @constructor
             */
            DO_createMsgDiv_Help: function(you_sender, name, b_isGroupMsg){
                //处理联系人列表，如果新联系人添加一条新的到im_contact_list，如果已经存在给出数字提示
                var b_current_contact_you = false;  //push消息的联系人(you_sender)，是否是当前展示的联系人
                $('#im_contact_list').find('li').each(function(){
                    if(you_sender == $(this).attr('contact_you')){
                        if($(this).hasClass('active')){
                            b_current_contact_you = true;
                        }
                    }
                });

                //新建时判断选中的contact_type是那个然后看是否需要显示
                var current_contact_type = IM.HTML_find_contact_type();

                var isShow = false;
                if(IM._contact_type_g == current_contact_type &&　b_isGroupMsg){
                    isShow = true;
                }
                if(IM._contact_type_c == current_contact_type && !b_isGroupMsg){
                    isShow = true;
                }

                IM.HTML_addContactToList(you_sender, name, (b_isGroupMsg) ? IM._contact_type_g : IM._contact_type_c, false, isShow, false, null, null);

                return b_current_contact_you;
            },

            /**
             * 查找当前选中的contact_type值
             * @returns {*}
             * @constructor
             */
            HTML_find_contact_type : function(){
                //在群组列表中添加群组项
                var current_contact_type = null;
                $('#im_contact_type').find('li').each(function(){
                    if($(this).hasClass('active')){
                        current_contact_type = $(this).attr('contact_type');
                    }
                });
                return current_contact_type;
            },

            /**
             * 样式，push监听到消息时添加右侧页面样式
             * @param msgtype -- 消息类型1:文本消息 2：语音消息 3：视频消息  4：图片消息  5：位置消息  6：文件
             * @param you_sender -- 对方帐号：发出消息时对方帐号，接收消息时发送者帐号
             * @param version -- 消息版本号，本地发出时为long时间戳
             * @param content_type -- C G or M
             * @param b -- 是否需要展示 true显示，false隐藏
             * @param name -- 显示对话框中消息发送者名字
             * @param you_msgContent -- 消息内容
             * @constructor
             */
            HTML_pushMsg_addHTML : function(msgtype, you_sender, version, content_type, b, name, you_msgContent){
                var str = '<div msg="msg" im_msgtype="'+msgtype+'" id="'+ you_sender +'_'+ version +'" content_type="'+ content_type +'" content_you="'+ you_sender +'" class="alert alert-left alert-info" style="display:'+ ((b) ? 'block' : 'none') +'">' +
                    '<code>'+ name +':</code>&nbsp;' + you_msgContent +
                    '</div>';
                console.log(str);
                $('#im_content_list').append(str);

                setTimeout(function(){
                    $('#im_content_list').scrollTop( $('#im_content_list')[0].scrollHeight );
                },100);

                //右侧列表添加数字提醒
                //TODO 后期要添加提醒数字时，记得要先拿到旧值，再+1后写入新建的列表中
                var current_contact = $('#im_contact_'+you_sender);
                if(!current_contact.hasClass('active')){
                    var warn = current_contact.find('span[contact_style_type="warn"]');
                    if('99+' == warn.html()){
                        return;
                    }
                    var warnNum = parseInt( (!!warn.html()) ? warn.html() : 0 ) + 1;
                    if(warnNum > 99){
                        warn.html('99+');
                    }else{
                        warn.html(warnNum);
                    }
                    warn.show();
                }
            },

            /**
             * 样式，发送消息时添加右侧页面样式
             * @param msg -- 是否为临时消息 msg or temp_msg
             * @param msgtype -- 消息类型1:文本消息 2：语音消息 3：视频消息  4：图片消息  5：位置消息  6：文件
             * @param msgid -- 消息版本号，本地发出时均采用时间戳long
             * @param content_type -- C G or M
             * @param content_you -- 对方帐号：发出消息时对方帐号，接收消息时发送者帐号
             * @param im_send_content -- 消息内容
             * @constructor
             */
            HTML_sendMsg_addHTML : function(msg, msgtype, msgid, content_type, content_you, im_send_content){
                im_send_content = emoji.replace_unified(im_send_content);

                var display = ('temp_msg' == msg) ? 'none' : 'block';
                var str =   '<div msg="'+ msg +'" im_msgtype="'+msgtype+'" id="'+ content_you +'_'+ msgid +'" content_type="'+ content_type +'" content_you="'+ content_you +'" class="alert alert-right alert-success" style="display:'+ display +'">' +
                                '<span imtype="resend" class="add-on" onclick="IM.EV_resendMsg(\''+ content_you+'_'+msgid +'\')" style="display:none; cursor:pointer; position: relative; left: -40px; top: 0px;"><i class="icon-repeat"></i></span>' +
                                '<code class="pull-right">&nbsp;:'+ IM._username +'</code>'+ im_send_content +
                            '</div>';

                $('#im_content_list').append(str);

                //if(4 == msgtype || 6 == msgtype){
                //    //$('#'+content_you+'_'+msgid).find('input[imtype="msg_attach_resend"]')[0].files[0] = oFile;
                //    //document.getElementById('im_image_file').files[0];
                //
                //    $('#'+content_you+'_'+msgid).find('div[im_msgtype="'+ msgtype +'"]').append(oFile);
                //}


                $('#im_send_content').html('');
                $('#im_content_list').scrollTop( $('#im_content_list')[0].scrollHeight );

                return content_you +'_'+ msgid;
            },

            /**
             * 选择联系人列表，并切换消息列表
             * @param contact_type
             * @param contact_you
             * @param showname 显示的中文名称
             */
            DO_chooseContactList : function(contact_type, contact_you){
                IM.HTML_clean_im_contact_list();
                var current_contact = $('#im_contact_'+contact_you);
                current_contact.addClass('active');
                var warn = current_contact.find('span[contact_style_type="warn"]');
                warn.hide();
                warn.html(0);

                IM.HTML_clean_im_content_list(contact_you);

                //如果当前选择的是客服列表直接发起咨询
                if(IM._contact_type_m == contact_type){
                    IM.EV_startMcmMsg(contact_you);
                    IM._isMcm_active = true;
                }else{
                    if(IM._isMcm_active){
                        IM.EV_stopMcmMsg(contact_you);
                    }
                }
            },

            /**
             * 清理右侧消息列表
             * @param contact_you -- 左侧联系人列表中的
             */
            HTML_clean_im_content_list : function(contact_you){
                $('#im_content_list').find('div[msg="msg"]').each(function(){
                    if($(this).attr('content_you') == contact_you){
                        $(this).show();
                    }else{
                        $(this).hide();
                    }
                });

                $('#im_content_list').scrollTop( $('#im_content_list')[0].scrollHeight );
            },

            /**
             * 清理联系人列表样式
             */
            HTML_clean_im_contact_list : function() {
                //清除选中状态class
                $('#im_contact_list').find('li').each(function(){
                    $(this).removeClass('active');
                });
            },

            /**
             * 添加联系人到列表中
             */
            DO_addContactToList : function(contact){
            	var contactVal = "";
            	if(contact == undefined){
            		contactVal = $('#im_add').find('input[imtype="im_add_contact"]').val();
            	}else{
            		contactVal = contact;
            	}

                if(!IM.DO_checkContact(contactVal)){
                    return ;
                }

                var im_contact = $('#im_contact_list').find('li[contact_type="'+ IM._contact_type_c +'"][contact_you="'+ contactVal +'"]');
                if(im_contact.length <= 0){
                    IM.HTML_clean_im_contact_list();

                    IM.HTML_addContactToList(contactVal, contactVal, IM._contact_type_c, true, true, false, null, null);

                    IM.HTML_clean_im_content_list(contactVal);
                }

                $('#im_add').find('input[imtype="im_add_contact"]').val('');

            },

            /**
             * 检查联系名称规则是否合法
             * @param contactVal
             * @returns {boolean}
             * @constructor
             */
            DO_checkContact : function(contactVal){
                if(!contactVal){
                    IM.HTML_showAlert('alert-warning', '请填写联系人');
                    return false;
                }

                if(contactVal.length > 128){
                    IM.HTML_showAlert('alert-error', '联系人长度不能超过128');
                    return false;
                }
                if( 'g' == contactVal.substr(0, 1) ){
                    IM.HTML_showAlert('alert-error', '联系人不能以"g"开始');
                    return false;
                }

                if(contactVal.indexOf("@") > -1){
                    var regx2 = /[a-zA-Z0-9_-]{1,}@(([a-zA-z0-9]-*){1,}\\.){1,3}[a-zA-z\\-]{1,}/;
                    if(regx2.exec(contactVal) == null){
                        IM.HTML_showAlert('alert-error', '邮箱格式不正确');
                        return false;
                    }
                }else{
                    var regx1 = /^[A-Za-z0-9_-]+$/;
                    if(regx1.exec(contactVal) == null){
                        IM.HTML_showAlert('alert-error', '联系人只能使用数字、_、-、大小写英文');
                        return false;
                    }
                }
                return true;
            },

            /**
             * 添加群组
             * @param permission
             * @constructor
             */
            DO_addGroupToList : function(permission){
                var groupName = $('#im_add').find('input[imtype="im_add_group"]').val();
                if(!groupName){
                    IM.HTML_showAlert('alert-error', '请填写群组名称，用来创建群组');
                    return;
                }
                if(groupName.trim()==""){
                    IM.HTML_showAlert('alert-error', '请填写正确的群组名称');
                    return;
                }

                IM.EV_createGroup(groupName, permission);

                $('#im_add').find('input[imtype="im_add_group"]').val('');
            },

            /**
             * 样式，添加左侧联系人列表项
             * @param contactVal
             * @param contact_type
             * @param b true--class:active  false--class:null
             * @param bb true--display:block  false--display:none
             * @param bbb true--需要改名字  false--不需要改名字
             * @param owner -- 当前群组创建者（只有content_type==G时才有值）
             * @param isNotice -- 是否提醒 1：提醒；2：不提醒(只有content_type==G时才有值)
             * @constructor
             */
            HTML_addContactToList : function(contactVal, contactName, content_type, b, bb, bbb, owner, isNotice){

                var old = $('#im_contact_'+ contactVal);
                //已存在，置顶，并更改数字
                if(!!old && old.length > 0){
                    //如果名字不同，修改名字
                    if(bbb){
                        old.find('span[contact_style_type="name"]').html(contactName);
                    }

                    var str = old.prop('outerHTML');
                    old.remove();
                    $('#im_contact_list').prepend(str);

                    return;
                }

                //不存在创建个新的
                if(IM._contact_type_m == content_type){
                    var onUnitAccount = $('#im_contact_'+IM._onUnitAccount);
                    if(IM._onUnitAccount == onUnitAccount.attr('contact_you')){
                        return;
                    }
                }
                var active = '';
                if(b) active = 'active';
                var dis = 'none';
                if(bb) dis = 'block';

                var str = '<li onclick="IM.DO_chooseContactList(\''+ content_type +'\', \''+ contactVal +'\')" id="im_contact_'+ contactVal +'" im_isnotice="'+isNotice+'" contact_type="'+ content_type +'" contact_you="'+ contactVal +'" class="'+ active +'"  style="display:'+ dis +'">' +
                                '<a href="#">' +
                                    '<span contact_style_type="name">'+ contactName +'</span>';
                if(IM._contact_type_g == content_type){
                    str +=          '<span class="pull-right" onclick="IM.DO_groupMenu(\''+contactVal+'\', \''+ owner +'\');"><i class="icon-wrench"></i></span>';
                }
                    str +=          '<span contact_style_type="warn" class="badge badge-warning pull-right" style="margin-top:3px; margin-right:10px; display:none;">0</span>' +
                                '</a>' +
                          '</li>';
                $('#im_contact_list').prepend(str);

                if(b) IM.DO_chooseContactList(content_type, contactVal);
            },

            /**
             * 选择群组管理事件，群组列表后面的扳手
             * @param groupId
             * @param owner
             * @constructor
             */
            DO_groupMenu : function(groupId, owner){
                var isowner = false;
                if(IM._user_account == owner){//自己创建的群组
                    isowner = true;
                }
                //构建页面
                IM.DO_pop_show(groupId, isowner);

                //调用SDK方法获取数据
                //获取群组详情
                IM.EV_getGroupDetail(groupId);
                //获取成员列表
                IM.EV_getGroupMemberList(groupId, isowner);
            },

            /**
             * 展现群组名称
             * @param isowner
             * @param groupName
             * @constructor
             */
            HTML_showGroupName : function(isowner, groupName){
                var str = '';
                if(isowner && isowner=='true'){
                    str = '<input type="text" class="pull-right" style="width:95%;" value="'+groupName+'"/>';
                }else{
                    str = '<span class="pull-right" maxlength="128">'+groupName+'</span>';
                }
                $('#pop').find('div[imtype="im_pop_group_name"]').html(str);
            },

            /**
             * 展现群组公告
             * @param isowner
             * @param groupDeclared
             * @constructor
             */
            HTML_showGroupDeclared : function(isowner, groupDeclared){
                var str = '';
                if(isowner && isowner=='true'){
                    str = '<textarea class="pull-right" rows="5" style="width:95%;">'+groupDeclared+'</textarea>';
                }else{
                    str = '<span class="pull-right" maxlength="128">'+groupDeclared+'</span>';
                }
                $('#pop').find('span[imtype="im_pop_group_declared"]').html(str);
            },

            /**
             * 样式，展现邀请域
             * @constructor
             */
            HTML_showInviteArea : function(){
                var tab = $('#pop').find('table[imtype="im_pop_members_add"]');
                var tdObj = tab.children().children().next().children();
                tdObj.children().hide();
                tdObj.children().next().show();
                tdObj.children().next().next().show();
            },

            /**
             * 样式，隐藏邀请域
             * @constructor
             */
            HTML_hideInviteArea : function(){
                var tab = $('#pop').find('table[imtype="im_pop_members_add"]');
                var tdObj = tab.children().children().next().children();
                tdObj.children().show();
                tdObj.children().next().hide();
                tdObj.children().next().next().hide();
            },

            /**
             * 处理群组成员列表展现
             * @param obj
             * @param isowner
             * @param groupId
             * @constructor
             */
            DO_pop_show_help_GroupMemberList : function(obj, isowner, groupId){
                var str =           '<tr><td style="padding:0 0 0 0;"></td></tr>';
                for(var i in obj){
                    var member = obj[i];
                    if(!member.member){
                        continue;
                    }
                    if(!member.nickName){
                        member.nickName = member.member;
                    }

                    if(member.role == 1 || member.role == 2){
                        str +=      '<tr contact_you="'+member.member+'">' +
                                        '<td><span class="pull-left"><span style="color: #b94a48">[管理员]</span>&nbsp;&nbsp;<span>'+member.nickName+'</span></span></td>' +
                                    '</tr>';
                    }else{
                        str +=      '<tr contact_you="'+member.member+'">' +
                                        '<td>' +
                                            '<span class="pull-left"><span style="color: #006dcc">[成员]</span>&nbsp;&nbsp;<span>'+member.nickName+'</span></span>';
                        if(isowner){
                            str +=          '<span class="pull-right label label-warning" onclick="IM.EV_deleteGroupMember(\''+groupId+'\',\''+member.member+'\')"> 踢出 </span>';
                            //禁言状态 1:不禁言  2:禁言
                            if(member.speakState==2){
                                str +=      '<span class="pull-right label label-success" onclick="IM.EV_forbidMemberSpeak(\''+groupId+'\',\''+member.member+'\',1)"> 恢复 </span>';
                            }else{
                                str +=      '<span class="pull-right label label-important" onclick="IM.EV_forbidMemberSpeak(\''+groupId+'\',\''+member.member+'\',2)"> 禁言 </span>'
                            }
                        }else{
                            //禁言状态 1:不禁言  2:禁言
                            if(member.speakState==2){
                                str +=      '<span class="pull-right label label-inverse" style="cursor: default;"> 已禁言 </span>'
                            }
                        }
                            str +=      '</td>'+
                                    '</tr>';
                    }
                }
                if(isowner){
                    $('#pop').find('table[imtype="im_pop_members_add"]').show();
                }else{
                    $('#pop').find('table[imtype="im_pop_members_add"]').hide();
                }

                $('#pop').find('table[imtype="im_pop_members"]').html(str);

            },

            HTML_showMemberName : function(memberId, memberName){
                var trobj = $('#pop').find('tr[contact_you="'+memberId+'"]');
                var nameSpan = trobj.children().children().children().next();
                nameSpan.html(memberName);
            },

            /**
             * 样式，删除群组成员
             * @param memberId
             * @constructor
             */
            HTML_popDeleteMember : function(memberId){
                var trobj = $('#pop').find('tr[contact_you="'+memberId+'"]');
                trobj.remove();
            },

            /**
             * 样式，新增群组成员
             * @param groupId
             * @param memberId
             * @param memberName
             * @param isowner
             * @constructor
             */
            HTML_popAddMember : function(groupId,memberId, memberName, isowner){
                if($('#pop').find('tr[contact_you='+memberId+']').length>0){
                    return ;
                }
                var str =   '<tr contact_you="'+memberId+'">' +
                                '<td>' +
                                    '<span class="pull-left"><span style="color: #006dcc">[成员]</span>&nbsp;&nbsp;'+memberName+'</span>';
                if(isowner && isowner=='true'){
                    str +=          '<span class="pull-right label label-warning" onclick="IM.EV_deleteGroupMember(\''+groupId+'\',\''+memberId+'\')"> 踢出 </span>' +
                                    '<span class="pull-right label label-important" onclick="IM.EV_forbidMemberSpeak(\''+groupId+'\',\''+memberId+'\',2)"> 禁言 </span>';
                }
                str +=          '</td>'+
                            '</tr>';
                $('#pop').find('table[imtype="im_pop_members"]').append(str);

            },

            /**
             * 群组详情页面数据处理
             * @param groupId
             * @param owner
             * @constructor
             */
            DO_pop_show : function(groupId, isowner){
                //var isowner = false;
                //if(IM._user_account == owner){//自己创建的群组
                //    isowner = true;
                //}

                var str =   '<div class="modal" id="pop_group_'+groupId+'" style="position: relative; top: auto; left: auto; right: auto; margin: 0 auto 20px; z-index: 1; max-width: 100%;">' +
                                '<div class="modal-header" im_isowner="'+isowner+'">' +
                                    '<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="IM.HTML_pop_hide();">×</button>' +
                                    '<h3>群组：'+ groupId +'</h3>' +
                                '</div>' +
                                '<div class="modal-body">' +
                                    '<table class="table table-bordered">' +
                                        '<tr>' +
                                            '<td>' +
                                                '<div style="height:auto;">' +
                                                    '<table imtype="im_pop_members" class="table table-striped">' +
                                                    '</table>' +
                                                '</div>' +
                                                '<div style="height:auto; padding-bottom: 0px;">' +
                                                    '<table imtype="im_pop_members_add" style="display:none;" class="table table-striped">' +
                                                    '</table>' +
                                                '</div>' +
                                            '</td>' +
                                        '</tr>' +
                                        '<tr>' +
                                            '<td>' +
                                                '<span class="pull-left">消息免打扰：</span>' +
                                                '<span class="pull-right" imtype="im_pop_group_notice">' +
                                                    '<a href="#" class="btn btn-primary" style="margin-left:10px;">开启</a>' +
                                                    '<a href="#" class="btn" style="margin-left:10px;">关闭</a>' +
                                                '</span>' +
                                            '</td>' +
                                        '</tr>' +
                                        '<tr>' +
                                            '<td>' +
                                                '<div class="pull-left" style="width: 25%;">群组名：</div>' +
                                                '<div class="pull-right" style="width: 75%;" imtype="im_pop_group_name">' +
                                                    '<input class="pull-right" type="text" style="width:95%;" />' +
                                                '</div>' +
                                            '</td>' +
                                        '</tr>' +
                                        '<tr>' +
                                            '<td>' +
                                                '<span class="pull-left" style="width: 25%;">公告：</span>' +
                                                '<span class="pull-right" style="width: 75%;" imtype="im_pop_group_declared">' +
                                                    '<textarea class="pull-left" style="width:95%;"></textarea>' +
                                                '</span>' +
                                            '</td>' +
                                        '</tr>' +
                                    '</table>';
                //if(isowner){
                //    str +=          '<p style="text-align: center;"><button class="btn btn-primary" type="button" onclick="IM.EV_dismissGroup(\''+ groupId +'\')">解散群组</button></p>';
                //}
                if(!isowner){
                    str +=          '<div style="text-align: center;">' +
                                        '<button class="btn btn-primary" type="button" onclick="IM.EV_quitGroup(\''+ groupId +'\')"> 退出群组 </button>' +
                                    '</div>';
                }
                    str +=      '</div>';
                if(isowner){
                    str +=      '<div class="modal-footer">' +
                                    '<a href="#" class="btn btn-primary" onclick="IM.EV_dismissGroup(\''+ groupId +'\')"> 解散群组 </a>' +
                                    '<a href="#" class="btn" onclick="IM.EV_updateGroupInfo(\''+ groupId +'\')">保存修改</a>' +
                                '</div>';
                }
                    str +=  '</div>';

                $('#pop').find('div[class="row"]').html(str);

                IM.HTML_pop_show();
            },

            /**
             * 群组pop层展示
             * @constructor
             */
            HTML_pop_photo_show : function(){
                IM.HTML_LJ_block('photo');

                var navbarHei = $('#navbar').height();
                var lvjingHei = $('#lvjing').height();
                var pop_photo = $('#pop_photo');

                pop_photo.find('img').css('max-height', lvjingHei-30).css('max-width', $(window).width()-50);
                pop_photo.css('top', navbarHei);

                var d = $(window).scrollTop();
                //a+b=c
                var a = parseInt(pop_photo.find('div[imtype="pop_photo_top"]').css('margin-top'));
                var b = parseInt(pop_photo.find('div[imtype="pop_photo_top"]').css('height'));
                var c = $(window).height();

                if(a+b >= c){
                    d = 0;
                }else if(d+b >= c){
                    d = c-b-20;
                }
                pop_photo.find('div[imtype="pop_photo_top"]').css('margin-top', d);
                $(window).scrollTop(d);

                //pop_photo.css('height', lvjingHei-20);
                pop_photo.show();
            },

            /**
             * 图片pop层隐藏
             * @constructor
             */
            HTML_pop_photo_hide : function(){
                IM._msgId = null;
                $('#pop_photo').hide();
                IM.HTML_LJ_none();
            },

            /**
             * 样式，群组详情页面显示
             * @constructor
             */
            HTML_pop_show : function(){
                IM.HTML_LJ_block('white');

                var navbarHei = $('#navbar').height();
                var contentHei = $(".scrollspy-content-example").height();
                var pop = $('#pop');
                pop.css('top', navbarHei+20);
                pop.css('height', contentHei);
                pop.show();
            },

            /**
             * 样式，群组详情页面隐藏
             * @constructor
             */
            HTML_pop_hide : function(){
                $('#pop').hide();
                IM.HTML_LJ_none();
            },

            /**
             * 隐藏提示框
             * @param id
             */
            HTML_closeAlert : function(id){
                if('all' == id){
                    IM.HTML_closeAlert('alert-error');
                    IM.HTML_closeAlert('alert-info');
                    IM.HTML_closeAlert('alert-warning');
                    IM.HTML_closeAlert('alert-success');
                }else{
                    $('#hero-unit').css('padding-top', '60px');
                    $('#'+id).parent().css('top', '0px');
                    $('#'+id).hide();
                    $('#'+id).parent().hide();
                }
            },

            /**
             * 显示提示框
             * @param id
             * @param str
             */
            HTML_showAlert : function(id, str, time){
                var t = 3*1000;
                if(!!time){
                    t = time;
                }
                clearTimeout(IM._timeoutkey);
                $('#alert-info').hide();
                $('#alert-warning').hide();
                $('#alert-error').hide();
                $('#alert-success').hide();

                $('#'+id+'_content').html(str);
                $('#hero-unit').css('padding-top', '0px');
                $('#'+id).parent().css('top', '-5px');
                $('#'+id).show();
                $('#'+id).parent().show();
                IM._timeoutkey = setTimeout(function(){
                    IM.HTML_closeAlert(id);
                }, t);
            },

            /**
             * 样式，因高度变化而重置页面布局
             * @constructor
             */
            HTML_resetHei : function(){
            	return;
                var windowHei = $(window).height();
                if(windowHei < 666){
                    windowHei = 666;
                }
                var navbarHei = $('#navbar').height()+20+60+30+20+1;
                var contactTypeHei = $('#im_contact_type').height()+20+6;
                var addContactHei = $('#im_add_contact').height()+10+10;

                var hei = windowHei-navbarHei-contactTypeHei-addContactHei-20;
                $(".scrollspy-contact-example").height(hei);
                $(".scrollspy-content-example").height(hei+contactTypeHei-10-10-75);

                $('#im_content_list').scrollTop( $('#im_content_list')[0].scrollHeight );

                //绘制滤镜
                if('block' == $('#pop_photo').css('display')){
                    IM.HTML_pop_photo_show();
                }else if('block' == $('#pop').css('display')){
                    IM.HTML_pop_show();
                }else if('block' == $('#lvjing').find('img').css('display')){
                    IM.HTML_LJ('black');
                }else{
                    IM.HTML_LJ('black');
                }
            },

            /**
             * canvas绘制滤镜层（HTML5）
             * @param style white, black
             * @constructor
             */
            HTML_LJ : function(style){
                var lvjing = $('#lvjing');

                var windowWid = $(window).width();
                if(windowWid < 666){
                    $('#hero-unit').css('padding-left', 20);
                    $('#hero-unit').css('padding-right', 20);
                }else{
                    $('#hero-unit').css('padding-left', 60);
                    $('#hero-unit').css('padding-right', 60);
                }
                //var windowHei = $(window).height();

                var navbarHei = $('#navbar').height();
                var concentHei = ($('#hero-unit').height()+20+60+30);
                var concentwid = ($('#hero-unit').width()+ parseInt($('#hero-unit').css('padding-left')) + parseInt($('#hero-unit').css('padding-right')));

                var lvjingImgHei = lvjing.find('img').height();
                if(0 == lvjingImgHei) lvjingImgHei = 198;

                lvjing.css('top', navbarHei);
                lvjing.css('left', 0);
                lvjing.css('width', '100%');
                lvjing.height(concentHei+15);

                var canvas = document.getElementById("lvjing_canvas");
                canvas.clear;
                canvas.height = (concentHei+15);
                canvas.width = concentwid;
                if (!canvas.getContext) {
                    console.log("Canvas not supported. Please install a HTML5 compatible browser.");
                    return;
                }

                var context = canvas.getContext("2d");
                context.clear;
                context.beginPath();
                context.moveTo(0, 0);
                context.lineTo(concentwid, 0);
                context.lineTo(concentwid, concentHei+15);
                context.lineTo(0, concentHei+15);
                context.closePath();
                context.globalAlpha = 0.4;
                if('white' == style){
                    context.fillStyle = "rgb(200,200,200)";
                    lvjing.find('img').hide();
                }else if('photo' == style){
                    context.fillStyle = "rgb(20,20,20)";
                    lvjing.find('img').hide();
                }else if('black' == style){
                    context.fillStyle = "rgb(0,0,0)";
                    var qr = lvjing.find('img');
                    qr.css('top', concentHei/2-lvjingImgHei/2);
                    qr.css('left', concentwid/2-lvjingImgHei/2);
                    qr.show();
                }
                context.fill();
                //context.lineWidth = 0;
                //context.strokeStyle = "black";
                context.stroke();

                var cha = navbarHei+4;
                if(navbarHei > 45) cha = 0;
                $('#im_body').height(navbarHei+concentHei-25);
                $('body').height(navbarHei+concentHei-25);

                setTimeout(function(){
                    $('#ClCache').parent().remove();
                }, 20);

            },

            /**
             * 样式，滤镜隐藏
             * @constructor
             */
            HTML_LJ_none : function(){
                $('#lvjing').hide();
            },

            /**
             * 样式，滤镜显示
             * @constructor
             */
            HTML_LJ_block : function(style){
                IM.HTML_LJ(style);
                $('#lvjing').show();
            },

            /**
             * 聊天模式选择
             * @param contact_type -- 'C':代表联系人; 'G':代表群组; 'M':代表多渠道客服
             * @constructor
             */
            DO_choose_contact_type : function(contact_type){
                $('#im_contact_type').find('li').each(function(){
                    $(this).removeClass('active');
                    if(contact_type == $(this).attr('contact_type')){
                        $(this).addClass('active');
                    }
                });

                //选择列表下内容
                $('#im_contact_list').find('li').each(function(){
                    if(contact_type == $(this).attr('contact_type')){
                        $(this).show();
                    }else{
                        $(this).hide();
                    }
                });

                //切换样式
                var current_contact_type = IM.HTML_find_contact_type();
                var im_add = $('#im_add');
                if(IM._contact_type_c == current_contact_type){//点对点
                    im_add.find('i').attr('class', '').addClass('icon-user');
                    im_add.find('input[imtype="im_add_contact"]').show();
                    im_add.find('input[imtype="im_add_group"]').hide();
                    im_add.find('input[imtype="im_add_mcm"]').hide();
                    im_add.find('button[imtype="im_add_btn_contact"]').show();
                    im_add.find('div[imtype="im_add_btn_group"]').hide();

                }else if(IM._contact_type_g == current_contact_type){//群组
                    im_add.find('i').attr('class', '').addClass('icon-th-list');
                    im_add.find('input[imtype="im_add_contact"]').hide();
                    im_add.find('input[imtype="im_add_group"]').show();
                    im_add.find('input[imtype="im_add_mcm"]').hide();
                    im_add.find('button[imtype="im_add_btn_contact"]').hide();
                    im_add.find('div[imtype="im_add_btn_group"]').show();

                }else if(IM._contact_type_m == current_contact_type){//客服
                    im_add.find('i').attr('class', '').addClass('icon-home');
                    im_add.find('input[imtype="im_add_contact"]').hide();
                    im_add.find('input[imtype="im_add_group"]').hide();
                    im_add.find('input[imtype="im_add_mcm"]').show();
                    im_add.find('button[imtype="im_add_btn_contact"]').hide();
                    im_add.find('div[imtype="im_add_btn_group"]').hide();

                }else{

                }
            },

            /**
             * 样式，发送消息
             */
            DO_sendMsg : function(){
                //$('#im_send_content_copy').html($('#im_send_content').html());

                var str = IM.DO_pre_replace_content_to_db();
                $('#im_send_content_copy').html(str);

                $('#im_send_content_copy').find('img[imtype="content_emoji"]').each(function(){
                    var emoji_value_unicode = $(this).attr('emoji_value_unicode');
                    $(this).replaceWith(emoji_value_unicode);
                });
                var im_send_content = $('#im_send_content_copy').html();

                //清空pre中的内容
                $('#im_send_content_copy').html('');
                //隐藏表情框
                $('#emoji_div').hide();

                var msgid = new Date().getTime();

                var content_type = '';
                var content_you = '';
                var b = false;
                $('#im_contact_list').find('li').each(function(){
                    if($(this).hasClass('active')){
                        content_type = $(this).attr('contact_type');
                        content_you = $(this).attr('contact_you');
                        b = true;
                    }
                });
                if(!b){
                    alert("请选择要对话的联系人或群组");
                    return;
                }
                if(im_send_content == undefined || im_send_content == null || im_send_content == '') return;
                im_send_content = im_send_content.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&amp;/g, '&').replace(/&nbsp;/g, ' ');
                console.log('msgid['+msgid+'] content_type['+content_type+'] content_you['+content_you+'] im_send_content['+im_send_content+']');

                var str = '<pre msgtype="content">'+ im_send_content +'</pre>';
                IM.HTML_sendMsg_addHTML('msg', 1, msgid, content_type, content_you, str);

                //转换所有的html标记
                //im_send_content = im_send_content.replace(/&lt;/g, '<').replace(/&gt;/g, '>');

                //发送消息至服务器
                if(IM._contact_type_c == content_type){
                    IM.EV_sendTextMsg(msgid, im_send_content, content_you);
                }else if(IM._contact_type_g == content_type){
                    IM.EV_sendTextMsg(msgid, im_send_content, content_you);
                }else{
                    IM.EV_sendMcmMsg(msgid, im_send_content, content_you);
                }
            },

            DO_im_image_file : function(){
                var msgid = new Date().getTime();
                var content_type = '';
                var content_you = '';
                var b = false;
                $('#im_contact_list').find('li').each(function(){
                    if($(this).hasClass('active')){
                        content_type = $(this).attr('contact_type');
                        content_you = $(this).attr('contact_you');
                        b = true;
                    }
                });
                if(!b){
                    alert("请选择要对话的联系人或群组");
                    return;
                }

                var windowWid = $(window).width();
                var imgWid = 0;
                var imgHei = 0;
                if(windowWid < 666){
                    imgWid = 100;
                    imgHei = 150;
                }else{
                    imgWid = 150;
                    imgHei = 200;
                }
                var str =   '<div class="progress progress-striped active">' +
                                '<div class="bar" style="width: 0%;"></div>' +
                            '</div>' +
                            '<span imtype="msg_attach">' +
                                '<img imtype="msg_attach_src" src="#" style="max-width:'+ imgWid +'px; max-height:'+ imgHei +'px;" onclick="IM.DO_pop_phone(\''+content_you+'\', \''+msgid+'\')"/>' +
                                '<input imtype="msg_attach_resend" type="file" accept="image/*" style="display:none;margin: 0 auto;" onchange="IM.DO_im_image_file_up(\''+ content_you +'_'+ msgid+'\', \''+ msgid +'\')">' +
                            '</span>';

                //添加右侧消息
                var id = IM.HTML_sendMsg_addHTML('temp_msg', 4, msgid, content_type, content_you, str);

                $('#'+id).find('input[imtype="msg_attach_resend"]').click();
            },

            /**
             * 发送图片，页面选择完图片后出发
             * @param id -- dom元素消息体的id
             * @param msgid
             * @constructor
             */
            DO_im_image_file_up : function(id, msgid){
                //var oFile = document.getElementById('im_image_file').files[0];
                var msg = $('#'+id);
                var oFile = msg.find('input[imtype="msg_attach_resend"]')[0].files[0];
                console.log(oFile.name +':'+ oFile.type);

                window.URL = window.URL || window.webkitURL || window.mozURL || window.msURL;
                var url = window.URL.createObjectURL(oFile);
                msg.find('img[imtype="msg_attach_src"]').attr('src', url);

                var receiver = msg.attr('content_you');
                //查找当前选中的contact_type值 1、IM上传 2、MCM上传
                var current_contact_type = IM.HTML_find_contact_type();
                if(IM._contact_type_m == current_contact_type){
                    IM.EV_sendToDeskAttachMsg(msgid, oFile, 4, receiver);
                }else{
                    IM.EV_sendAttachMsg(msgid, oFile, 4, receiver);
                }

            },

            DO_im_attachment_file : function(){
                var msgid = new Date().getTime();
                var content_type = '';
                var content_you = '';
                var b = false;
                $('#im_contact_list').find('li').each(function(){
                    if($(this).hasClass('active')){
                        content_type = $(this).attr('contact_type');
                        content_you = $(this).attr('contact_you');
                        b = true;
                    }
                });
                if(!b){
                    alert("请选择要对话的联系人或群组");
                    $('#im_attachment_file').val('');
                    return;
                }

                var str =   '<div class="progress progress-striped active">' +
                                '<div class="bar" style="width: 40%;"></div>' +
                            '</div>' +
                            '<span imtype="msg_attach">' +
                                '<a imtype="msg_attach_href" href="#" target="_blank">' +
                                    '<span>' +
                                        '<img style="width:32px; height:32px; margin-right:5px; margin-left:5px;" src="assets/img/attachment_icon.png" />' +
                                    '</span>' +
                                    '<span imtype="msg_attach_name"></span>' +
                                '</a>' +
                                '<input imtype="msg_attach_resend" type="file" style="display:none;margin: 0 auto;" onchange="IM.DO_im_attachment_file_up(\''+ content_you +'_'+ msgid+'\', \''+ msgid +'\')">' +
                            '</span>';
                //添加右侧消息
                var id = IM.HTML_sendMsg_addHTML('temp_msg', 6, msgid, content_type, content_you, str);

                $('#'+id).find('input[imtype="msg_attach_resend"]').click();
            },

            /**
             *
             * @param id -- dom元素消息体的id
             * @param msgid
             * @constructor
             */
            DO_im_attachment_file_up : function(id, msgid){
                //var oFile = document.getElementById('im_attachment_file').files[0];
                var msg = $('#'+id);
                var oFile = msg.find('input[imtype="msg_attach_resend"]')[0].files[0];
                console.log(oFile.name +':'+ oFile.type);

                window.URL = window.URL || window.webkitURL || window.mozURL || window.msURL;
                var url = window.URL.createObjectURL(oFile);
                msg.find('a[imtype="msg_attach_href"]').attr('href', url);
                msg.find('span[imtype="msg_attach_name"]').html(oFile.name);

                var receiver = msg.attr('content_you');
                //查找当前选中的contact_type值 1、IM上传 2、MCM上传
                var current_contact_type = IM.HTML_find_contact_type();
                if(IM._contact_type_m == current_contact_type){
                    IM.EV_sendToDeskAttachMsg(msgid, oFile, 6, receiver);
                }else{
                    IM.EV_sendAttachMsg(msgid, oFile, 6, receiver);
                }

                $('#im_attachment_file').val('');
            },

            /**
             * 选择表情
             * @param unified
             * @param unicode
             * @constructor
             */
            DO_chooseEmoji : function(unified, unicode){
                //var out = emoji.replace_unified(unicode);
                //var content_emoji = '<span style="cursor:pointer;" imtype="content_emoji">'+ out +'&nbsp;</span>';

                var content_emoji = '<img imtype="content_emoji" emoji_value_unicode="'+unicode+'" style="width:18px; height:18px; margin:0 1px 0 1px;" src="img/img-apple-64/'+unified+'.png"/>';

                if( $('#im_send_content').children().length <= 1 ){
                    //var content = $('#im_send_content').html();
                    //if( '<p>' == content.substr(content.length-3, content.length) ){
                    //    $('#im_send_content').html('');
                    //}
                    //if( '<br>' == content.substr(content.length-4, content.length) ){
                    //    //$('#im_send_content').html('');
                    //}
                    //if( '<div>' == content.substr(content.length-5, content.length) ){
                    //    $('#im_send_content').html('');
                    //}
                    $('#im_send_content').find('p').detach();
                    $('#im_send_content').find('br').detach();
                    $('#im_send_content').find('div').detach();
                }

                var brlen = $('#im_send_content').find('br').length - 1;
                $('#im_send_content').find('br').each(function(i){
                    if(i == brlen){
                        $(this).replaceWith('');
                    }
                });

                var plen = $('#im_send_content').find('p').length - 1;
                $('#im_send_content').find('p').each(function(i){
                    if(i < plen){
                        $(this).replaceWith($(this).html()+'<br>');
                    }else{
                        $(this).replaceWith($(this).html());
                    }
                });

                $('#im_send_content').find('div').each(function(i){
                    if('<br>' == $(this).html()){
                        $(this).replaceWith('<br>');
                    }else{
                        $(this).replaceWith('<br>'+$(this).html());
                    }
                });

                var im_send_content = $('#im_send_content').html();

                if('<br>' == im_send_content){
                    im_send_content = '';
                }else{
                    im_send_content = im_send_content.replace(/(<(br)[/]?>)+/g, '\u000A');
                }

                //IM._pre_range_num = IM._pre_range.insertData(content_emoji, IM._pre_range_num);
                $('#im_send_content').html(im_send_content+content_emoji);
                
                $('#emoji_div').hide();
                
            },

            DO_pre_replace_content : function(){
                console.log('pre replace content...');
                //var pres = $('#im_send_content').find('pre');
                //var i=0;
                //while( !!pres && pres.length > 0 ){
                //    console.log(i++);
                //    pres.replaceWith(pres.html());
                //    pres = $('#im_send_content').find('pre');
                //}

                setTimeout(function(){
                    var str = IM.DO_pre_replace_content_to_db();
                    $('#im_send_content').html(str);
                }, 20);
            },

            DO_pre_replace_content_to_db : function(){
                var str = $('#im_send_content').html();
                str = str.replace(/<(div|br|p)[/]?>/g, '\u000A');
                str = str.replace(/\u000A+/g, '\u000D');
                str = str.replace(/<[^img][^>]+>/g, '');//去掉所有的html标记
                str = str.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&amp;/g, '&').replace(/&nbsp;/g, ' ');
                if('\u000D' == str){
                    str = '';
                }
                return str;
            },

            DO_pre_range_num : function(type){
                //console.log(type+':'+IM._pre_range_num);
                //IM._pre_range_num = IM._pre_range.getRange_Num();
            },

            /**
             * 隐藏或显示表情框
             * @constructor
             */
            HTML_showOrHideEmojiDiv : function(){
                if('none' == $('#emoji_div').css('display')){
                    $('#emoji_div').show();
                }else{
                    $('#emoji_div').hide();
                }
            },

            /**
             * 获取当前时间戳  YYYYMMddHHmmss
             * @returns {*}
             */
            _getTimeStamp : function () {
                var now = new Date();
                var timestamp = now.getFullYear()+""
                    + ((now.getMonth() + 1) >= 10 ? (now.getMonth() + 1) : "0" + (now.getMonth() + 1))
                    + (now.getDate() >= 10 ? now.getDate() : "0" + now.getDate())
                    + (now.getHours() >= 10 ? now.getHours() : "0" + now.getHours())
                    + (now.getMinutes() >= 10 ? now.getMinutes() : "0" + now.getMinutes())
                    + (now.getSeconds() >= 10 ? now.getSeconds() : "0" + now.getSeconds());
                return timestamp;
            }

        };
})();

