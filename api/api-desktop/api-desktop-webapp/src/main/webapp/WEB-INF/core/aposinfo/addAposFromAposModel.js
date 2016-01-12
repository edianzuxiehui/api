function paramModelDefView(paramModelId){
	var param={'PARAM_MODEL_ID':paramModelId};
	var returnValue= openDialogFrame(getRootPath()+'/core/parammodeldetail/ParamModelDetail-index-view.jsp',param, 700, 500);
}

function addAposFormAposModel() {
	if(!$('#ff').form('validate')) return false;
	var apos_model_id = $('#idAposModelId').val();
	var reg_id = $('#idRegId').val();
	var reg_entire_id = $('#idRegEntireId').val();
	var apos_num = $('#idAposNum').val();
	var apos_addr = $('#idAposAddr').val();
	var strategy_id= $('#idStrategyId').val();
	var tmsModuleId = window.dialogArguments.tmsModuleId;
	var tmsModuleTitle = window.dialogArguments.tmsModuleTitle;
	showProcess(true,"稍等", "正在处理中……");
	$.getJSON('addAposFromModel.do',
		{APOS_MODEL_ID:apos_model_id,REG_ID:reg_id,REG_ENTIRE_ID:reg_entire_id,APOS_NUM:apos_num,APOS_ADDR:escape(apos_addr), STRATEGY_ID:strategy_id,tmsModuleId:tmsModuleId, tmsModuleTitle:escape(tmsModuleTitle)},
		function(data) {
			showProcess(false);
			if(data!=null) {
				if(data.status == 'true') {
					window.returnValue="model";
					window.close();
				}else{
					msgShow("提示消息",data.message,"error");
				}
			}
		});
}

function selectStrategy() {
	var aposNum = $.trim($('#idAposNum').val());
	if(aposNum=="") {
		msgShow('提示','请输入应用终端数量','info');
		return false;
	}else if(isNaN(parseInt(aposNum))) {
		msgShow('提示','所输入应用终端数量无效','info');
		return false;
	}else if(parseInt(aposNum)>100 || parseInt(aposNum)<1) {
		msgShow('提示','应用终端数量为1-100','info');
		return false;
	}
	var obj = new Object(); obj.aposNum = aposNum;
	var retValue = openDialogFrame(getRootPath()+'/core/aposinfo/Strategy-query.jsp',obj,'800','300');
	if(retValue!=undefined) {
		$('#idStrategyId').val(retValue);
	}
}

function pmFormatter(value,rowData,rowIndex){
	var data='<a style="color:blue;text-decoration:none;" href="javascript:void(0)" onclick="paramModelDefView(\''+rowData.PARAM_MODEL_ID+'\')\">'+rowData.PARAM_MODEL_ID+'</a>';
	return data;
}

$(function(){
	$('#idAposModelAppInfo').datagrid({
		fit:true,
		nowrap: false,
		striped: true,
		collapsible:false,
		rownumbers:true
	});
	//初始化应用模板选择下拉列表
	$.getJSON("listValidAposModel.do",null,function(data){
			if (null != data ) {
				for(var i=0;i<data.length;i=i+1) {
					$('#idAposModelId').append("<option value='"+data[i].APOS_MODEL_ID+"' reg_id='"+data[i].REG_ID+"' reg_name='"+data[i].REG_NAME+"' reg_entire_id='"+data[i].REG_ENTIRE_ID+"'>"+data[i].APOS_MODEL_NAME+"("+data[i].REG_NAME+")"+"</option>");
				}
			} 
		}
	);
	//初始化分支机构
	defaultQueryReg();
	//显示应用终端模板明细
	$('#idAposModelId').bind('change',{},function(event) {
		var obj = $('#idAposModelId');
		var apos_model_id = obj.val();
		var reg_id = obj.find('option:selected').attr('reg_id');
		var reg_name = obj.find('option:selected').attr('reg_name');
		var reg_entire_id = obj.find('option:selected').attr('reg_entire_id');
		$('#idRegId').val(reg_id);
		$('#idRegName').val(reg_name);
		$('#idRegEntireId').val(reg_entire_id);
		$('#idAposModelAppInfo').datagrid('options').url="listAposModelAppInfoDetails.do?APOS_MODEL_ID="+apos_model_id;
		$("#idAposModelAppInfo").datagrid('load');
	});
});