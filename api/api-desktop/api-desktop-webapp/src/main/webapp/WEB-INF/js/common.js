/**
 * 获取项目根路径
 */
function getWorkPath() {
	var path = "";// "http://localhost:8080/project/";
	// 获取当前网址，如： http://localhost:8080/project/test/index.jsp
	var curWwwPath = window.document.location.href;
	// 获取主机地址之后的目录，如：project/test/index.jsp
	var pathName = window.document.location.pathname;
	var pos = curWwwPath.indexOf(pathName);
	// 获取主机地址，如： http://localhost:8080
	var localhostPath = curWwwPath.substring(0, pos);
	// 获取带"/"的项目名，如：/project
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);

	// 返回路径 http://localhost:8080/project
	path = localhostPath;// + projectName + "/";
	return path;
}


/**
 * 设置表格宽度
 * 
 * @param percent
 * @returns {Number}
 */
function fixWidth(percent) {
	return parseInt((document.body.clientWidth - 300) * percent);
}

function fixWidth_7(percent) {
	return parseInt((document.body.clientWidth - 700) * percent);
}


/**
 * 获取当前日期加时间(如:2009-06-12 12:00)
 * 
 * @returns {String}
 */
function getCurrentTime() {
	// 获取
	var now = new Date();
	var year = now.getFullYear(); // 年
	var month = now.getMonth() + 1; // 月
	var day = now.getDate(); // 日
	var hh = now.getHours(); // 时
	var mm = now.getMinutes(); // 分
	var ss = now.getSeconds(); // 分

	// 组装
	var datetime = year + "-";
	if (month < 10) {
		datetime += "0";
	}
	datetime += month + "-";
	if (day < 10) {
		datetime += "0";
	}
	datetime += day + " ";
	if (hh < 10) {
		datetime += "0";
	}
	datetime += hh + ":";
	if (mm < 10) {
		datetime += '0';
	}
	datetime += mm + ":";
	if (ss < 10) {
		datetime += '0';
	}
	datetime += ss;

	// 返回
	return datetime;
}

/**
 * 设置日期
 */
function getCurrentDay(day) {
	// 起止日期数组
	var startStop = new Array();
	var now = new Date();
	var lastDay = now.getFullYear() + "-" + ((now.getMonth() + 1) < 10 ? "0" : "") + (now.getMonth() + 1) + "-"
			+ (now.getDate() < 10 ? "0" : "") + now.getDate()/*
																 * + " " +
																 * (now.getHours() <
																 * 10 ? "0" :
																 * "") +
																 * now.getHours() +
																 * ":" +
																 * (now.getMinutes() <
																 * 10 ? "0" :
																 * "") +
																 * now.getMinutes()
																 */;

	now.setDate(now.getDate() - day);// 获取6天前的日期
	var firstDay = now.getFullYear() + "-" + ((now.getMonth() + 1) < 10 ? "0" : "") + (now.getMonth() + 1) + "-"
			+ (now.getDate() < 10 ? "0" : "") + now.getDate()/*
																 * + " " +
																 * (now.getHours() <
																 * 10 ? "0" :
																 * "") +
																 * now.getHours() +
																 * ":" +
																 * (now.getMinutes() <
																 * 10 ? "0" :
																 * "") +
																 * now.getMinutes()
																 */;

	// 起始时间
	var beginTime = firstDay + " 00:00";
	// 终止时间
	var endTime = lastDay + " 23:59";
	// 添加至数组中
	startStop.push(beginTime);
	startStop.push(endTime);

	// 返回
	return startStop;
}

/**
 * 获得本周起止时间
 */
function getCurrentWeek() {
	// 起止日期数组
	var startStop = new Array();
	// 获取当前时间
	var currentDate = new Date();
	// 返回date是一周中的某一天
	var week = currentDate.getDay();
	// 返回date是一个月中的某一天
	var month = currentDate.getDate();
	// 一天的毫秒数
	var millisecond = 1000 * 60 * 60 * 24;
	// 减去的天数
	var minusDay = week != 0 ? week - 1 : 6;
	// 本周 周一
	var monday = new Date(currentDate.getTime() - (minusDay * millisecond));
	// 本周 周日
	var sunday = new Date(monday.getTime() + (6 * millisecond));

	// 本周起始时间
	var beginTime = monday.getFullYear() + "-" + ((monday.getMonth() + 1) < 10 ? "0" : "") + (monday.getMonth() + 1)
			+ "-" + (monday.getDate() < 10 ? "0" : "") + monday.getDate() + " 00:00";
	// 本周终止时间
	var endTime = sunday.getFullYear() + "-" + ((sunday.getMonth() + 1) < 10 ? "0" : "") + (sunday.getMonth() + 1)
			+ "-" + (sunday.getDate() < 10 ? "0" : "") + sunday.getDate() + " 23:59";
	// 添加至数组中
	startStop.push(beginTime);
	startStop.push(endTime);

	// 返回
	return startStop;
}

/*
 * 获得本月的起止时间
 */
