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
	$.getJSON('addAposFromModel.do',
		{APOS_MODEL_ID:apos_model_id,REG_ID:reg_id,REG_ENTIRE_ID:reg_entire_id,APOS_NUM:apos_num,APOS_ADDR:escape(apos_addr), STRATEGY_ID:strategy_id,tmsModuleId:tmsModuleId, tmsModuleTitle:escape(tmsModuleTitle)},
		function(data) {
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
	
	var retValue = openDialogFrame(getRootPath()+'/core/aposinfo/Strategy-query.jsp','','800','300');
	if(retValue!=undefined) {
		$('#idStrategyId').val(retValue);
	}
}

$(function(){
	$('#idAposModelAppInfo').datagrid({
		title:'应用终端模板应用明细',
		fit:true,
		nowrap: false,
		striped: true,
		collapsible:false,
		sortName: 'KEYID',
		sortOrder: 'desc',
		remoteSort: false,
		idField:'KEYID',
		rownumbers:true,
		//pageSize:10,
		//pagination:true,
		frozenColumns:[[
	              {field:'FIELDS',title:'FIELDS',hidden:true},
	              {title:'KEYID',field:'KEYID',hidden:true}
		]],
		columns:[[
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
			{title:'主应用标志',field:'MASTER_FLAG',align:'center',width:100,sortable:true},
			{title:'参数模板',field:'PARAM_MODEL_ID',align:'center',width:100,formatter:function(value,rowData,rowIndex){
					data='<a style="color:blue;text-decoration:none;" href="javascript:void(0)" onclick="paramModelDefView(\''+rowData.PARAM_MODEL_ID+'\')\">'+rowData.PARAM_MODEL_ID+'</a>';
			        return data;
				}	
			}
		]]
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