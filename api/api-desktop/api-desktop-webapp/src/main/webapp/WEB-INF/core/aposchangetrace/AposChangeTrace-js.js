	$(function(){
		
			$('#idAposChangeTrace').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposChangeTrace.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                //{field:'ck',checkbox:false},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true},
			{title:'换机完成时间',field:'CREATE_DATE',align:'center',width:200,sortable:true},
			{title:'原硬件序列号',field:'OLD_SERIAL_NO',align:'center',width:120,sortable:true},
			{title:'新硬件序列号',field:'NEW_SERIAL_NO',align:'center',width:120,sortable:true},
			{title:'新主机型号',field:'NEW_MID',align:'center',width:120,sortable:true},
			{title:'原主机型号',field:'OLD_MID',align:'center',width:120,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:200,sortable:true}
				]]
			});
	
		});
		
