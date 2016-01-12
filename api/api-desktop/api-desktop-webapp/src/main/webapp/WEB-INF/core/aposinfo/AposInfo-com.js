function queryApp(idAppId,idAppName) {	
	var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AppInfo-query.jsp","","650","400");
	if(retValue!=undefined) {
		var i = retValue.indexOf('_');
		var appId = retValue.substring(0,i);
		var appName = retValue.substring(i+1);
		$('#'+idAppId).val(appId);
		$('#'+idAppName).val(appName);
		//当所选择应用为多应用管理器时，禁用商户输入域
		if(appId=='00000000') {
			//清除终端号
			$('#idTerminalId').val('');
			$('#idTerminalId').attr('readonly','readonly');
			$('#idTerminalId').addClass('readonly');

			//清除商户号等
			$('#btn_queryMerch').hide();
			$('#btn_clearMerch').hide();
			clearMerch();

		}else{
			$('#idTerminalId').removeAttr('readonly');
			$('#idTerminalId').removeClass('readonly');

			$('#btn_queryMerch').show();
			$('#btn_clearMerch').show();

		}
		//设置应用版本列表
		$.getJSON('listAppverForCombox.do',{APP_ID:appId},function(data){
			if(data!=null) {
				$('#idAppVer').empty();
				$('#idAppVer').append('<option value="">请选择应用版本</option>');
				for(var i=0;i<data.length;i=i+1) {
					$('#idAppVer').append('<option value="'+data[i].APP_VER+'">'+data[i].APP_VER+'</option>');
				}
			}
		});
		//设置参数模板列表
		$.getJSON('getParamModuleName.do',{APP_ID:appId},function(data) {
			//idparamodId
			$('#idParamModelId').empty();
			$('#idParamModelId').append('<option value="">请选择参数模板</option>');
			if(data.idparamodId) {
				$.each(data.idparamodId,function(idx,item){
					$('#idParamModelId').append('<option value="'+item.PARAM_MODEL_ID+'">'+item.PARAMMODEL_NAME+'</option>');
				});
			}
		});
	}
}

function clearApp(idAppId,idAppName) {
	$('#'+idAppId).val('');
	$('#'+idAppName).val('');
	$('#idAppVer').empty();
	$('#idAppVer').append('<option value="">请选择应用版本</option>');
	$('#idParamModelId').empty();
	$('#idParamModelId').append('<option value="">请选择参数模板</option>');
}

function queryMerch() {
	var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/MerchInfo-query.jsp","","800","450");
	if(retValue!=undefined) {
		$('#idMerchId').val(retValue.merchId);
		$('#idMerchName').val(retValue.merchName);
	}
}

function clearMerch() {
	$('#idMerchId').val('');
	$('#idMerchName').val('');
}

function resetAposAppForm() {
	$('#dd').form('clear');
	$('#idAppVer').empty();
	$('#idAppVer').append('<option value="">请选择应用版本</option>');
	$('#idParamModelId').empty();
	$('#idParamModelId').append('<option value="">请选择参数模板</option>');
	$('#idMasterAppFlag').empty();
	$('#idMasterAppFlag').append('<option value="0">否</option>');
	$('#idMasterAppFlag').append('<option value="1">是</option>');
}

//检查应用终端的应用明细列表，确保当前应用拥有‘一’个主控、‘一’个主应用
function validateApos(flag) {
	var consoleCount = 0;
	var masterCount = 0;

	var rows = $('#idAposAppInfo').datagrid('getRows');
	$.each(rows, function(idx, item){
		if(item.APP_ID=='00000000') consoleCount++;
		if(item.MASTER_APP_FLAG=='1') masterCount++;
	});
	
	if(consoleCount==0) {
		if(flag!=undefined && flag=='check') {
			return "当前应用终端缺少多应用管理器";
		}else{
			msgShow("信息提示","请为该应用终端添加多应用管理器！","info");
			return "false";
		}
	}
	if(masterCount==0) {
		if(flag!=undefined && flag=='check') {
			return "当前应用终端缺少主应用";
		}else{
			msgShow("信息提示","请为该应用终端添加主应用！","info");
			return "false";
		}
		
	}
	
	return "true";
}

