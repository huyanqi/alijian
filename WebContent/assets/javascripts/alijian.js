function getLevel(url,credit){
	var imghtml = "";
	if(fanwei(1,500,credit)){
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
	}
	if(fanwei(500,5000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
	}
	if(fanwei(5000,20000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
	}
	if(fanwei(20000,50000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
	}
	if(fanwei(50000,100000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level1.png"+"'/>";
	}
	if(fanwei(100000,300000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
	}
	if(fanwei(300000,1000000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
	}
	if(fanwei(1000000,2000000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
	}
	if(fanwei(2000000,5000000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
	}
	if(fanwei(5000000,10000000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level2.png"+"'/>";
	}
	if(fanwei(10000000,20000000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
	}
	if(fanwei(20000000,50000000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
	}
	if(fanwei(50000000,200000000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
	}
	if(fanwei(200000000,500000000,credit)){
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
	}
	if(credit>=500000000){
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
		imghtml += "<img src='"+url+"font/imgs/level3.png"+"'/>";
	}
	return imghtml;
}

function fanwei(num1,num2,credit){
	if(num1<=credit && credit <num2)
		return true;
	return false;
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