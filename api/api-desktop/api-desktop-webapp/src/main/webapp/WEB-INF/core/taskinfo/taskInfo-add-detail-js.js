		//新增应用的datagrid
		$(function(){
		     //var parammodelId=$('#idPlanCode').val();
		     //alert(parammodelId);
			$('#idTaskDetail').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				//url:'listPlanAppInfoForTask.do',//第一次进去无数据，不需要加载
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				//pageSize:20,
				//pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                //{field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				
				columns:[[
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:130,sortable:true},
			{title:'主应用标志',field:'MASTER_APP_FLAG',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
			{title:'参数标志',field:'PARAM_UPDATE_FLAG',align:'center',width:100,sortable:true},
			{title:'应用标志',field:'APP_UPDATE_FLAG',align:'center',width:100,sortable:true},
			{title:'参数模板',field:'PARAM_MODEL_ID',align:'center',width:100,formatter:function(value,rowData,rowIndex){
			             data='<a id="modelId" style="color:blue;" href="javascript:paramModelDefView(\''+rowData.PARAM_MODEL_ID+'\')\">'+rowData.PARAM_MODEL_ID+'</a>';
			             return data;
			             }}
				]]
			});
			defaultQueryReg();
	
		});
		
  function selectPlan(){//选择计划
		var regId = $('#idRegId').val();
		var regName = $('#idRegName').val();
		var regEntireId = $('#idRegEntireId').val();
		var param = {"REG_ID":regId,"REG_NAME":regName,"REG_ENTIRE_ID":regEntireId};
	  var retValue = openDialogFrame(getRootPath()+'/core/taskinfo/PlanDef-index.jsp',param,"800","650");   
	if(retValue!=undefined){
		$('#idPlanCode').val(retValue.plan_code);
		$('#idPlanName').val(retValue.plan_name);
		
		$('#idTaskDetail').datagrid('options').url="listPlanAppInfoForTask.do?PLAN_CODE="+retValue.plan_code;  	
		$('#idTaskDetail').datagrid('load');	
	}
  }
  		
  //选择应用终端
  function selectApos(planCode,aposId){  
		var regId = $('#idRegId').val();
		var regName = $('#idRegName').val();
		var regEntireId = $('#idRegEntireId').val();
		var param = {"REG_ID":regId,"REG_NAME":regName,"REG_ENTIRE_ID":regEntireId};
	var retValue = openDialogFrame(getRootPath()+'/core/taskinfo/AposInfo-index.jsp',param,"800","650");   
	if(retValue!=undefined){//alert(retValue);
		var plan = retValue.split("_");
		$('#idAposIds').val(plan[0]);
		$('#idDevIds').val(plan[1]);
		$('#idserNo').val(plan[2]);
		$('#idAposMids').val(plan[3]);
	}	
  } 
  
  //选择策略
  function selectStrategy(){  
    /*var plan_code = $('#idPlanCode').val();
    var aposId = $('#idAposIds').val();
    if(plan_code==null||Trim(plan_code)==""){
    	msgShow("添加任务","请先选择计划!",'info');
    	return;
    }
    if(aposId==null||Trim(aposId)==""){
    	msgShow("添加任务","请先选择应用终端!",'info');
    	return;
    }*/
	var retValue = openDialogFrame(getRootPath()+'/core/taskinfo/Strategy-index.jsp','',"800","650");   
	if(retValue!=undefined){
		var plan = retValue.split("_");
		$('#idStrategyId').val(plan[0]);
	}	
  }
  		//查看计划的参数模板明细
  	     function paramModelDefView(paramModelId){//alert(paramModelId);
		    	var param={'PARAM_MODEL_ID':paramModelId};
		  		var returnValue= openDialogFrame(getRootPath()+'/core/parammodeldetail/ParamModelDetail-index-view.jsp',param, 650, 450);
		  		//alert(returnValue);
		  }