//应用明细增加校验
//aposAppInfoObj: 封装应用明细表单输入信息的json对象
function validateAposAppInfoForAdd(aposAppInfoObj) {
	var opType = 'add';
	var consoleCount = 0;//主控计数
	var masterCount = 0;//主应用计数
	var _repeat = false;//当前操作的应用是否已经存在

	var rows = $('#idAposAppInfo').datagrid('getRows');
	$.each(rows, function(idx, item){
		if(item.APP_ID=='00000000') consoleCount++;
		if(item.MASTER_APP_FLAG=='1') masterCount++;
		if(item.APP_ID==aposAppInfoObj.APP_ID) _repeat=true;
	});
	if(aposAppInfoObj.APP_ID=='00000000' && aposAppInfoObj.MASTER_APP_FLAG=='1') {
		msgShow('提示信息','多应用管理器不能是主应用！','info');
		return false;
	}
	if(opType=='add') {//新增应用明细校验
		if(aposAppInfoObj.APP_ID=='00000000') {//新增主控
			if(consoleCount>0) {
				msgShow('提示信息','该应用终端已经存在多应用管理器，一个应用终端只能存在一个多应用管理器！','info');
				return false;
			}
		}else{//新增应用
			if(_repeat) {
				msgShow('提示信息','该应用终端已经存在该应用，不能重复添加！','info');
				return false;
			}
			if(aposAppInfoObj.MASTER_APP_FLAG=='1') {//主应用
				if(masterCount>0) {
					msgShow('提示信息','该应用终端已经存在主应用，一个应用终端只能存在一个主应用！','info');
					return false;
				}
			}
		}
	}
	return true;
}

//应用明细编辑校验
//aposAppInfoObj: 封装应用明细表单输入信息的json对象
function validateAposAppInfoForEdit(aposAppInfoObj) {
	var opType = 'edit';
	
	if(aposAppInfoObj.APP_ID=='00000000' && aposAppInfoObj.MASTER_APP_FLAG=='1') {
		msgShow('提示信息','多应用管理器不能是主应用！','info');
		return false;
	}
	
	if(opType=='edit') {//修改应用明细校验
		var rows = $('#idAposAppInfo').datagrid('getRows');
		if(aposAppInfoObj.MASTER_APP_FLAG=='1') {
			for(var i=0; i<rows.length; i++) {
				if(rows[i].APP_ID!=aposAppInfoObj.APP_ID && rows[i].MASTER_APP_FLAG=='1') {
					msgShow('提示信息','该应用终端已经存在主应用！','info');
					return false;
				}
			}
		}
	}
	return true;
}

//修改商户
function modifyMerchId(aposId, appId, terminalId) {
	var tmsModuleId = window.dialogArguments.tmsModuleId;
	var tmsModuleTitle = window.dialogArguments.tmsModuleTitle;
	
	var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/MerchInfo-query.jsp","","800","450");
	if(retValue!=undefined) {
		var merchId = $.trim(retValue.merchId);
		var merchName = $.trim(retValue.merchName);
		//showProcess(true,"稍等", "正在处理中……");
		$.getJSON('modifyMerchInfo.do',
			{aposId:aposId, appId:appId, merchId:merchId, merchName:escape(merchName), terminalId:terminalId, tmsModuleId:tmsModuleId, tmsModuleTitle:escape(tmsModuleTitle)},
			function(data){
				//showProcess(false);
				if(data!=null) {
					if(data.status!=null && data.status=='true') {
						msgShow('提示','修改成功！','info');
						//刷新应用终端应用明细列表
						$('#idAposAppInfo').datagrid('options').url="listAposAppInfo.do?APOS_ID="+aposId;
						$('#idAposAppInfo').datagrid('load');
						
						$('#idFlag').val('true');
					}else{
						msgShow('提示',data.message,'error');
					}
				}
			}
		);
	}
}



