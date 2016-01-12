$(function() {
	if (document.getElementById('idPosParamBatch')) {
		$('#idPosParamBatch').datagrid({
			iconCls : 'icon-save',
			fit : true,
			nowrap : false,
			striped : true,
			collapsible : true,
			//url : 'queryAppBatchParams.do',
			sortName : 'KEYID',
			sortOrder : 'desc',
			remoteSort : false,
			idField : 'KEYID',
			pageSize : 10,
			pagination : true,
			rownumbers : true,
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : false
			}, {
				field : 'FIELDS',
				title : 'FIELDS',
				hidden : true
			}, {
				title : 'KEYID',
				field : 'KEYID',
				hidden : true
			} ] ],
//			toolbar:[{
//				id:'btnChangeStra',
//				text:'批量修改参数值',
//				iconCls:'icon-ok',
//				handler:function(){     
//					changeBatchParamValues();
//				}
//			}],
			columns : [ [ {
				title : '应用终端号',
				field : 'APOS_ID',
				align : 'center',
				width : 120,
				sortable : true
			}, {
				title : '应用名称',
				field : 'APP_NAME',
				align : 'center',
				width : 120,
				sortable : true
			}, {
				title : '应用版本',
				field : 'APP_VER',
				align : 'center',
				width : 100,
				sortable : true
			}, {
				title : '主机型号',
				field : 'MID',
				align : 'center',
				width : 100,
				sortable : true
			},{
				title : '通讯方式(01000045)',
				field : 'TMS_TXFS',
				align : 'center',
				width : 150,
				sortable : true
			},{
				title : 'GPRS通讯参数(20000007)',
				field : 'TMS_GPRS',
				align : 'center',
				width : 150,
				sortable : true
			},{
				title : 'wifi通讯参数(20000006)',
				field : 'TMS_WIFI',
				align : 'center',
				width : 150,
				sortable : true
			},{
				title : '以太网通讯参数(20000005)',
				field : 'TMS_LAN',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : 'CDMA通讯参数(20000008)',
				field : 'TMS_CDMA',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '异步拨号通讯参数1(20000003)',
				field : 'TMS_MOBILE',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '异步拨号通讯参数2(20000004)',
				field : 'TMS_MOBILE_BAK',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '通讯方式(04000001)',
				field : 'BANK_TXFS',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '主机IP(04000006)',
				field : 'BANK_ADDRESS',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '主机端口(04000007)',
				field : 'BANK_PORT',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '备份主机IP(04000008)',
				field : 'BANK_BAK_ADDRESS',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '备份主机端口(04000009)',
				field : 'BANK_BAK_PORT',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '拨号接入号码1(04000012)',
				field : 'BANK_MOBILE',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '拨号接入号码2(04000013)',
				field : 'BANK_BAK_MOBILE',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '拨号接入号码3(04000014)',
				field : 'BANK_BAK2_MOBILE',
				align : 'center',
				width : 130,
				sortable : true
			},{
				title : '分支机构',
				field : 'REG_NAME',
				align : 'center',
				width : 150,
				sortable : true
			} ] ]
		});
		
		initDataForBatchParams('idAppId,idFidSelect');
		$(".import_toolbar").attr('disabled', false);
		$(".export_toolbar").attr('disabled', false);
		
		var tab = top.tabpanel.tabs('getSelected');
		var moduleTitle=tab.panel('options').title;
  		var moduleId=tab.panel('options').tabId;
		$("#idTmsModuleTitle").attr("value",moduleTitle);
		$("#idTmsModuleId").attr("value",moduleId);
	}

});

// 初始化数据
function initDataForBatchParams(param) {
	$.ajax({
		type : "POST",
		url : "initDataForBatchParams.do",
		data : "param=" + param, // 参数可以是idFidSelect,idMidSelect,idDllDir
		success : function(data) {
			if (data.idAppId) {
				$.each(data.idAppId, function(idx, item) {
					// option += "<option value=" + data.idOrgId[i].ORG_ID +">"
					// + data.idOrgId[i].ORG_NAME+ "</option>";
					option = new Option(item.APP_NAME, item.APP_ID);
					document.getElementById("idAppId").options.add(option);
				});
			}

			if (data.idFidSelect) {// 对idFidSelect(厂商）进行赋值
				var option;
				for ( var i = 0; i < data.idFidSelect.length; i++) {
					option = new Option(data.idFidSelect[i].F_NAME,
							data.idFidSelect[i].FID);
					document.getElementById("idFidSelect").options.add(option);
					// option += "<option value=" + data.idFidSelect[i].FID +">"
					// + data.idFidSelect[i].F_NAME+ "</option>";
				}
				// $("#idFidSelect").append(option);
			}
			if (data.idMidSelect) { // 对idMidSelect(主机型号）进行赋值
				for ( var i = 0; i < data.idMidSelect.length; i++) {
					option = new Option(data.idMidSelect[i].MID_NAME,
							data.idMidSelect[i].MID);
					document.getElementById("idMidSelect").options.add(option);
				}
			}

		}
	});
}

