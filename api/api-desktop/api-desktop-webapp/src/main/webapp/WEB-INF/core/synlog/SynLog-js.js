	$(function(){
		
			$('#idSynLog').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listSynLog.do',
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
			{title:'编号',field:'KEYID',width:120,align:'center',sortable:true},
			{title:'更新数据类型',field:'SYN_TYPE',width:120,align:'center',sortable:true},
			{title:'处理文件名',field:'SYN_FILE',width:120,align:'center',sortable:true},
			{title:'是否成功',field:'SYN_STATUS',width:100,align:'center',sortable:true},
			{title:'处理时间',field:'SYN_TIME',width:180,align:'center',sortable:true},
			{title:'处理记录数',field:'RECORD_COUNT',width:120,align:'center',sortable:true},
			{title:'错误记录号/行号',field:'ERROR_COUNT',width:120,align:'center',sortable:true},
			{title:'异常原因',field:'ERROR_MSG',width:150,align:'center',sortable:true}
				]]
			});
			
	
		});
		