//修改终端号
function modifyTerminalId(aposId, appId, merchId,terminalId) {
	var tmsModuleId = window.dialogArguments.tmsModuleId;
	var tmsModuleTitle = window.dialogArguments.tmsModuleTitle;
	//var param="aposId="+aposId+"&appId="+appId+"&merchId="+merchId+"&tmsModuleId="+tmsModuleId+"&tmsModuleTitle="+escape(escape(tmsModuleTitle));
	var param=terminalId;
	var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposTerminalModif.jsp",param,"300","100");
	
	if(retValue){
		$.getJSON('modifyTerminalInfo.do',
				{aposId:aposId, appId:appId, terminalId:retValue, merchId:merchId, tmsModuleId:tmsModuleId, tmsModuleTitle:escape(tmsModuleTitle)},
				function(data) {
					//showProcess(false);
					if(data!=null) {
						if(data.status!=null && data.status=='true') {
							msgShow('提示','修改成功！','info');
							//刷新应用终端应用明细列表
							$('#idAposAppInfo').datagrid('options').url="listAposAppInfo.do?APOS_ID="+aposId;
							$('#idAposAppInfo').datagrid('load');
							
							$('#idFlag').val('true');
						}else{
							msgShow('提示',data.message,'error');
						}
					}
				}
			);
	}
	
	
}

//修改终端号
function modifyTerminalId11(aposId, appId, merchId) {
	var tmsModuleId = window.dialogArguments.tmsModuleId;
	var tmsModuleTitle = window.dialogArguments.tmsModuleTitle;
	
	$.messager.prompt('修改终端号', '请在此输入8位数字终端号', function(terminalId){
		if (terminalId){
			terminalId = $.trim(terminalId);
			if((/^[0-9]+$/i.test(terminalId)) && (terminalId.length==8)) {
				//showProcess(true,"稍等", "正在处理中……");
				$.getJSON('modifyTerminalInfo.do',
					{aposId:aposId, appId:appId, terminalId:terminalId, merchId:merchId, tmsModuleId:tmsModuleId, tmsModuleTitle:escape(tmsModuleTitle)},
					function(data) {
						//showProcess(false);
						if(data!=null) {
							if(data.status!=null && data.status=='true') {
								msgShow('提示','修改成功！','info');
								//刷新应用终端应用明细列表
								$('#idAposAppInfo').datagrid('options').url="listAposAppInfo.do?APOS_ID="+aposId;
								$('#idAposAppInfo').datagrid('load');
								
								$('#idFlag').val('true');
							}else{
								msgShow('提示',data.message,'error');
							}
						}
					}
				);
			}else{
				msgShow('提示','所输入的终端号格式错误，终端号为8位数字','info');
			}
		}
	});
}

//添加终端应用信息
function addAposAppInfo() {
	var apos_id = $('#idAposId').val();
	if(apos_id=="") {
		msgShow("提示消息","请先添加应用终端","info");
		return false;
	}
	if(!$('#dd').form('validate')) return false;
	//验证在非主控应用条件下，是否输入商户、终端数据
	var app_id = $('#idAppId').val();
	if(app_id=='00000000') {
		
	}else{
		if($('#idMerchName').val()=='') {
			msgShow('提示消息','请选择商户','info');
			return false;
		}
		if($('#idTerminalId').val()=='') {
			msgShow('提示消息','请输入终端号','info');
			return false;
		}
	}
	
	var date = new Date();
	var tmsModuleId = window.dialogArguments.tmsModuleId;
	var tmsModuleTitle = window.dialogArguments.tmsModuleTitle;
	var param = {flag:date.getTime(),
				APOS_ID:apos_id,
				APP_ID:$('#idAppId').val(),
				APP_VER:$('#idAppVer').val(),
				PARAM_MODEL_ID:$('#idParamModelId').val(),
				MASTER_APP_FLAG:$('#idMasterAppFlag').val(),
				MERCH_ID:$('#idMerchId').val(),
				MERCH_NAME:escape($('#idMerchName').val()),
				TERMINAL_ID:$('#idTerminalId').val(),
				REG_ID:$('#idRegId').val(),
				REG_ENTIRE_ID:$('#idRegEntireId').val(),
				tmsModuleId:tmsModuleId,
				tmsModuleTitle:escape(tmsModuleTitle)
				};
	if(!validateAposAppInfoForAdd(param)) return false;
	
	showProcess(true,"稍等", "正在处理中……");
	$.getJSON('addAposAppInfo.do',param,function(data){
		showProcess(false);
		if(data!=null) {
			if(data.status=="true") {
				msgShow("信息提示","添加成功","info");
				$('#idFlag').val("true");
				//刷新应用终端应用明细列表
				$('#idAposAppInfo').datagrid('options').url="listAposAppInfo.do?APOS_ID="+apos_id;
				$('#idAposAppInfo').datagrid('load');
				//重置表单
				resetAposAppForm();
			}else{
				msgShow("信息提示",data.message,"error");
			}
		}
	});

}

