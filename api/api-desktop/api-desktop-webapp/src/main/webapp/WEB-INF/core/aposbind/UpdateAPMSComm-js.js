
function doBack() {
	parent.$("#tt").tabs("select", 0);
	parent.$("#tt").tabs("enableTab", 0);
	parent.$("#tt").tabs("disableTab", 1);
}
function doNext() {
	if (!$("#ff").form("validate")) {
		return;
	}
	parent.$("#tt").tabs("select", 1);
	parent.$("#tt").tabs("enableTab", 1);
	parent.$("#tt").tabs("disableTab", 0);
}
function doFinish() {
	if (!validateAPMSApos()) {
		return false;
	}//关闭窗口前检查应用终端应用明细设置
	//checkAposBindable
	var mid = parent.$("#idMid").val();
	var aposId = $("#idAposId").val();
	$.getJSON("checkAposBindable.do", {APOSID:aposId,MID:mid}, function (data) {
		if(data.status =="true"){
			parent.window.returnValue = "true"; 
			window.close();
			
		}else{
			msgShow('提示消息',data.message,'info');
		}
	});
}
function validateAPMSApos() {
	var consoleCount = 0;
	var masterCount = 0;
	var appVerCount = 0;
	var rows = $("#idAposAppInfo").datagrid("getRows");
	$.each(rows, function (idx, item) {
		if (item.APP_ID == "00000000") {
			consoleCount++;
		}
		if (item.MASTER_APP_FLAG == "1") {
			masterCount++;
		}
		if (item.APP_VER == null) {
			appVerCount++;
		}
	});

	if (appVerCount != 0) {
		msgShow("提示信息", "有应用的应用版本为空，请修改该应用!!!", "info");
		return false;
	}
	if(consoleCount==0) {
		msgShow("信息提示","请为该应用终端添加多应用管理器!!!","info");
		return false;
	}
	if(masterCount==0) {
		msgShow("信息提示","请为该应用终端添加主应用!!!","info");
		return false;
	}
	return true;
}

