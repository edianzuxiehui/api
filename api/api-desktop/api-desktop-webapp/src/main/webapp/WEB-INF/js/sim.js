$(document).ready(function() {
	var dTxfy = {
		head : [ {
			id : "0",
			value : "Modem"
		}, {
			id : "1",
			value : "GPRS"
		} ]
	};
	var dAddress = {
		head : [ {
			id : "203.81.23.7",
			value : "203.81.23.7"
		}, {
			id : "203.81.23.4",
			value : "203.81.23.4"
		} ]
	};
	var dYwParam = {
			head : [ {
				id : "CMNET",
				value : "CMNET"
			}, {
				id : "APN",
				value : "APN"
			}]
		};
	var dPort = {
		head : [ {
			id : "9007",
			value : "9007"
		}, {
			id : "9907",
			value : "9907"
		} ]
	};

	var dMobiles = {
		head : [ {
			id : "57835373",
			value : "57835373"
		}, {
			id : "(010)57835373",
			value : "(010)57835373"
		}, {
			id : "010-57835373",
			value : "010-57835373"
		}, {
			id : "01057835373",
			value : "01057835373"
		}, {
			id : "57835377",
			value : "57835377"
		}, {
			id : "(010)57835377",
			value : "(010)57835377"
		}, {
			id : "010-57835377",
			value : "010-57835377"
		}, {
			id : "01057835377",
			value : "01057835377"
		}, {
			id : "85186898",
			value : "85186898"
		}, {
			id : "(010)85186898",
			value : "(010)85186898"
		}, {
			id : "010-85186898",
			value : "010-85186898"
		}, {
			id : "01085186898",
			value : "01085186898"
		} ]
	};
	initMode(dTxfy);
	initAddress(dAddress);
	initPort(dPort);
	dMobiles.head.sort(getSortFun('desc', 'id'));
	// printObject(dMobiles);
	initMobiles(dMobiles);
	//initYwParam(dYwParam);
});

function printObject(obj) {
	var temp = "";
	for ( var i in obj) {// 用javascript的for/in循环遍历对象的属性
		temp += i + ":" + obj[i] + "\n";
	}
	alert(temp);// 结果：cid:C0 \n ctext:区县
}

function initMode(data) {

	$("#idMode").empty();
	var option = new Option("请选择通讯方式", "");
	document.getElementById("idMode").options.add(option);
	for ( var i = 0; i < data.head.length; i++) {
		option = new Option(data.head[i].value, data.head[i].id);
		document.getElementById("idMode").options.add(option);
	}
}

function initYwParam(data) {

	$("#idYwParam").empty();
	var option = new Option("请选择业务参数", "");
	document.getElementById("idYwParam").options.add(option);
	for ( var i = 0; i < data.head.length; i++) {
		option = new Option(data.head[i].value, data.head[i].id);
		document.getElementById("idYwParam").options.add(option);
	}
}

function initAddress(data) {

	$("#idIP").empty();
	var option = new Option("请选择IP地址", "");
	document.getElementById("idIP").options.add(option);
	for ( var i = 0; i < data.head.length; i++) {
		option = new Option(data.head[i].value, data.head[i].id);
		document.getElementById("idIP").options.add(option);
	}
}

function initPort(data) {

	$("#idPort").empty();
	var option = new Option("请选择端口", "");
	document.getElementById("idPort").options.add(option);
	for ( var i = 0; i < data.head.length; i++) {
		option = new Option(data.head[i].value, data.head[i].id);
		document.getElementById("idPort").options.add(option);
	}
}

function initMobiles(data) {

	$("#idMobile").empty();
	var option = new Option("请选择电话号码", "");
	document.getElementById("idMobile").options.add(option);
	for ( var i = 0; i < data.head.length; i++) {
		option = new Option(data.head[i].value, data.head[i].id);
		document.getElementById("idMobile").options.add(option);
	}
}

function getSortFun(order, sortBy) {
	var ordAlpah = (order == 'asc') ? '>' : '<';
	var sortFun = new Function('a', 'b', 'return a.' + sortBy + ordAlpah + 'b.'
			+ sortBy + '?1:-1');
	return sortFun;
}

/*
 * @function JsonSort 对json排序 @param json 用来排序的json @param key 排序的键值
 */
function JsonSort(json, key) {
	// console.log(json);
	for ( var j = 1, jl = json.length; j < jl; j++) {
		var temp = json[j], val = temp[key], i = j - 1;
		while (i >= 0 && json[i][key] > val) {
			json[i + 1] = json[i];
			i = i - 1;
		}
		json[i + 1] = temp;

	}
	// console.log(json);
	return json;

}

function sortByKey(array, key) {
	return array.sort(function(a, b) {
		var x = a[key];
		var y = b[key];
		return ((x < y) ? -1 : ((x > y) ? 1 : 0));
	});
}