//修改应用明细-明细表
function editAposAppInfo(aposId, appId) {
	$.getJSON('queryAposAppInfo.do',{APOS_ID:aposId, APP_ID:appId},function(data){
		$.each(data.rows, function(idx, item) {
			$('#idAppId').val(item.APP_ID);
			$('#idAppName').val(item.APP_NAME);
			//如果是主控，禁用商户、终端号输入域
			if(item.APP_ID=="00000000") {
				$('#btn_queryMerch').hide();
				$('#btn_clearMerch').hide();
				$('#idTerminalId').attr('readonly','readonly');
				$('#idTerminalId').addClass('readonly');
			}else{
				$('#btn_queryMerch').show();
				$('#btn_clearMerch').show();
				$('#idTerminalId').removeClass('readonly');
				$('#idTerminalId').removeAttr('readonly');
			}
			
			//禁止用户应用明细修改时变更应用，更新完成时恢复显示
			$('#btnQueryApp').hide();
			$('#btnClearApp').hide();
			
			var appId = item.APP_ID;
			//设置应用版本列表
			$.getJSON('listAppverForCombox.do',{APP_ID:appId},function(data){
				if(data!=null) {
					$('#idAppVer').empty();
					$('#idAppVer').append('<option value="">请选择应用版本</option>');
					for(var i=0;i<data.length;i=i+1) {
						if(data[i].APP_VER == item.APP_VER) 
							$('#idAppVer').append('<option value="'+data[i].APP_VER+'" selected>'+data[i].APP_VER+'</option>');
						else
							$('#idAppVer').append('<option value="'+data[i].APP_VER+'">'+data[i].APP_VER+'</option>');
					}
				}
			});
			//设置参数模板列表
			$.getJSON('getParamModuleName.do',{APP_ID:appId},function(data) {
				//idparamodId
				$('#idParamModelId').empty();
				$('#idParamModelId').append('<option value="">请选择参数模板</option>');
				if(data.idparamodId) {
					$.each(data.idparamodId,function(idx,it){
						if(item.PARAM_MODEL_ID==it.PARAM_MODEL_ID)
							$('#idParamModelId').append('<option value="'+it.PARAM_MODEL_ID+'" selected>'+it.PARAMMODEL_NAME+'</option>');
						else
							$('#idParamModelId').append('<option value="'+it.PARAM_MODEL_ID+'">'+it.PARAMMODEL_NAME+'</option>');
					});
				}
			});
			
			$('#idSrcModelId').val(item.PARAM_MODEL_ID); //设置参数模板隐藏域，以区别是否变更了参数模板
			$('#idMasterAppFlag').val(item.MASTER_APP_FLAG);
			$('#idMerchId').val(item.MERCH_ID);
			$('#idMerchName').val(item.MERCH_NAME);
			$('#idTerminalId').val(item.TERMINAL_ID);
			
			//禁用、恢复按钮
			$('#btnAddAppInfo').attr('disabled',true);//禁用
			$('#btnUpdateAppInfo').attr('disabled',false);//恢复
		});
	});
}