function getCurrentMonth() {
	// 起止日期数组
	var startStop = new Array();
	// 获取当前时间
	var currentDate = new Date();
	// 获得当前月份0-11
	var currentMonth = currentDate.getMonth();
	// 获得当前年份4位年
	var currentYear = currentDate.getFullYear();
	// 求出本月第一天
	var firstDay = new Date(currentYear, currentMonth, 1);
	// 当为12月的时候年份需要加1
	// 月份需要更新为0 也就是下一年的第一个月
	if (currentMonth == 11) {
		currentYear++;
		currentMonth = 0;// 就为
	}
	else {
		// 否则只是月份增加,以便求的下一月的第一天
		currentMonth++;
	}
	// 一天的毫秒数
	var millisecond = 1000 * 60 * 60 * 24;
	// 下月的第一天
	var nextMonthDayOne = new Date(currentYear, currentMonth, 1);
	// 求出上月的最后一天
	var lastDay = new Date(nextMonthDayOne.getTime() - millisecond);

	// 本周起始时间
	var beginTime = firstDay.getFullYear() + "-" + ((firstDay.getMonth() + 1) < 10 ? "0" : "")
			+ (firstDay.getMonth() + 1) + "-" + (firstDay.getDate() < 10 ? "0" : "") + firstDay.getDate() + " 00:00";
	// 本周终止时间
	var endTime = lastDay.getFullYear() + "-" + ((lastDay.getMonth() + 1) < 10 ? "0" : "") + (lastDay.getMonth() + 1)
			+ "-" + (lastDay.getDate() < 10 ? "0" : "") + lastDay.getDate() + " 23:59";

	// 添加至数组中
	startStop.push(beginTime);
	startStop.push(endTime);

	// 返回
	return startStop;
}

/**
 * 设置cookie
 * 
 * @param name 名称
 * @param value 值
 */
function setCookie(name, value) {
	var expdate = new Date(); // 初始化时间
	expdate.setTime(expdate.getTime() + 30 * 60 * 1000); // 时间
	document.cookie = name + "=" + value + ";expires=" + expdate.toGMTString() + "";
}

/**
 * 获取cookie
 * 
 * @param name 名称
 */
function getCookie(name) {
	var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
	if (arr = document.cookie.match(reg))
		return unescape(arr[2]);
	else
		return null;
}

/**
 * 删除cookie
 * 
 * @param name 名称
 */
function delCookie(name) {
	var exp = new Date();
	exp.setTime(exp.getTime() - 1);
	var cval = getCookie(name);
	if (cval != null) {
		document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
	}
}

/**
 * 时间比较(yyyy-mm-dd hh:mi:ss)
 * 
 * @returns
 */
function datetimeCompare() {
	var beginTime = "2015-09-21 00:00:00";
	var endTime = "2015-09-21 00:00:01";
	var beginTimes = beginTime.substring(0, 10).split('-');
	var endTimes = endTime.substring(0, 10).split('-');

	beginTime = beginTimes[1] + '-' + beginTimes[2] + '-' + beginTimes[0] + ' ' + beginTime.substring(10, 19);
	endTime = endTimes[1] + '-' + endTimes[2] + '-' + endTimes[0] + ' ' + endTime.substring(10, 19);

	alert(beginTime + "aaa" + endTime);
	alert(Date.parse(endTime));
	alert(Date.parse(beginTime));
	var a = (Date.parse(endTime) - Date.parse(beginTime)) / 3600 / 1000;
	if (a < 0) {
		alert("endTime小!");
	}
	else if (a > 0) {
		alert("endTime大!");
	}
	else if (a == 0) {
		alert("时间相等!");
	}
	else {
		return 'exception'
	}
}

/**
 * 将秒数换成时分秒格式
 */
function formatSeconds(value) {
	var theTime = parseInt(value);// 秒
	var theTime1 = 0;// 分
	var theTime2 = 0;// 小时
	if (theTime > 60) {
		theTime1 = parseInt(theTime / 60);
		theTime = parseInt(theTime % 60);
		if (theTime1 > 60) {
			theTime2 = parseInt(theTime1 / 60);
			theTime1 = parseInt(theTime1 % 60);
		}
	}
	var result = "" + parseInt(theTime) + "秒";
	if (theTime1 > 0) {
		result = "" + parseInt(theTime1) + "分" + result;
	}
	if (theTime2 > 0) {
		result = "" + parseInt(theTime2) + "小时" + result;
	}
	return result;
}

/**
 * arrayToJson将数组转化为json格式
 * 
 * @param o
 * @returns
 */
function arrayToJson(o) {
	var r = [];
	if (typeof o == "string")
		return "\""
				+ o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g,
						"\\t") + "\"";
	if (typeof o == "object") {
		if (!o.sort) {
			for ( var i in o)
				r.push(i + ":" + arrayToJson(o[i]));
			if (!!document.all
					&& !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
				r.push("toString:" + o.toString.toString());
			}
			r = "{" + r.join() + "}";
		}
		else {
			for (var i = 0; i < o.length; i++) {
				r.push(arrayToJson(o[i]));
			}
			r = "[" + r.join() + "]";
		}
		return r;
	}
	return o.toString();
}
