	$(function(){
		
			$('#idDatalogLine').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listDatalogLine.do',
//				sortName: 'KEYID',
//				sortOrder: 'desc',
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
			{title:'编号',field:'SYS_ID',width:100,align:'center',sortable:true},
			{title:'发生日期',field:'OCCUR_DATE',width:180,align:'center',sortable:true},
			{title:'数据表名',field:'TABLE_NAME',width:150,align:'center',sortable:true},
			{title:'数据操作类型',field:'OP_TYPE',width:100,align:'center',sortable:true},
			{title:'模块名称',field:'NAME',width:100,align:'center',sortable:true},
			//{title:'操作数据',field:'LOG_DATA',width:350,align:'center',sortable:true},
			{title:'分支机构',field:'REG_NAME',width:300,align:'center',sortable:true},
			{title:'操作员编号',field:'OPER_ID',width:150,align:'center',sortable:true}
				]]
			});
			
	
		});
		
