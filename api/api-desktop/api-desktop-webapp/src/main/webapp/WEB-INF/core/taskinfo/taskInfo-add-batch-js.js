		//新增应用的datagrid
		$(function(){
		     //var parammodelId=$('#idPlanCode').val();
		     //alert(parammodelId);
			$('#idTaskBatch').datagrid({
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
			
			$('#idAposDetail').datagrid({
				//iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                //{field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用终端号',field:'APOS_ID',align:'center',width:120,sortable:true},
			{title:'主机型号',field:'MID',align:'center',width:150,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:150,sortable:true},
			{title:'应用终端明细',field:'aposDetail',align:'center',width:120,sortable:true},
			{title:'任务明细',field:'taskDetail',align:'center',width:120,sortable:true}
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
		//var plan = retValue.split("_");
		//$('#idPlanCode').val(plan[0]);
		//$('#idPlanName').val(plan[1]);
		
		$('#idTaskBatch').datagrid('options').url="listPlanAppInfoForTask.do?PLAN_CODE="+retValue.plan_code;//plan[0];  	
		$('#idTaskBatch').datagrid('load');	
	}
  }
  		
  //选择应用终端
  function selectApos(planCode,aposId){  
		var regId = $('#idRegId').val();
		var regName = $('#idRegName').val();
		var regEntireId = $('#idRegEntireId').val();
		var param = {"REG_ID":regId,"REG_NAME":regName,"REG_ENTIRE_ID":regEntireId,"batchFlag":true};
	var retValue = openDialogFrame(getRootPath()+'/core/taskinfo/AposInfo-index.jsp',param,"950","550");   
	if(retValue!=undefined){
		var rowLen = $('#idAposDetail').datagrid('getRows').length;
		for(var i=rowLen-1;i>=0;i--){
			$('#idAposDetail').datagrid('deleteRow',i);
		}
		
		var datas = retValue.split(",");
		var devIds="";
		var aposIds="";
		var aposMids="";
		for(var i=0;i<datas.length;i++){
			var data = datas[i].split('_');
			devIds +=data[1]+",";
			aposIds +=data[0]+",";
			aposMids +=data[3]+",";
			var item = {'APOS_ID':data[0],'DEV_ID':data[1],'SERIAL_NO':data[2],'MID':data[3],
			'aposDetail':"<a style='color:blue;' href=\"javascript:aposDetail('"+data[0]+"','false')\">应用终端明细</a>",
			'taskDetail':"<a style='color:blue;' href=\"javascript:msgShow('任务明细','添加任务后才能查看!','info');\">任务明细</a>"
			};
			$('#idAposDetail').datagrid('appendRow',item);	
		}
		//$('#idAposDetail').datagrid('acceptChanges');	
		
		if(devIds.length>0){
			devIds = devIds.substring(0,devIds.length-1);
		}
		if(aposIds.length>0){
			aposIds = aposIds.substring(0,aposIds.length-1);
		}
		if(aposMids.length>0){
			aposMids = aposMids.substring(0,aposMids.length-1);
		}
		$('#idDevIds').val(devIds);
		$('#idAposIds').val(aposIds);
		$('#idAposMids').val(aposMids);
	}	
  } 
  
  //选择策略
  function selectStrategy(){  
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
	
  //查看应用终端明细
  function aposDetail(aposId){  
	var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposInfo-view.jsp","APOS_ID="+aposId,"850","450"); 
  }

  //查看任务明细
  function taskDetail(taskSysId,aposId){//TASK_SYS_ID=&PLAN_CODE=&APOS_ID=&REG_ID=&REG_ENTIRE_ID=&PLAN_NAME=
    var param = 'TASK_SYS_ID='+taskSysId+'&PLAN_CODE='+$('#idPlanCode').val()
    			+'&APOS_ID='+aposId+'&REG_ID='+$('#idRegId').val()
    			//+'&REG_ENTIRE_ID='+$('#idRegEntireId').val()
    			+'&PLAN_NAME='+$('#idPlanName').val();  
	var retValue = openDialogFrame(getRootPath()+'/core/taskinfo/TaskInfo-edit.jsp',param,"800","650");   
  }  		  