//更新终端应用信息
function updateAposAppInfo() {
	var apos_id = $('#idAposId').val();
	if(apos_id=="") {
		msgShow("提示消息","请先添加应用终端","info");
		return false;
	}
	if(!$('#dd').form('validate')) return false;
	//验证在非主控应用条件下，是否输入商户、终端数据
	var app_id = $('#idAppId').val();
	if(app_id=='00000000') {
		
	}else{
		if($('#idMerchName').val()=='') {
			msgShow('提示消息','请选择商户','info');
			return false;
		}
		if($('#idTerminalId').val()=='') {
			msgShow('提示消息','请输入终端号','info');
			return false;
		}
	}
	
	var date = new Date();
	var tmsModuleId = window.dialogArguments.tmsModuleId;
	var tmsModuleTitle = window.dialogArguments.tmsModuleTitle;
	var param = {flag:date.getTime(),
				APOS_ID:apos_id,
				APP_ID:$('#idAppId').val(),
				APP_VER:$('#idAppVer').val(),
				PARAM_MODEL_ID:$('#idParamModelId').val(),
				SRC_MODEL_ID:$('#idSrcModelId').val(),
				MASTER_APP_FLAG:$('#idMasterAppFlag').val(),
				MERCH_ID:$('#idMerchId').val(),
				MERCH_NAME:escape($('#idMerchName').val()),
				TERMINAL_ID:$('#idTerminalId').val(),
				REG_ID:$('#idRegId').val(),
				REG_ENTIRE_ID:$('#idRegEntireId').val(),
				tmsModuleId:tmsModuleId,
				tmsModuleTitle:escape(tmsModuleTitle)};
	if(!validateAposAppInfoForEdit(param)) return false;
	
	showProcess(true,"稍等", "正在处理中……");
	$.getJSON('updateAposAppInfo.do',param,function(data){
		showProcess(false);
		if(data!=null) {
			if(data.status=="true") {
				msgShow("信息提示","修改成功","info");
				$('#idFlag').val("true");
				//刷新应用终端应用明细列表
				$('#idAposAppInfo').datagrid('options').url="listAposAppInfo.do?APOS_ID="+apos_id;
				$('#idAposAppInfo').datagrid('load');
				//重置表单
				resetAposAppForm();
				//恢复按钮设置
				$('#btnAddAppInfo').attr('disabled',false);//恢复
				$('#btnUpdateAppInfo').attr('disabled',true);//禁用
				//显示应用选择按钮
				$('#btnQueryApp').show();
				$('#btnClearApp').show();
				
				$('#btn_queryMerch').show();
				$('#btn_clearMerch').show();
				$('#idTerminalId').removeAttr('readonly');
				$('#idTerminalId').removeClass('readonly');
			}else{
				msgShow("信息提示",data.message,"error");
			}
		}
	});
}

//删除应用明细-明细表
function delAposAppInfo(aposId, appId) {
	//重置表单
	//---------------
	resetAposAppForm();
	//恢复按钮设置
	$('#btnAddAppInfo').attr('disabled',false);//恢复
	$('#btnUpdateAppInfo').attr('disabled',true);//禁用
	//显示应用选择按钮
	$('#btnQueryApp').show();
	$('#btnClearApp').show();
	
	$('#btn_queryMerch').show();
	$('#btn_clearMerch').show();
	$('#idTerminalId').removeAttr('readonly');
	$('#idTerminalId').removeClass('readonly');
	//----------------
	
	var tmsModuleId = window.dialogArguments.tmsModuleId;
	var tmsModuleTitle = window.dialogArguments.tmsModuleTitle;
	$.getJSON('delAposAppInfo.do',{APOS_ID:aposId, APP_ID:appId, tmsModuleId:tmsModuleId, tmsModuleTitle:escape(tmsModuleTitle)},function(data){
		if(data!=null) {
			if(data.status=='true') {
				msgShow("信息提示","删除成功","info");
				$('#idFlag').val("true");
				//刷新应用终端应用明细列表
				$('#idAposAppInfo').datagrid('options').url="listAposAppInfo.do?APOS_ID="+$.trim($('#idAposId').val());
				$('#idAposAppInfo').datagrid('load');
			}else{
				msgShow("信息提示",data.message,"error");
			}
		}
	});
}

//设置参数-明细表
function setupAppParam(apos_id,app_id) {
	tmsJ5ModuleTitle=window.dialogArguments.tmsModuleTitle;
	tmsJ5ModuleId=window.dialogArguments.tmsModuleId;
	var param = {APOS_ID:apos_id, APP_ID:app_id};
	var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposAppParam.jsp",param,"920","550");
}