// 根据厂商(FID)改变主机型号
function changeModelByFID(fid) {
	if (fid == "") {
		$("#idMidSelect").empty();
		option = new Option("请选择主机型号", "");
		document.getElementById("idMidSelect").options.add(option);
		return;
	}
	$.ajax({
		type : "POST",
		url : "getModelInfoByFID.do",
		data : "FID=" + fid,
		success : function(data) {
			var option;
			$("#idMidSelect").empty();

			option = new Option("请选择主机型号", "");
			document.getElementById("idMidSelect").options.add(option);

			if (data.idMidSelect) {
				$.each(data.idMidSelect, function(idx, item) {
					option = new Option(item.MID_NAME, item.MID);
					document.getElementById("idMidSelect").options.add(option);
				});
			}

		}
	});

}
// 根据应用编号(appId)改变程序版本
function changeAppVerInfo(appId) {
	$.ajax({
		type : "POST",
		url : "getAppVerInfoIdAndName.do",
		data : "APP_ID=" + appId,
		success : function(data) {
			var option;
			$("#idAppVer").empty();

			option = new Option("请选择程序版本", "");
			if (document.getElementById("idAppVer")) {
				document.getElementById("idAppVer").options.add(option);
			}
			if (data.idAppVer) {
				$.each(data.idAppVer,
						function(idx, item) {
							option = new Option(item.APP_VER, item.APP_VER);
							if (document.getElementById("idAppVer")) {
								document.getElementById("idAppVer").options
										.add(option);
							}
						});
			}
		}
	});
}
//批量修改参数项值
function changeBatchParamValues(){
	//$('#idPosParamBatch').
	 //msgShow('提示','注意必选参数','info');
	var idFidSelect= escape(escape($("#idFidSelect").val()));
	//alert("["+idFidSelect+"]");
	if(idFidSelect==""){
		msgShow('提示消息','请选择终端厂商!','info');
		return;
	}
	var idMidSelect= escape(escape($("#idMidSelect").val()));
	if(idMidSelect==""){
		msgShow('提示消息','请选择主机型号!','info');
		return;
	}
	var idAppId= escape(escape($("#idAppId").val()));
	if(idAppId==""){
		msgShow('提示消息','请选择应用编号!','info');
		return;
	}
	var idAppVer= escape(escape($("#idAppVer").val()));
	if(idAppVer==""){
		msgShow('提示消息','请选择程序版本!','info');
		return;
	}
	
	var rows = $('#idPosParamBatch').datagrid('getRows');
	var num = rows.length;
	if (num < 1) {
		msgShow('提示消息', '无记录不能修改!', 'info');
		return;
	}
	var tmsModuleId = $("#idTmsModuleId").val();
	var tmsModuleTitle = $("#idTmsModuleTitle").val();
	var param={'REG_ID':escape(escape($.trim($('#idRegId').val()))),"APP_ID":escape(escape($.trim($('#idAppId').val()))),
		"APP_VER":escape(escape($.trim($('#idAppVer').val()))),"MODE": escape(escape($.trim($('#idMode').val()))),
		"IP":escape(escape($.trim($('#idIP').val()))),"PORT": escape(escape($.trim($('#idPort').val()))),
		"MOBILE":escape(escape($.trim($('#idMobile').val()))),"MID": escape(escape($.trim($('#idMidSelect').val()))),
		"FID":escape(escape($.trim($('#idFidSelect').val()))),"tmsModuleTitle":tmsJ5ModuleTitle,"tmsModuleId":tmsJ5ModuleId
	};
	

	var retValue = openDialogFrame(getRootPath()+'/core/aposinfo/AposParamBatch-update.jsp',param,"850","650");
	if(retValue!=undefined){
		flashTable("idPosParamBatch");
	}
}
