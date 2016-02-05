	$(function(){
		
			$('#idAposModelAppInfo').datagrid({
				title:'table标题---自己先修改下',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposModelAppInfo.do',
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
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'主应用标志',field:'MASTER_APP_FLAG',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
			{title:'参数模板',field:'PARAM_MODEL_ID',align:'center',width:100,sortable:true},
			{title:'操作',field:'DESC_TXT',align:'center',width:100,sortable:true},
			{title:'分支机构编号',field:'REG_ID',align:'center',width:100,sortable:true}
				]]
			});
			
	
		});
		
