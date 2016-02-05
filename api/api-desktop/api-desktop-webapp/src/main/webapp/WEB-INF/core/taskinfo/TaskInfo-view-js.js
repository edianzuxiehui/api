	$(function(){
		  var k=window.dialogArguments; 
		  if(!k.par){
          	return ;
          }
		  	var param=k.par;//alert(param.keyid);//a.TASK_SYS_ID||'/'||a.PLAN_CODE||'/'||a.APOS_ID||'/'||b.REG_ID||'/'||b.plan_name
		  	var datas = param.keyid.split('/');
		  	var idTaskSysId = datas[0];
		  	var idPlanCode = datas[1];
		  	var idAposId = datas[2];
		  	var idRegId= datas[3];
		  	var idPlanName= datas[4];
		  	idPlanName=unescape(unescape(idPlanName));
		  	//alert(idTaskSysId); alert(idPlanCode);alert(idAposId);alert(idRegId);alert(idPlanName);
            $('#idTaskSysId').val(idTaskSysId);
          	$('#idPlanCode').val(idPlanCode);
          	$('#idAposId').val(idAposId);
		  	$('#idRegId').val(idRegId);
		  	$('#idPlanName').val(idPlanName);

			param ={'TASK_SYS_ID':idTaskSysId};
			
			$.getJSON("queryTaskInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
					$("#idStrategyId").val($.trim(item.STRATEGY_ID));
					$("#idRegName").val($.trim(item.REG_NAME));
					$("#idDownBtime").val($.trim(item.DOWN_BTIME));
					$("#idDownEtime").val(item.DOWN_ETIME);
				});
		     });
			
			var lastIndex;
			$('#idTaskAppTerminalInfo').datagrid({
				title:'任务应用明细',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listTaskAppTerminalInfo.do',
				queryParams:param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				//pageSize:20,
				pagination:false,
				//rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			//{title:'系统内部编号(使用序列生成的编号)',field:'TASK_SYS_ID',align:'center',width:100,sortable:true},
			//{title:'计划编号',field:'PLAN_CODE',align:'center',width:100,sortable:true},
			//{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true},
			{title:'应用编号',field:'APP_ID',align:'center',width:70,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:70,sortable:true},
			{title:'主应用标志',field:'MASTER_APP_FLAG_NAME',align:'center',width:80,sortable:true},
			{title:'参数列表',field:'PARAM_MODEL_ID',align:'center',width:100,formatter:function(value,rowData,rowIndex){
						return '<input id="paramlist" type="button" class="btn_grid" value="参数列表" onclick="javascript:taskParamDetail(\''+rowData.TASK_SYS_ID+'\',\''+rowData.APP_ID+'\')\"/>'
						;
						}},
			{title:'应用更新标志',field:'APP_UPDATE_FLAG_NAME',align:'center',width:90,sortable:true},
			{title:'参数更新标志',field:'PARAM_UPDATE_FLAG_NAME',align:'center',width:90,sortable:true},
			{title:'商户编码',field:'MERCH_ID',align:'center',width:120,formatter:function(value,rowData,rowIndex){
						if(value.indexOf('T')>=0){//自动生成的商户号不显示
							return "";
						}
						return value;
						}},
			{title:'终端号',field:'TERMINAL_ID',align:'center',width:100,editor:"text"},
			//{title:'分店编码',field:'SUB_ID',align:'center',width:100},
			{title:'更新时间',field:'UPDATE_DATE',align:'center',width:140,sortable:true},
//			{title:'分支机构编号',field:'REG_ID',align:'center',width:100,sortable:true},
//			{title:'机构代码',field:'ORG_ID',align:'center',width:100,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:100,sortable:true}
				]]					
			});

		});

	function taskParamDetail(taskSysId,appId){   
		//alert(taskSysId);alert(appId);
		var param={'TASK_SYS_ID':taskSysId,'APP_ID':appId};
		var retValue=openDialogFrame(getRootPath()+"/core/taskposappparam/TaskPosAppParam-view.jsp",param,"800","450");
	}		