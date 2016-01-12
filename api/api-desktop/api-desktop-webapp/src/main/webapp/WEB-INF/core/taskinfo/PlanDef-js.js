	$(function(){
		  var k=window.dialogArguments; 
		  if(!k.par){
          	return ;
          }
		  var param = k.par;
		 $('#idRegId').val(param.REG_ID);
		 $('#idRegName').val(param.REG_NAME);
		 $('#idRegEntireId').val(param.REG_ENTIRE_ID);
		  
			$('#idPlanDef').datagrid({
				title:'计划列表',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPlanDefForTask.do',
				queryParams:param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'计划编号',field:'PLAN_CODE',align:'center',width:100,sortable:true},
			{title:'计划名称',field:'PLAN_NAME',align:'center',width:150,sortable:true},
			{title:'创建日期',field:'CREATE_DATE',align:'center',width:150,sortable:true},
			//{title:'计划类型',field:'TYPE_NAME',align:'center',width:100,sortable:true},
			{title:'有效时间',field:'VALID_DATE',align:'center',width:150,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:200,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:100,sortable:true},
			{title:'详细信息',field:'detail',align:'center',width:100,formatter:function(value,rowData,rowIndex){
						var data='';
						data='<input id="iddetail" type="button" class="btn_grid" value="详情" onclick="javascript:showPlanAppInfo(\''+rowData.KEYID+'\')\"/>';
						 return data;
						}}
				]]
			});
			
	
		});
			
	function showPlanAppInfo(sysid){
		var retValue=openDialogFrame(getRootPath()+"/core/plandef/PlanDef-view.jsp",sysid,"800","600");
	}		