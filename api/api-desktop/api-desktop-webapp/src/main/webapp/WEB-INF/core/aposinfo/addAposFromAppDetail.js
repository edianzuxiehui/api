//添加应用终端
function addAposFromDetail() {
	if(!$('#ff').form('validate')) return false;
	
	var tmsModuleId = window.dialogArguments.tmsModuleId;
	var tmsModuleTitle = window.dialogArguments.tmsModuleTitle;
	var param = {
		tmsModuleId: tmsModuleId,
		tmsModuleTitle: escape(tmsModuleTitle),
		APOS_ID: $('#idAposId').val(),
		REG_ID: $('#idRegId').val(),
		REG_ENTIRE_ID: $('#idRegEntireId').val(),
		APOS_ADDR: escape($('#idAposAddr').val()),
		STRATEGY_ID: $('#idStrategyId').val()
	};
	$.getJSON('addAposInfo.do',param,function(data) {
		if(data!=null) {
			if(data.status!=null && data.status=='true') {
				msgShow("信息提示","添加成功，请继续添加终端应用明细","info");
				$('#idFlag').val("true");
				$('#btnRegSel').hide();
	        	$('#btnRegClr').hide();
	        	$('#idAposAddr').attr('readonly','readonly');
	        	$('#btnStraSel').hide();
	        	$('#btnStraClr').hide();
	        	$('#btnAddApos').attr('disabled',true);
	        	$('#btnAddAppInfo').attr('disabled',false);
			}else{
				msgShow("信息提示",data.message,"error");
			}
		}
	});
}

//选择报到策略
function selectStrategy() {
	var retValue = openDialogFrame(getRootPath()+'/core/aposinfo/Strategy-query.jsp','','800','300');
	if(retValue!=undefined) {
		$('#idStrategyId').val(retValue);		
	}
}

function doCheck(evt) {
	var isCheck = $('#idIsCheck').val();
	if(isCheck!='false') {
		if($('#idFlag').val()=='true') {
			window.returnValue='true';
		}
		
		if($('#btnAddApos').attr('disabled')) {
			var msg = validateApos('check');
			if(msg!='true') {
				if(evt.target || evt.srcElement) evt.returnValue=msg;
				return msg;
			}
		}
	}
}

//返回
function doBack() {
	if($('#btnAddApos').attr('disabled')) {
		if(validateApos()=='false') return false;//关闭窗口前检查应用终端应用明细设置
	}
	
	if($('#idFlag').val()=='true') {
		window.returnValue='true';
	}
	$('#idIsCheck').val('false');//设置标志值，指示不执行beforeUnload的方法
	window.close();
}

$(function(){
	//初始化分支机构
	defaultQueryReg();
	
	$('#idAposAppInfo').datagrid({
		//iconCls:'icon-save',
		fit:true,
		nowrap: false,
		striped: true,
		collapsible:false,
		sortName: 'KEYID',
		sortOrder: 'desc',
		remoteSort: false,
		idField:'KEYID',
		rownumbers:true,
		//pagination:true,
		//pageSize:10,
		frozenColumns:[[
	              {field:'ck',checkbox:true},
	              {field:'FIELDS',title:'FIELDS',hidden:true},
	              {title:'KEYID',field:'KEYID',hidden:true}
		]],
		columns:[[
			{title:'应用编号',field:'APP_ID',align:'center',width:80,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:120,sortable:true,
				formatter:function(value,rowData,rowIndex) {
					if(rowData.MASTER_APP_FLAG=='1') {
						return value+'(主应用)';
					}else{
						return value;
					}
				}
			},
			{title:'应用版本',field:'APP_VER',align:'center',width:80,sortable:true},
			{title:'应用参数',field:'PARAM_MODEL_ID',align:'center',width:100,sortable:true,
				formatter:function(value,rowData,rowIndex) {
					return '<input type="button" class="btn_grid" onclick="setupAppParam(\''+rowData.APOS_ID+'\',\''+rowData.APP_ID+'\')" value="参数设置"/>';
				}
			},
			{title:'商户',field:'MERCH_ID',align:'center',width:260,sortable:true,
				styler:function(value,rowData,rowIndex){
					if(value!=null && value.length<15) {
						return "color:#ccc;";
					}
				},
				formatter:function(value,rowData,rowIndex) {
					var retString;
					if(rowData.MERCH_NAME!=null) 
						retString = rowData.MERCH_NAME+"("+rowData.MERCH_ID+")";
					else
						retString = rowData.MERCH_ID;
					if(rowData.APP_ID!=null && rowData.APP_ID!='00000000') {
						retString += "&nbsp;&nbsp;";
						retString += "<a href='javascript:void(0)' style='color:blue;' onclick='modifyMerchId(\""+rowData.APOS_ID+"\",\""+rowData.APP_ID+"\",\""+rowData.TERMINAL_ID+"\")'>修改</a>";
					}
					return retString;
				}
			},
			{title:'终端号',field:'TERMINAL_ID',align:'center',width:100,sortable:true,
				formatter:function(value,rowData,rowIndex) {
					var retString="";
					if(value!=null) retString += value;
					if(rowData.APP_ID!=null && rowData.APP_ID!='00000000') {			
						retString += "&nbsp;&nbsp;";
						retString += "<a href='javascript:void(0)' style='color:blue;' onclick='modifyTerminalId(\""+rowData.APOS_ID+"\",\""+rowData.APP_ID+"\",\""+rowData.MERCH_ID+"\")'>修改</a>";
					}
					return retString;
				}
			},
			{title:'操作',field:'SYS_ID',align:'left',width:100,
				formatter:function(value,rowData,rowIndex) {
					if(rowData.APP_ID!=null && rowData.APP_ID=='00000000') {
						return '<input type="button" class="btn_grid" onclick="editAposAppInfo(\''+rowData.APOS_ID+'\',\''+rowData.APP_ID+'\')" value="修改"/>';
					}else{
						var retString = '<input type="button" class="btn_grid" style="margin-right:2px;" onclick="editAposAppInfo(\''+rowData.APOS_ID+'\',\''+rowData.APP_ID+'\')" value="修改"/>';
						retString += '<input type="button" class="btn_grid" onclick="delAposAppInfo(\''+rowData.APOS_ID+'\',\''+rowData.APP_ID+'\')" value="删除"/>';
						return retString;
					}
				}
			}
		]]
	});
});